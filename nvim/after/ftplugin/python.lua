vim.opt_local.autoindent = true
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4

vim.keymap.set("n", "<leader>pp", function()
  require("repl").send_repl_line()
end, { buf = 0, desc = "Send line to REPL" })

vim.keymap.set("n", "<leader>vv", function()
  require("repl").send_repl_selection()
end, { buf = 0, desc = "Send selection to REPL" })

vim.keymap.set("x", "<leader>vv", function()
  vim.cmd 'exe "normal \\<Esc>"'
  require("repl").send_repl_selection()
end, { buf = 0, desc = "Send selection to REPL" })

vim.keymap.set("n", "<leader>vp", function()
  vim.cmd 'exe "normal vipj\\<Esc>"'
  require("repl").send_repl_selection()
end, { buf = 0, desc = "Send region to REPL" })

vim.keymap.set("n", "<leader>pb", function()
  vim.cmd 'exe "normal! mmggVG\\<Esc>`m"'
  require("repl").send_repl_selection()
  vim.cmd "delmarks m"
end, { buf = 0, desc = "Send buffer to REPL" })
