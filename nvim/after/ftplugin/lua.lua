vim.opt_local.autoindent = true
vim.opt_local.expandtab = true
vim.opt_local.formatoptions = "tcq2l"
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.tabstop = 4

vim.keymap.set("n", "<leader>qw", "<cmd>lua print('hello there')<CR>", { silent = false })
