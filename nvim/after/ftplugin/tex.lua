local opts = { noremap = true, silent = true }
local map = vim.keymap.set
local opt = vim.opt
local opt_local = vim.opt_local
local g = vim.g

vim.cmd [[
    function! GetFilePath()
        let @" = expand("%:t:r")
    endfunction
]]

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.textwidth = 80
opt.formatoptions:append { "tcqj" }
opt.conceallevel = 2
opt_local.spell = true
opt_local.complete:append { "kspell" }
g.tex_conceal = "abdmgs"
g.tex_flavor = "latex"

map("i", "<C-c><C-j>", "<Esc>o\\item ", opts)
map("i", "<C-c><C-k>", "<Esc>O\\item ", opts)
map("n", "<leader>ij", "<Esc>o\\item ", opts)
map("n", "<leader>ik", "<Esc>O\\item ", opts)
map("n", "<C-c><C-l>", "i\\left<Esc>l%i\\right<Esc>", opts)

map("n", '<leader>cm', ":call GetFilePath()<CR>:FloatermToggle<CR>pdflatex <C-\\><C-n>\"\"pA.tex<CR>", opts)
map("n", '<leader>pv', ":call GetFilePath()<CR>:FloatermToggle<CR>pdflatex <C-\\><C-n>\"\"pA.tex<CR>open <C-\\><C-n>\"\"pA.pdf<CR>", opts)
