vim.opt_local.autoindent = true
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt.complete:remove({ "w", "b" })

vim.keymap.set("n", "<leader>pp", function()
  require("repl").send_repl_line()
end, { buf = true, desc = "Send line to REPL" })

vim.keymap.set("n", "<leader>vv", function()
  require("repl").send_repl_selection()
end, { buf = true, desc = "Send selection to REPL" })

vim.keymap.set("n", "<leader>vp", function()
  vim.cmd 'exe "normal vipj\\<Esc>"'
  require("repl").send_repl_selection()
end, { buf = true, desc = "Send region to REPL" })
