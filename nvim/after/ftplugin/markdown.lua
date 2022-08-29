local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.textwidth = 80
vim.opt.formatoptions:append { 'tcqj' }
vim.opt.conceallevel = 2
vim.opt_local.spell = true
vim.opt_local.complete:append { 'kspell' }

vim.g.tex_conceal = 'abdmg'
vim.g.vim_markdown_math = 1
vim.g.vim_markdown_no_default_key_mappings = 1

map('i', '<C-c><C-j>', '<Esc>o* ', opts)
map('i', '<C-c><C-k>', '<Esc>O* ', opts)
map('n', '<C-c><C-j>', '<Esc>o* ', opts)
map('n', '<C-c><C-k>', '<Esc>O* ', opts)
map('n', '<C-c><C-c>', '<Plug>Markdown_Checkbox', opts)
