vim.keymap.set("i", "zx", "\\", { noremap = true, silent = true, desc = "Insert backslash on 65% keyboard" })
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true
vim.opt_local.textwidth = 80
vim.opt_local.conceallevel = 2
vim.opt_local.formatoptions:append { "tcqj" }
vim.opt_local.linebreak = true
