local map = vim.keymap.set
local utils = require("ah.utils")

map("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- normal mode

map("n", "<leader>ll", vim.cmd.Lazy,
  {
    noremap = true,
    silent = true,
    desc = "Manage Lazy"
  })

map("n", "<S-l>", vim.cmd.BufferLineCycleNext, { noremap = true, silent = true, desc = "Cycle to next buffer" })
map("n", "<S-h>", vim.cmd.BufferLineCyclePrev, { noremap = true, silent = true, desc = "Cycle to previous buffer" })

map("n", "<leader>ls", vim.cmd.LspStart, { noremap = true, silent = true, desc = "Star language server" })

map("n", "<leader>lg", function()
  utils.float_terminal("lazygit")
end, { noremap = true, silent = true, desc = "Open LazyGit" })

map("n", "<leader>ht", function()
  utils.float_terminal("htop")
end, { noremap = true, silent = true, desc = "Open htop" })

map("n", "<leader>bt", function()
  utils.float_terminal("btm")
end, { noremap = true, silent = true, desc = "Open btm" })

map("n", "<leader><leader>t", function()
  utils.float_terminal("zsh")
end, { noremap = true, silent = true, desc = "Floating terminal" })

map("n", "<leader>hh", function()
  return ":help " .. vim.fn.expand("<cword>") .. "<CR>"
end, { expr = true, desc = "Help for current word" })

map("n", "<leader>so", utils.source_lua, { noremap = true, silent = false, desc = "Source file" })
map("n", "<leader><leader>x", utils.execute_line, { noremap = true, silent = false, desc = "Execute current line" })
map("n", "<leader><leader>r", utils.reload_config, { noremap = true, silent = true, desc = "Reload config" })

map("n", "<leader><leader>c", ":<up>", { noremap = true, silent = false, desc = "Show previous cmdline command" })

map("n", "<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "Move to window below" })
map("n", "<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "Move to window above" })
map("n", "<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "Move to right window" })

map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "gj", "<cmd>let _=&lazyredraw<CR><cmd>set lazyredraw<CR>/\\%<C-R>=virtcol('.')<CR>v\\S<CR><cmd>nohl<CR><cmd>let &lazyredraw=_<CR>", { noremap = true, silent = true })
map("n", "gk", "<cmd>let _=&lazyredraw<CR><cmd>set lazyredraw<CR>?\\%<C-R>=virtcol('.')<CR>v\\S<CR><cmd>nohl<CR><cmd>let &lazyredraw=_<CR>", { noremap = true, silent = true })

map("n", "<leader><leader>s", "<cmd>setlocal spell!<CR>", { noremap = true, silent = true, desc = "Toggle spell check" })

map("n", "<S-Up>", "<cmd>resize +1<CR>", { noremap = true, silent = true, desc = "Increase window size" })
map("n", "<S-Down>", "<cmd>resize -1<CR>", { noremap = true, silent = true, desc = "Decrease window size" })
map("n", "<S-Left>", "<cmd>vertical resize -1<CR>", { noremap = true, silent = true, desc = "Vertical decrease window size" })
map("n", "<S-Right>", "<cmd>vertical resize +1<CR>", { noremap = true, silent = true, desc = "Vertical increase window size" })

map("n", "<C-s>", "mm[s1z=`m", { noremap = true, silent = true, desc = "Correct previous spelling error" })

map("n", "<leader>cn", vim.cmd.cnext, { noremap = true, silent = true, desc = "Next item in QuickFix list" })
map("n", "<leader>cp", vim.cmd.cprev, { noremap = true, silent = true, desc = "Previous item in QuickFix list" })
map("n", "<leader>cl", vim.cmd.ccl, { noremap = true, silent = true, desc = "Close QuickFix window" })

map("n", "<leader>mm", vim.cmd.Messages, { noremap = true, silent = false, desc = "Messages" })

map("n", "<leader>hl", vim.cmd.nohlsearch, { noremap = true, silent = false, desc = "Toggle hlsearch" })

map("n", "n", "nzzzv", { noremap = true, silent = true })
map("n", "N", "Nzzzv", { noremap = true, silent = true })

-- insert mode

map("i", "<C-s>", "<C-g>u<Esc>[s1z=`]a<C-g>u", { noremap = true, silent = true })

map("i", "<Space>", "<Space><C-g>u", { noremap = true, silent = true })
map("i", "<CR>", "<CR><C-g>u", { noremap = true, silent = true })

-- command-line mode

map("c", "<C-a>", "<Home>", { noremap = true, silent = false })
map("c", "<C-b>", "<Left>", { noremap = true, silent = false })
map("c", "<C-f>", "<Right>", { noremap = true, silent = false })
map("c", "<M-b>", "<S-Left>", { noremap = true, silent = false })
map("c", "<M-f>", "<S-Right>", { noremap = true, silent = false })
map("c", "<C-p>", "<Up>", { noremap = true, silent = false })
map("c", "<C-n>", "<Down>", { noremap = true, silent = false })

vim.cmd.cnoreabbrev("bd Bw")

-- visual mode

map("v", "<", "<gv", { noremap = true, silent = true })
map("v", ">", ">gv", { noremap = true, silent = true })

map("v", "<leader>so", ":<C-w>exe join(getline(\"'<\",\"'>\"),'<Bar>')<CR>", { noremap = true, silent = true, desc = "Execute selected line" })

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- terminal

map("t", "<C-h>", "<C-\\><C-N><C-w>h", { silent = true })
map("t", "<C-j>", "<C-\\><C-N><C-w>j", { silent = true })
map("t", "<C-k>", "<C-\\><C-N><C-w>k", { silent = true })
map("t", "<C-l>", "<C-\\><C-N><C-w>l", { silent = true })

-- plugin mappings

-- folke/which-key
map("n", "<leader>ww", vim.cmd.WhichKey, { noremap = true, silent = true, desc = "Open WhichKey"})

-- jbyuki/nabla.nvim
map("n", "<leader>pp", "<cmd>lua require('nabla').popup()<CR>", { noremap = true, silent = true, desc = "Show LaTeX popup" })

-- akinsho/bufferline.nvim

map("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<CR>", { noremap = true, silent = true, desc = "Go to buffer 1" })
map("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<CR>", { noremap = true, silent = true, desc = "Go to buffer 2" })
map("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<CR>", { noremap = true, silent = true, desc = "Go to buffer 3" })
map("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<CR>", { noremap = true, silent = true, desc = "Go to buffer 4" })
map("n", "<leader>5", "<cmd>BufferLineGoToBuffer 5<CR>", { noremap = true, silent = true, desc = "Go to buffer 5" })
map("n", "<leader>6", "<cmd>BufferLineGoToBuffer 6<CR>", { noremap = true, silent = true, desc = "Go to buffer 6" })
map("n", "<leader>7", "<cmd>BufferLineGoToBuffer 7<CR>", { noremap = true, silent = true, desc = "Go to buffer 7" })

-- nvim-neo-tree/neo-tree.nvim
map("n", "<leader>-", "<cmd>Neotree toggle<CR>", { noremap = true, silent = true, desc = "Toggle sidebar" })

-- akinsho/toggleterm.nvim
map("n", "<leader>tt", "<cmd>ToggleTerm direction=horizontal<CR>", { noremap = true, silent = true, desc = "Toggle terminal" })
map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { noremap = true, silent = true, desc = "Toggle vertical terminal" })
map("n", "<leader>gt", "<cmd>terminal<CR>", { noremap = true, silent = true, desc = "Open terminal in new tab" })
map("t", "<leader>tt", "<C-\\><C-n><cmd>ToggleTerm<CR>", { noremap = true, silent = true, desc = "Open floating terminal" })

-- aymenhafeez/scratch.nvim
map("n", "<leader>ss", vim.cmd.Scratch, { noremap = true, silent = true, desc = "Toggle scratch window" })

-- "folke/zen-mode.nvim"
map("n", "<leader>zz", vim.cmd.ZenMode, { noremap = true, silent = true, desc = "Zen mode" })

-- nvim-treesitter/playground
map("n", "<leader>hi", vim.cmd.TSHighlightCapturesUnderCursor, { noremap = true, silent = true, desc = "Show current highlight group" })

-- aymenhafeez/OxfDictionary.nvim
map("n", "<leader>dd", vim.cmd.Definition, { noremap = true, silent = true, desc = "Show defintion" })
