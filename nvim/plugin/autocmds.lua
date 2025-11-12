vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank {
      higroup = "Visual",
      timeout = 100,
    }
  end,
})

-- restore cursor position
local cursor_augroup = vim.api.nvim_create_augroup("CursorPosition", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "help" then
      vim.cmd "wincmd L"
      vim.cmd "vertical resize -12"
    end
  end,
})
