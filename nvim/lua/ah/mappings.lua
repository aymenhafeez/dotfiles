-- ============================================================================
-- KEYMAP CONFIGURATION
-- ============================================================================

vim.keymap.set("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local utils = require("ah.utils")
local map = vim.keymap.set

-- ============================================================================
-- NORMAL MODE MAPPINGS
-- ============================================================================

map("n", '<leader>ll', vim.cmd.Lazy, { desc = 'Manage Lazy' })

map("n", "<leader>tc", utils.toggle_colourschemes, { desc = "Toggle colourscheme" })
map("n", "<leader>tb", utils.toggle_light_and_dark_background, { desc = "Toggle light and dark mode" })
map("n", "<leader>zz", vim.cmd.ZenMode, { desc = "Toggle Zen mode" })

map("n", "<leader>ls", vim.cmd.LspStart, { desc = "Start language server" })
map("n", "<leader>lr", "<cmd>LspRestart lua_ls<CR>", { desc = "Restart lua_ls" })

map({ "n", "t" }, "<leader>tt", vim.cmd.TermTog, { desc = "Toggle terminal" })

map("n", "<leader>ft", function() utils.float_terminal() end, { desc = "Floating terminal" })
map("n", "<leader>lg", function() utils.float_terminal("lazygit") end, { desc = "Open LazyGit" })
map("n", "<leader>ht", function() utils.float_terminal("htop") end, { desc = "Open htop" })
map("n", "<leader>bt", function() utils.float_terminal("btm") end, { desc = "Open btm" })

map("n", "<leader>hh", function()
  vim.cmd("help " .. vim.fn.expand("<cword>"))
end, { desc = "Help for current word", silent = false })

map("n", "<leader>so", utils.source_lua, { desc = "Source file" })
map("x", "<leader><leader>x", utils.execute_line, { desc = "Execute current line" })
map("n", "<leader><leader>r", utils.reload_config, { desc = "Reload config" })
map("x", "<leader><leaderv", utils.run_visual_selection, { desc = "Reload config" })

map("n", "<leader><leader>c", ":<up>", { desc = "Show previous cmdline command" })

local tmux_nav = {
  { key = "<C-h>", cmd = "<cmd>TmuxNavigateLeft<CR>", desc = "Move left" },
  { key = "<C-j>", cmd = "<cmd>TmuxNavigateDown<CR>", desc = "Move down" },
  { key = "<C-k>", cmd = "<cmd>TmuxNavigateUp<CR>", desc = "Move up" },
  { key = "<C-l>", cmd = "<cmd>TmuxNavigateRight<CR>", desc = "Move right" },
}

for _, nav in ipairs(tmux_nav) do
  map({ "n", "t" }, nav.key, nav.cmd, { desc = nav.desc })
end

map("n", "<leader><leader>s", "<cmd>setlocal spell!<CR>", { desc = "Toggle spell check" })
map("n", "<C-s>", "mm[s1z=`m", { desc = "Correct previous spelling error" })

map("n", "<M-k>", "<cmd>resize +1<CR>", { desc = "Increase window height" })
map("n", "<M-j>", "<cmd>resize -1<CR>", { desc = "Decrease window height" })
map("n", "<M-h>", "<cmd>vertical resize -1<CR>", { desc = "Decrease window width" })
map("n", "<M-l>", "<cmd>vertical resize +1<CR>", { desc = "Increase window width" })
map("n", "<S-M-k>", "<cmd>resize +5<CR>", { desc = "Increase window height by 5" })
map("n", "<S-M-j>", "<cmd>resize -5<CR>", { desc = "Decrease window height by 5" })
map("n", "<S-M-h>", "<cmd>vertical resize -5<CR>", { desc = "Decrease window width by 5" })
map("n", "<S-M-l>", "<cmd>vertical resize +5<CR>", { desc = "Increase window width by 5" })

map("n", "<leader>cn", vim.cmd.cnext, { desc = "Next item in QuickFix list" })
map("n", "<leader>cp", vim.cmd.cprev, { desc = "Previous item in QuickFix list" })
map("n", "<leader>cl", vim.cmd.ccl, { desc = "Close QuickFix window" })

map("n", "<leader>mm", vim.cmd.Messages, { desc = "Messages" })
map("n", "<leader>hl", vim.cmd.nohlsearch, { desc = "Clear search highlight" })

-- ============================================================================
-- INSERT MODE MAPPINGS
-- ============================================================================

map("i", "<C-s>", "<C-g>u<Esc>[s1z=`]a<C-g>u", { desc = "Correct previous spelling error" })

-- Undo break points
map("i", "<Space>", "<Space><C-g>u")
map("i", "<CR>", "<CR><C-g>u")

local readline_maps = {
  { key = "<C-b>", cmd = "<Left>", desc = "Move left" },
  { key = "<C-f>", cmd = "<Right>", desc = "Move right" },
  { key = "<C-a>", cmd = "<C-o>^", desc = "Move to first character" },
  { key = "<C-e>", cmd = "<C-o>$", desc = "Move to last character" },
  { key = "<M-b>", cmd = "<S-Left>", desc = "Move word backward" },
  { key = "<M-f>", cmd = "<S-Right>", desc = "Move word forward" },
}

for _, readline in ipairs(readline_maps) do
  map("i", readline.key, readline.cmd, { desc = readline.desc })
end

-- ============================================================================
-- COMMAND-LINE MODE MAPPINGS
-- ============================================================================

local cmdline_maps = {
  { key = "<C-a>", cmd = "<Home>", desc = "Move to beginning" },
  { key = "<C-b>", cmd = "<Left>", desc = "Move left" },
  { key = "<C-f>", cmd = "<Right>", desc = "Move right" },
  { key = "<M-b>", cmd = "<S-Left>", desc = "Move word backward" },
  { key = "<M-f>", cmd = "<S-Right>", desc = "Move word forward" },
  { key = "<C-p>", cmd = "<Up>", desc = "Previous command" },
  { key = "<C-n>", cmd = "<Down>", desc = "Next command" },
}

for _, cmdline in ipairs(cmdline_maps) do
  map("c", cmdline.key, cmdline.cmd, { desc = cmdline.desc })
end

vim.cmd.cnoreabbrev("bd Bw")

-- ============================================================================
-- VISUAL MODE MAPPINGS
-- ============================================================================

map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })
map("v", "<leader>so", ":<C-w>exe join(getline(\"'<\",\"'>\"),'<Bar>')<CR>", { desc = "Execute selected lines" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- ============================================================================
-- TERMINAL MODE MAPPINGS
-- ============================================================================

map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- ============================================================================
-- PLUGIN MAPPINGS
-- ============================================================================

-- CodeCompanion
map("n", "<Leader>cc", vim.cmd.CodeCompanionChat, { desc = "Open CodeCompanionChat" })

map("n", "<S-l>", vim.cmd.bnext, { desc = "Next buffer" })
map("n", "<S-h>", vim.cmd.bprev, { desc = "Previous buffer" })

map("n", "<leader>hi", vim.cmd.TSHighlightCapturesUnderCursor, { desc = "Show highlight group under cursor" })
