local M = {}

M.job_id = nil

local get_selection = function()
  local start_pos = vim.api.nvim_buf_get_mark(0, "<")
  local end_pos = vim.api.nvim_buf_get_mark(0, ">")
  local text = vim.api.nvim_buf_get_text(0, start_pos[1] - 1, start_pos[2], end_pos[1] - 1, end_pos[2] + 1, {})

  return table.concat(text, "\n")
end

M.create_repl = function()
  local width = math.floor(vim.o.columns * 0.45)
  local win_width = vim.api.nvim_win_get_width(0)
  if not M.job_id then
    if win_width < 180 then
      vim.cmd("botright 15new")
    else
      vim.cmd(width .. "vnew")
    end
    M.job_id = vim.fn.jobstart({ "ipython" }, {
      term = true,
      on_exit = function()
        M.job_id = nil
      end,
    })

    vim.wait(100, function()
      return false
    end)
  end
end

M.send_repl_line = function()
  M.create_repl()

  vim.fn.chansend(M.job_id, vim.fn.getline "." .. "\n")
end

M.send_repl_selection = function()
  M.create_repl()

  local selection = get_selection()
  local bracketed_paste_start = "\x1b[200~"
  local bracketed_paste_end = "\x1b[201~"

  vim.fn.chansend(M.job_id, bracketed_paste_start .. selection .. bracketed_paste_end .. "\n")
  vim.wait(50, function() return false end)
end

return M
