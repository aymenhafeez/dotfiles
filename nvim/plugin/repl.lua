local job_id = nil

local get_selection = function()
  local start_pos = vim.api.nvim_buf_get_mark(0, "<")
  local end_pos = vim.api.nvim_buf_get_mark(0, ">")
  local text = vim.api.nvim_buf_get_text(0, start_pos[1] - 1, start_pos[2], end_pos[1] - 1, end_pos[2] + 1, {})

  return table.concat(text, "\n")
end

local create_repl = function()
  local width = math.floor(vim.o.columns * 0.45)
  local win_width = vim.api.nvim_win_get_width(0)
  if not job_id then
    if win_width < 180 then
      vim.cmd(35 .. "new")
    else
      vim.cmd(width .. "vnew")
    end
    job_id = vim.fn.jobstart({ "ipython" }, {
      term = true,
      on_exit = function()
        job_id = nil
      end,
    })

    vim.wait(100, function()
      return false
    end)
  end
end

local send_repl_line = function()
  create_repl()

  vim.fn.chansend(job_id, vim.fn.getline "." .. "\n")
end

local function dedent_text(text)
  local lines = vim.split(text, "\n", { plain = true })
  local min_indent = math.huge

  for _, line in ipairs(lines) do
    if line:match("%S") then
      local indent = line:match("^(%s*)"):len()
      min_indent = math.min(min_indent, indent)
    end
  end

  if min_indent == math.huge then
    return text
  end

  local result = {}
  for _, line in ipairs(lines) do
    table.insert(result, line:sub(min_indent + 1))
  end

  return table.concat(result, "\n") .. "\n"
end

local function send_repl_selection()
  create_repl()

  local selection = get_selection()
  local dedented = dedent_text(selection)

  dedented = dedented:gsub("\n$", "")

  -- use bracketed paste mode to prevent REPL auto-indentation
  local bracketed_paste_start = "\027[200~"
  local bracketed_paste_end = "\027[201~"

  vim.fn.chansend(job_id, bracketed_paste_start .. dedented .. bracketed_paste_end)

  -- Small delay to let bracketed paste finish before sending execute command
  vim.wait(50, function() return false end)

  vim.fn.chansend(job_id, "\n")
end

vim.keymap.set("n", "<leader>pp", function() send_repl_line() end)

vim.keymap.set("n", "<leader>vv", function() send_repl_selection() end)

vim.keymap.set("n", "<leader>vp", function()
  vim.cmd 'exe "normal vipj\\<Esc>"'
  send_repl_selection()
end)
