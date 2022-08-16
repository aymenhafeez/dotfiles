local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap


vim.cmd [[
    function! GetFilePath()
        let @" = expand("%:t:r")
    endfunction
]]

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.textwidth = 80
vim.opt.formatoptions:append{ 'tcqj' }
vim.opt.conceallevel = 2
vim.g.tex_conceal = 'abdmg'
vim.opt_local.spell = true
vim.opt_local.complete:append{ 'kspell' }

map('i', '<C-c><C-j>', '<Esc>o\\item ', opts)
map('i', '<C-c><C-k>', '<Esc>O\\item ', opts)
map('n', '<C-c><C-j>', '<Esc>o\\item ', opts)
map('n', '<C-c><C-k>', '<Esc>O\\item ', opts)
map('n', '<C-c><C-l>', 'i\\left<Esc>l%i\\right<Esc>', opts)

map('n', '<leader>cm', ':call GetFilePath()<CR>:FloatermToggle<CR>pdflatex <C-\\><C-n>""pA.tex<CR>', opts)
map('n', '<leader>pv', ':call GetFilePath()<CR>:FloatermToggle<CR>pdflatex <C-\\><C-n>""pA.tex<CR>open <C-\\><C-n>""pA.pdf<CR>', opts)
