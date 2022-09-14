local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap
local opt = vim.opt
local opt_local = vim.opt_local
local g = vim.g

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.textwidth = 80
opt.formatoptions:append { "tcqj" }
opt.conceallevel = 2
opt_local.spell = true
opt_local.complete:append { "kspell" }

g.tex_conceal = 'abdmg'
g.vim_markdown_math = 1
g.vim_markdown_no_default_key_mappings = 1
g.scratch_filetype = "markdown"

map("i", "<C-c><C-j>", "<Esc>o* ", opts)
map("i", "<C-c><C-k>", "<Esc>O* ", opts)
map("n", "<leader>ij", "<Esc>o* ", opts)
map("n", "<leader>ik", "<Esc>O* ", opts)
map("n", "<leader>cc", "<Plug>Markdown_Checkbox", opts)
