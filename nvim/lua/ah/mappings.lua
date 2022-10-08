local utils = require("ah.utils")
local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local nopts = { noremap = true, silent = false }
local term_opts = { silent = true }

map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- normal mode

map("n", "<leader>ls", "<cmd>LspStart<CR>", opts)

map("n", "<leader>lg", function()
  utils.float_terminal("lazygit")
end, opts)

map("n", "<leader>ht", function()
  utils.float_terminal("htop")
end, opts)

map("n", "<leader>bt", function()
  utils.float_terminal("btm")
end, opts)

map("n", "<leader><leader>t", function()
  utils.float_terminal("zsh")
end, opts)

map("n", "<leader>hh", "\"tyiw:help <C-r>t<CR>", opts)

map("n", "<leader>so", utils.source_lua, nopts)
map("n", "<leader><leader>x", utils.execute_line, nopts)
map("n", "<leader><leader>r", utils.reload_config, opts)

map("n", "<leader><leader>c", ":<up>", nopts)

map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "gj", "<cmd>let _=&lazyredraw<CR><cmd>set lazyredraw<CR>/\\%<C-R>=virtcol('.')<CR>v\\S<CR><cmd>nohl<CR><cmd>let &lazyredraw=_<CR>", opts)
map("n", "gk", "<cmd>let _=&lazyredraw<CR><cmd>set lazyredraw<CR>?\\%<C-R>=virtcol('.')<CR>v\\S<CR><cmd>nohl<CR><cmd>let &lazyredraw=_<CR>", opts)

map("n", "<leader><leader>s", "<cmd>setlocal spell!<CR>", opts)

map("n", "<S-Up>", "<cmd>resize +1<CR>", opts)
map("n", "<S-Down>", "<cmd>resize -1<CR>", opts)
map("n", "<S-Left>", "<cmd>vertical resize -1<CR>", opts)
map("n", "<S-Right>", "<cmd>vertical resize +1<CR>", opts)

map("n", "<C-s>", "mm[s1z=`m", opts)

map("n", "<leader>cn", "<cmd>cnext<CR>", opts)
map("n", "<leader>cp", "<cmd>cprev<CR>", opts)
map("n", "<leader>cl", "<cmd>ccl<CR>", opts)

map("n", "<leader>mm", "<cmd>Message<CR>", nopts)

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

-- vim.cmd("cnoreabbrev bd Bw")
-- vim.api.nvim_cmd({ cmd = "cnoreabbrev", args = { "bd Bw" } }, {})
vim.cmd.cnoreabbrev("bd Bw")

-- visual mode

map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

map("v", "<leader>so", ":<C-w>exe join(getline(\"'<\",\"'>\"),'<Bar>')<CR>", opts)

map("x", "J", "<cmd>move '>+1<CR>gv-gv", opts)
map("x", "K", "<cmd>move '<-2<CR>gv-gv", opts)

-- terminal

map("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
map("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
map("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
map("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- plugin mappings

-- romgrk/barbar.nvim
map("n", "<S-l>", "<cmd>BufferNext<CR>", opts)
map("n", "<S-h>", "<cmd>BufferPrevious<CR>", opts)
-- map("n", "<S-l>", "<cmd>bnext<CR>", opts)
-- map("n", "<S-h>", "<cmd>bprev<CR>", opts)

-- kyazdani42/nvim-tree.lua
map("n", "<leader>-", "<cmd>NvimTreeToggle<CR>", opts)
map("n", "<leader>f-", "<cmd>NvimTreeFindFile<CR>", opts)

-- akinsho/toggleterm.nvim
map("n", "<leader>tt", "<cmd>ToggleTerm direction=horizontal<CR>", opts)
-- map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", opts)
map("t", "<leader>tt", "<C-\\><C-n><cmd>ToggleTerm<CR>", opts)

-- aymenhafeez/scratch.vim
map("n", "<leader>sc", "<cmd>Scratch<CR>", opts)
map("n", "<leader>ss", "<cmd>Sscratch<CR>", opts)

-- Pocco81/true-zen.nvim
map("n", "<leader>zz", "<cmd>TZMinimalist<CR>", opts)
map("n", "<leader>zx", "<cmd>TZAtaraxis<CR>", opts)

-- nvim-treesitter/playground
map("n", "<leader>hi", "<cmd>TSHighlightCapturesUnderCursor<CR>", opts)

-- aymenhafeez/OxfDictionary.nvim
map("n", "<leader>dd", "<cmd>Definition<CR>", opts)

-- wbthomason/packer.nvim
map("n", "<leader>ps", function()
  vim.api.nvim_exec("source ~/.config/nvim/lua/plugins/init.lua | PackerSync", false)
end, opts)
