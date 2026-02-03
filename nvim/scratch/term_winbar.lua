-- seems to work well, move to plugin/

vim.api.nvim_set_hl(0, "TerminalWinbarActive", { link = "Normal" })
vim.api.nvim_set_hl(0, "TerminalWinbarInactive", { link = "LineNr" })

local function term_winbar()
  local current_buf = vim.api.nvim_get_current_buf()
  local buflist = vim.api.nvim_list_bufs()
  local items = {}

  local terminals = {}
  for _, buf in ipairs(buflist) do
    if vim.api.nvim_buf_is_loaded(buf) and
        vim.api.nvim_get_option_value("buftype", { buf = buf }) == "terminal" then
      table.insert(terminals, buf)
    end
  end

  table.sort(terminals)

  for _, buf in ipairs(terminals) do
    local bufname = vim.api.nvim_buf_get_name(buf)
    local job_id, command = bufname:match("term://.*//(%d+):(.*)")
    local title = command or "term-" .. buf

    if command then
      if title:match("/") then -- /usr/bin/fish -> fish)
        title = title:match("([^/]+)$")
      end

      if #title > 20 then
        title = title:sub(1, 17) .. "..."
      end
    end

    local item
    if buf == current_buf then
      item = "%#TerminalWinbarActive#" .. title .. "%*"
    else
      item = "%#TerminalWinbarInactive#" .. title .. "%*"
    end

    table.insert(items, item)
  end

  if #items == 0 then
    return ""
  end

  return table.concat(items, " ")
end

-- need to update all terminal winbars
local function update_all_terminal_winbars()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_buf_is_valid(buf) and
        vim.api.nvim_get_option_value("buftype", { buf = buf }) == "terminal" then
      vim.wo[win].winbar = term_winbar()
    end
  end
end

local group = vim.api.nvim_create_augroup("TerminalSettings", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
  group = group,
  pattern = "*",
  callback = function()
    vim.opt_local.cursorline = false
    vim.opt_local.scrolloff = 0
    vim.wo.statuscolumn = ""
    vim.wo.winfixwidth = true
    vim.wo.winfixheight = true
    vim.bo.filetype = "terminal"
  end,
})

-- update winbar on terminal events
vim.api.nvim_create_autocmd({ "TermOpen", "TermEnter", "TermLeave", "BufEnter", "BufDelete" }, {
  group = group,
  callback = update_all_terminal_winbars,
})
