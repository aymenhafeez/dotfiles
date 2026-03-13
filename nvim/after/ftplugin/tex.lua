local map = vim.keymap.set
local opt = vim.opt
local opt_local = vim.opt_local
local g = vim.g

opt.conceallevel = 2
opt_local.tabstop = 4
opt_local.shiftwidth = 4
opt_local.expandtab = true
opt_local.textwidth = 85
opt_local.formatoptions:append { "tcqj" }
opt_local.spell = true
opt_local.complete:append { "kspell", "f" }
g.tex_conceal = "abdmgs"
g.tex_flavor = "latex"

map("i", "<Space>", "<Space><C-g>u", { desc = "Break undo sequence on space" })
map("i", "<Tab>", "<Tab><C-g>u", { desc = "Break undo sequence on tab" })

map({ "n", "i" }, "<C-c><C-j>", "<Esc>o\\item ", { buffer = true, desc = "New item below" })
map({ "n", "i" }, "<C-c><C-k>", "<Esc>O\\item ", { buffer = true, desc = "New item above" })

local function get_dynamic_width()
  return vim.o.columns > 150 and 'right' or 'below'
end

local file_name = vim.fn.expand "%:t:r"

map("n", "<leader>cm", function()
  require("terminal").toggle_terminal({
    name = "latex compile",
    direction = get_dynamic_width(),
    cmd =
        "latexmk -pdf -interaction=nonstopmode -halt-on-error -output-directory=build " .. file_name
  })
end, { desc = "Compile LaTeX" })

map("n", "<leader>pv", function()
  vim.cmd(":!xdg-open build/" .. vim.fn.expand "%:t:r" .. ".pdf")
end, { desc = "Preview PDF" })

map("n", "<C-s>", "mm[s1z=`m", { desc = "Fix previous spelling error" })
map("i", "<C-s>", "<C-g>u<Esc>[s1z=`]a<C-g>u", { desc = "Fix previous spelling error" })

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
