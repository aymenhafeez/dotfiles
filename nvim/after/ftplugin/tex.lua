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

map("i", "<C-c><C-j>", "<Esc>o\\item ", { noremap = true, silent = true, desc = "New item below"})
map("i", "<C-c><C-k>", "<Esc>O\\item ", { noremap = true, silent = true, desc = "New item above" })
map("n", "<C-c><C-j>", "<Esc>o\\item ", { noremap = true, silent = true, desc = "New item below" })
map("n", "<C-c><C-k>", "<Esc>O\\item ", { noremap = true, silent = true, desc = "New item above" })
map("n", "<C-c><C-l>", "i\\left<Esc>l%i\\right<Esc>", { noremap = true, silent = true })

map("n", "<leader>cm", "<cmd>TermExec cmd='pdflatex %'<CR>", { noremap = true, silent = true, desc = "Compile to PDF" })
map("n", "<leader>pv", "<cmd>TermExec cmd='open %:t:r.pdf'<CR>", { desc = "Open PDF preview" })
