local utils = require("ah.utils")
local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local nopts = { noremap = true, silent = false }
local term_opts = { silent = true }

map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- normal mode

map("n", "<leader>so", utils.source_lua, opts)

map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

map("n", "<leader>spl", "<cmd>setlocal spell!<CR>", opts)

map("n", "<S-Up>", "<cmd>resize +2<CR>", opts)
map("n", "<S-Down>", "<cmd>resize -2<CR>", opts)
map("n", "<S-Left>", "<cmd>vertical resize -2<CR>", opts)
map("n", "<S-Right>", "<cmd>vertical resize +2<CR>", opts)

map("n", "<S-l>", "<cmd>bnext<CR>", opts)
map("n", "<S-h>", "<cmd>bprevious<CR>", opts)

map("n", "<C-s>", "mm[s1z=`m", opts)

map("n", "<C-n>", "<cmd>cnext<CR>", opts)
map("n", "<C-p>", "<cmd>cprev<CR>", opts)
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

vim.cmd [[
cnoreabbrev bd Bw
]]

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

-- voldikss/vim-floaterm
map("n", "<leader>tt", "<cmd>FloatermToggle<CR>", opts)
map("t", "<leader>tt", "<C-\\><C-n><cmd>FloatermToggle<CR>", opts)
map("n", "<leader>lg", "<cmd>FloatermNew --position=center --wintype=float --width=0.85 --height=0.85 title='lazygit' lazygit<CR>", opts)
map("n", "<leader>bt", "<cmd>FloatermNew --position=center --wintype=float --width=0.85 --height=0.85 title='system monitor' btm<CR>", opts)

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
    "luafile ~/.config/nvim/lua/plugins/init.lua",
    false
  )
  vim.api.nvim_exec("PackerSync", false)
end, opts)

-- misc commands

vim.cmd [[
command! -nargs=1 Search vimgrep <args> ~/Dropbox/notes/MyNotes/**/*.{tex,md}
]]
map("n", "<leader>[", "<cmd>Search ", nopts)

vim.api.nvim_buf_create_user_command(0, "Search ", "vimgrep <args> ~/Dropbox/notes/MyNotes/**/*.{tex,md}", {})

map("n", "<leader>fl", utils.open_float, opts)
