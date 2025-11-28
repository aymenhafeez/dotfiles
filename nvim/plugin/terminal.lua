local group = vim.api.nvim_create_augroup("TerminalSettings", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
  group = group,
  pattern = "*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.cursorline = false
    vim.opt_local.scrolloff = 0
    vim.wo.winfixwidth = true
    vim.wo.winfixheight = true
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = group,
  pattern = "*",
  callback = function()
    if vim.bo.buftype == "terminal" then
      vim.cmd "startinsert"
    end
  end,
})
