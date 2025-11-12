vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("term_local_settings", {}),
  pattern = "*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.cursorline = false
    vim.opt_local.scrolloff = 0
  end,
})

vim.keymap.set("n", "<leader>st", function()
  vim.cmd.new()
  vim.cmd.wincmd "J"
  vim.api.nvim_win_set_height(0, 15)
  vim.wo.winfixheight = true
  vim.cmd.term()
  vim.cmd "startinsert"
end)
