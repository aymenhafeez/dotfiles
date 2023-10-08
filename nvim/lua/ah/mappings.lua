local utils = require("ah.utils")
local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local nopts = { noremap = true, silent = false }
local term_opts = { silent = true }

map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- normal mode

map("n", "<leader>ll", vim.cmd.Lazy, opts)

map("n", "<S-l>", vim.cmd.bnext, opts)
map("n", "<S-h>", vim.cmd.bprev, opts)

map("n", "<leader>ls", vim.cmd.LspStart, opts)

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

map("n", "<leader>hh", function()
  return ":help " .. vim.fn.expand("<cword>") .. "<CR>"
end, { expr = true })

-- map("n", "<leader>hs", function()
--   utils.float_help()
-- end, opts)

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

map("n", "<leader>cn", vim.cmd.cnext, opts)
map("n", "<leader>cp", vim.cmd.cprev, opts)
map("n", "<leader>cl", vim.cmd.ccl, opts)

map("n", "<leader>mm", vim.cmd.Messages, nopts)

map("n", "<leader>hl", vim.cmd.nohlsearch, nopts)

map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

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

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- terminal

map("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
map("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
map("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
map("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- plugin mappings

-- nvim-neo-tree/neo-tree.nvim
map("n", "<leader>-", "<cmd>Neotree toggle<CR>", opts)

-- akinsho/toggleterm.nvim
map("n", "<leader>tt", "<cmd>ToggleTerm direction=horizontal<CR>", opts)
map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", opts)
map("n", "<leader>gt", "<cmd>terminal<CR>", opts)
map("t", "<leader>tt", "<C-\\><C-n><cmd>ToggleTerm<CR>", opts)

-- aymenhafeez/scratch.nvim
map("n", "<leader>ss", vim.cmd.Scratch, opts)

-- -- Pocco81/true-zen.nvim
-- map("n", "<leader>zz", vim.cmd.TZMinimalist, opts)
-- map("n", "<leader>zx", vim.cmd.TZAtaraxis, opts)

-- "folke/zen-mode.nvim"
map("n", "<leader>zz", vim.cmd.ZenMode, opts)

-- nvim-treesitter/playground
map("n", "<leader>hi", vim.cmd.TSHighlightCapturesUnderCursor, opts)

-- aymenhafeez/OxfDictionary.nvim
map("n", "<leader>dd", vim.cmd.Definition, opts)

-- map("n", "<leader>rn", function()
--   return ":IncRename " .. vim.fn.expand("<cword>")
-- end, { expr = true})
