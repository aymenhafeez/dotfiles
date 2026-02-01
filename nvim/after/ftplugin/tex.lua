local map = vim.keymap.set
local opt = vim.opt
local opt_local = vim.opt_local
local g = vim.g

opt.conceallevel = 2
opt_local.tabstop = 4
opt_local.shiftwidth = 4
opt_local.expandtab = true
opt_local.textwidth = 80
opt_local.formatoptions:append { "tcqj" }
opt_local.spell = true
opt_local.complete:append { "kspell" }
g.tex_conceal = "abdmgs"
g.tex_flavor = "latex"

-- break undo sequence on space, tab and enter
map("i", "<Space>", "<Space><C-g>u")
map("i", "<Tab>", "<Tab><C-g>u")
map("i", "<CR>", "<CR><C-g>u")


map({ "n", "i" }, "<C-c><C-j>", "<Esc>o\\item ", { noremap = true, silent = true, desc = "New item below" })
map({ "n", "i" }, "<C-c><C-k>", "<Esc>O\\item ", { noremap = true, silent = true, desc = "New item above" })

local file_name = vim.fn.expand "%:t:r"
map(
  "n",
  "<leader>cm",
  "<cmd>lua require('terminal').toggle_terminal({name = 'latex compile', cmd='latexmk -pdf -interaction=nonstopmode -halt-on-error -output-directory=build "
  .. file_name
  .. "'})<CR>"
)

map("n", "<leader>pv", function()
  vim.cmd(":!xdg-open build/" .. vim.fn.expand "%:t:r" .. ".pdf")
end)

-- my keyboard doesn't have a backslash
map("i", "zx", "\\")

map("n", "<C-s>", "mm[s1z=`m", { desc = "Correct previous spelling error" })
map("i", "<C-s>", "<C-g>u<Esc>[s1z=`]a<C-g>u", { desc = "Correct previous spelling error" })

vim.g.vimtex_imaps_enabled = false
vim.g.vimtex_mappings_enabled = false
vim.g.vimtex_view_enabled = true
vim.g.vimtex_view_general_viewer = "okular"
vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
vim.keymap.set("n", "<leader>ct", "<cmd>VimtexTocToggle<CR>", { desc = "Toggle contents" })
