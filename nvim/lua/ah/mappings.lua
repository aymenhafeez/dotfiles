vim.keymap.set("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local utils = require("ah.utils")
local map = utils.map

-- Normal mode
map('<leader>ll', vim.cmd.Lazy, 'Manage Lazy')

map("<leader>tc", utils.toggle_colourschemes, "Toggle colourscheme")
map("<leader>tb", utils.toggle_light_and_dark_background, "Toggle light and dark mode")

map("<leader>ls", vim.cmd.LspStart, "Start language server")
map("<leader>lr", "<cmd>LspRestart lua_ls<CR>", "Restart lua_ls")

map("<leader>lg", function() utils.float_terminal("lazygit") end, "Open LazyGit")
map("<leader>ht", function() utils.float_terminal("htop") end, "Open htop")
map("<leader>bt", function() utils.float_terminal("btm") end, "Open btm")
map("<leader><leader>t", function() utils.float_terminal("zsh") end, "Floating terminal")

map("<leader>hh", function()
  vim.cmd("help " .. vim.fn.expand("<cword>"))
end, "Help for current word", { silent = false })

map("<leader>so", utils.source_lua, "Source file")
map("<leader><leader>x", utils.execute_line, "Execute current line")
map("<leader><leader>r", utils.reload_config, "Reload config")

map("<leader><leader>c", ":<up>", "Show previous cmdline command")

-- Tmux navigation
map("<C-h>", "<cmd>TmuxNavigateLeft<cr>", "Move left")
map("<C-j>", "<cmd>TmuxNavigateDown<cr>", "Move down")
map("<C-k>", "<cmd>TmuxNavigateUp<cr>", "Move up")
map("<C-l>", "<cmd>TmuxNavigateRight<cr>", "Move right")

map("<leader><leader>s", "<cmd>setlocal spell!<CR>", "Toggle spell check")
map("<C-s>", "mm[s1z=`m", "Correct previous spelling error")

map("<S-Up>", "<cmd>resize +1<CR>", "Increase window size")
map("<S-Down>", "<cmd>resize -1<CR>", "Decrease window size")
map("<S-Left>", "<cmd>vertical resize -1<CR>", "Vertical decrease window size")
map("<S-Right>", "<cmd>vertical resize +1<CR>", "Vertical increase window size")

map("<leader>cn", vim.cmd.cnext, "Next item in QuickFix list")
map("<leader>cp", vim.cmd.cprev, "Previous item in QuickFix list")
map("<leader>cl", vim.cmd.ccl, "Close QuickFix window")

map("<leader>mm", vim.cmd.Messages, "Messages")

map("<leader>hl", vim.cmd.nohlsearch, "Toggle hlsearch")

-- Insert mode
map("<C-s>", "<C-g>u<Esc>[s1z=`]a<C-g>u", "Correct previous spelling error", "i")
map("<Space>", "<Space><C-g>u", nil, "i")
map("<CR>", "<CR><C-g>u", nil, "i")

-- Readline style insert mode
map("<C-b>", "<Left>", "Left", "i")
map("<C-f>", "<Right>", "Right", "i")
map("<C-a>", "<C-o>^", "Move to first character of line", "i")
map("<C-e>", "<C-o>$", "Move to last character of line", "i")
map("<M-b>", "<S-Left>", nil, "i")
map("<M-f>", "<S-Right>", nil, "i")

-- Command-line mode
map("<C-a>", "<Home>", nil, "c")
map("<C-b>", "<Left>", nil, "c")
map("<C-f>", "<Right>", nil, "c")
map("<M-b>", "<S-Left>", nil, "c")
map("<M-f>", "<S-Right>", nil, "c")
map("<C-p>", "<Up>", nil, "c")
map("<C-n>", "<Down>", nil, "c")

vim.cmd.cnoreabbrev("bd Bw")

-- Visual mode
map("<", "<gv", nil, "v")
map(">", ">gv", nil, "v")
map("<leader>so", ":<C-w>exe join(getline(\"'<\",\"'>\"),'<Bar>')<CR>", "Execute selected line", "v")
map("J", ":m '>+1<CR>gv=gv", nil, "v")
map("K", ":m '<-2<CR>gv=gv", nil, "v")

-- Terminal mode
map("<C-h>", "<C-\\><C-N><cmd>TmuxNavigateLeft<cr>", nil, "t")
map("<C-j>", "<C-\\><C-N><cmd>TmuxNavigateDown<cr>", nil, "t")
map("<C-k>", "<C-\\><C-N><cmd>TmuxNavigateUp<cr>", nil, "t")
map("<C-l>", "<C-\\><C-N><cmd>TmuxNavigateRight<cr>", nil, "t")
map("<Esc><Esc>", "<C-\\><C-n>", "Exit terminal mode", "t")

-- Plugins
-- Copilot
map("<C-j>", 'copilot#Accept("\\<CR>")', nil, "i", { expr = true, replace_keycodes = false })

-- Bufferline
for i = 1, 7 do
  map("<leader>" .. i, string.format("<cmd>BufferLineGoToBuffer %d<CR>", i), "Go to buffer " .. i)
end
map("<S-l>", vim.cmd.BufferLineCycleNext, "Cycle to next buffer")
map("<S-h>", vim.cmd.BufferLineCyclePrev, "Cycle to previous buffer")

-- ToggleTerm
map("<leader>tt", "<cmd>ToggleTerm direction=horizontal<CR>", "Toggle terminal")
map("<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", "Toggle vertical terminal")
map("<leader>gt", "<cmd>terminal<CR>", "Open terminal in new tab")
map("<leader>tt", "<C-\\><C-n><cmd>ToggleTerm<CR>", "Open floating terminal", "t")

-- Zen Mode
map("<leader>zz", vim.cmd.ZenMode, "Toggle Zen mode")

-- Treesitter highlight inspection
map("<leader>hi", vim.cmd.TSHighlightCapturesUnderCursor, "Show current highlight group")
