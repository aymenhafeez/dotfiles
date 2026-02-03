require("scratch").setup()

vim.keymap.set("n", "<leader>ss", function() require("scratch").toggle() end)
vim.keymap.set("n", "<leader>fs", function() require("scratch").toggle { window_type = "float" } end)

vim.keymap.set("n", "<leader>ps", function()
  local buf_nr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf_nr, 0, -1, false)

  require("scratch").toggle { window_type = "float" }
  vim.api.nvim_buf_set_lines(0, 0, -1, true, lines)
end)
