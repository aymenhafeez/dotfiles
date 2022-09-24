local utils = require("ah.utils")
local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local nopts = { noremap = true, silent = false }
local term_opts = { silent = true }

map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- normal mode

map("n", "<leader>so", utils.source_lua, nopts)
map("n", "<leader><leader>r", utils.reload_config, opts)

map("n", "<leader>td", utils.make_todo, nopts)

-- map("n", "<C-e>", "4<C-e>", opts)
-- map("n", "<C-y>", "4<C-y>", opts)

map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

map("n", "<leader>spl", "<cmd>setlocal spell!<CR>", opts)

map("n", "<S-Up>", "<cmd>resize +1<CR>", opts)
map("n", "<S-Down>", "<cmd>resize -1<CR>", opts)
map("n", "<S-Left>", "<cmd>vertical resize -2<CR>", opts)
map("n", "<S-Right>", "<cmd>vertical resize +2<CR>", opts)

map("n", "<S-l>", "<cmd>bnext<CR>", opts)
map("n", "<S-h>", "<cmd>bprevious<CR>", opts)

map("n", "<C-s>", "mm[s1z=`m", opts)

map("n", "<leader>cn", "<cmd>cnext<CR>", opts)
map("n", "<leader>cp", "<cmd>cprev<CR>", opts)
map("n", "<leader>cl", "<cmd>ccl<CR>", opts)

map("n", "<leader>mm", "<cmd>message<CR>", nopts)

map("n", "<leader>hl", "<cmd>nohlsearch<CR>", nopts)

-- insert mode

map("i", "<C-s>", "<C-g>u<Esc>[s1z=`]a<C-g>u", opts)

map("i", "<Space>", "<Space><C-g>u", opts)
map("i", "<CR>", "<CR><C-g>u", opts)

-- command-line mode

map("c", "<C-a>", "<Home>", nopts)
map("c", "<C-b>", "<Left>", nopts)
map("c", "<C-f>", "<Right>", nopts)
map("c", "<M-b>", "<S-Left>", nopts)
map("c", "<M-f>", "<S-Right>", nopts)
map("c", "<C-p>", "<Up>", nopts)
map("c", "<C-n>", "<Down>", nopts)

vim.cmd("cnoreabbrev bd Bw")

-- visual mode

map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

map("v", "<leader>so", "\"ay:<C-r>a<Backspace><CR>", opts)

map("x", "J", "<cmd>move '>+1<CR>gv-gv", opts)
map("x", "K", "<cmd>move '<-2<CR>gv-gv", opts)

-- terminal

map("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
map("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
map("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
map("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- plugin mappings

-- kyazdani42/nvim-tree.lua
map("n", "<leader>-", "<cmd>NvimTreeToggle<CR>", opts)
map("n", "<leader>f-", "<cmd>NvimTreeFindFile<CR>", opts)

--[[ -- voldikss/vim-floaterm
local floaterm_opts = "--position=center --wintype=float --width=0.85 --height=0.85"

map("n", "<leader>tt", "<cmd>FloatermToggle<CR>", opts)
map("t", "<leader>tt", "<C-\\><C-n><cmd>FloatermToggle<CR>", opts)
map("n", "<leader>lg", "<cmd>FloatermNew " .. floaterm_opts .. " lazygit<CR>", opts)
map("n", "<leader>bt", "<cmd>FloatermNew " .. floaterm_opts .. " btm<CR>", opts)
map("n", "<leader>ht", "<cmd>FloatermNew " .. floaterm_opts .. " htop<CR>", opts) ]]

-- akinsho/toggleterm.nvim
map("n", "<leader>tt", "<cmd>ToggleTerm direction=horizontal<CR>", opts)
map("t", "<leader>tt", "<C-\\><C-n><cmd>ToggleTerm<CR>", opts)
map("n", "<leader>lg", "<cmd>TermExec direction=float cmd='lazygit'<CR>", opts)
map("n", "<leader>bt", "<cmd>TermExec direction=float cmd='btm'<CR>", opts)
map("n", "<leader>ht", "<cmd>TermExec direction=float cmd='htop'<CR>", opts)

-- aymenhafeez/scratch.vim
map("n", "<leader>sc", "<cmd>Scratch<CR>", opts)
map("n", "<leader>ss", "<cmd>Sscratch<CR>", opts)

-- Pocco81/true-zen.nvim
map("n", "<leader>z", "<cmd>TZMinimalist<CR>", opts)
map("n", "<leader>x", "<cmd>TZAtaraxis<CR>", opts)

-- nvim-treesitter/playground
map("n", "<leader>hi", "<cmd>TSHighlightCapturesUnderCursor<CR>", opts)

-- aymenhafeez/OxfDictionary.nvim
map("n", "<leader>dd", "<cmd>Definition<CR>", opts)

-- wbthomason/packer.nvim
map("n", "<leader>ps", function()
  vim.api.nvim_exec(
    "source ~/.config/nvim/lua/plugins/init.lua | PackerSync",
    false
  )
end, opts)
