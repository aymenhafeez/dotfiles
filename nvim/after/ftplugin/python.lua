local opts = { noremap = true, silent = true }
local nopts = { noremap = true, silent = false }
local map = vim.api.nvim_set_keymap

vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.opt_local.makeprg = 'pylint\\ --output-format=parseable'
vim.cmd [[
    command! -nargs=0 Lint :make %
]]

vim.cmd [[
    function! GetFilePath()
        let @" = '%run ' . expand("%:p")
    endfunction
]]

vim.g.floaterm_height = 13

map('n', '<leader>py', ':%w !python3<CR>', nopts)
map('n', '<leader>px', 'mxVgg:%w !python3<CR>`x', nopts)
map('x', '<leader>py', ':%w !python3<CR>', nopts)

map('n', '<C-c><C-p>', ':FloatermNew ipython<CR><C-\\><C-n><C-w>k', opts)
map('n', '<C-c><C-c>', ':call GetFilePath()<CR>:FloatermToggle<CR><C-\\><C-n>""pA<CR><C-\\><C-n><C-w>k', opts)
map('v', '<C-c><C-c>', 'y:FloatermToggle<CR><C-\\><C-n>""pA<CR><C-\\><C-n><C-w>k', opts)
