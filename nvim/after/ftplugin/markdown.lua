vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true
vim.opt_local.textwidth = 88
vim.opt_local.conceallevel = 2
vim.opt_local.concealcursor = "n"
vim.opt_local.formatoptions:append("tcqj")
vim.opt_local.linebreak = true
vim.wo.number = false
vim.wo.relativenumber = false
vim.wo.spell = true
vim.wo.wrap = true

vim.g.markdown_fenced_languages = { "lua", "vim", "json", "shell=sh", "python", "sh", "console=sh" }

vim.keymap.set("n", "<C-s>", "mm[s1z=`m", { buf = 0, desc = "Fix previous spelling error" })
vim.keymap.set("i", "<C-s>", "<C-g>u<Esc>[s1z=`]a<C-g>u", { buf = 0, desc = "Fix previous spelling error" })

vim.pack.add({
  "https://github.com/toppair/peek.nvim",
}, { load = true })

require("peek").setup {
  app = { "firefox", "--new-window" }
}

vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
