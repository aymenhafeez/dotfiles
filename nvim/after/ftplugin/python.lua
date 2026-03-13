vim.opt_local.autoindent = true
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.cmd "set complete-=b"

local repl = require("repl")

vim.keymap.set("n", "<leader>pp", function()
  repl.send_repl_line()
end, { desc = "Send line to REPL" })

vim.keymap.set("n", "<leader>vv", function()
  repl.send_repl_selection()
end, { desc = "Send selection to REPL" })

vim.keymap.set("n", "<leader>vp", function()
  vim.cmd 'exe "normal vipj\\<Esc>"'
  repl.send_repl_selection()
end, { desc = "Send region to REPL" })
