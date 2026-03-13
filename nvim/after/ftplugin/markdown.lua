vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true
vim.opt_local.textwidth = 80
vim.opt_local.conceallevel = 2
vim.opt_local.formatoptions:append { "tcqj" }
vim.opt_local.linebreak = true

vim.g.markdown_fenced_languages = { "lua", "vim", "json", "shell=sh", "python", "sh", "console=sh" }

vim.pack.add({
  "https://github.com/toppair/peek.nvim",
}, { load = true })

require("peek").setup {
  app = { "firefox", "--new-window" }
}

vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})

require("mini.snippets").setup {
  snippets = {
    require('mini.snippets').gen_loader.from_lang(),
  },
  mappings = {
    expand = '<C-j>',
    jump_next = '<C-j>',
    jump_prev = '<C-k>',
    stop = '<C-c>',
  },
}
