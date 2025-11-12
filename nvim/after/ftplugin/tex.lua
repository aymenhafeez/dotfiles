local map = vim.keymap.set
local opt = vim.opt
local opt_local = vim.opt_local
local g = vim.g

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

map({ "n", "i" }, "<C-c><C-j>", "<Esc>o\\item ", { noremap = true, silent = true, desc = "New item below" })
map({ "n", "i" }, "<C-c><C-k>", "<Esc>O\\item ", { noremap = true, silent = true, desc = "New item above" })

local file_name = vim.fn.expand("%:t:r")
map("n", "<leader>cm", ":TermTog latexmk -pdf -interaction=nonstopmode -halt-on-error -output-directory=build " .. file_name .. "<CR><C-\\><C-n>G")

map("n", "<leader>pv", function()
  vim.cmd(":!open build/" .. vim.fn.expand("%:t:r") .. ".pdf")
end)

-- my keyboard doesn't have a backslash
map("i", "zx", "\\")
