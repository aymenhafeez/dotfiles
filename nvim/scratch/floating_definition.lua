local float_definition = function()
  local definition = vim.lsp.buf.definition()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local buf = vim.api.nvim_get_current_buf()

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
  })
  return win
end

vim.keymap.set("n", "<leader>dd", float_definition)
