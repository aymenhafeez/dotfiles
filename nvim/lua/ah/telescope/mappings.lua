if not pcall(require, 'telescope') then
  return
end

local utils = require("ah.telescope.utils")
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<leader>sf", function() utils.find_files_in_path() end, opts)
map("n", "<leader>sw", utils.grep_string, opts)
map("n", "<leader>sr", utils.oldfiles, opts)
map("n", "<leader>sg", function() utils.live_grep_in_path() end, opts)
map("n", "<leader>tl", utils.search_builtins, opts)
map("n", "<leader>s=", utils.spell_check, opts)
map("n", "<leader>sb", utils.search_buffers, opts)
map("n", "<leader>sd", utils.search_diagnostics, opts)
map("n", "<leader>sh", utils.search_help, opts)
map("n", "<leader>sn", function() utils.find_files_in_path("~/Dropbox/notes/MyNotes/") end, opts)
map("n", "<leader>gn", function() utils.live_grep_in_path("~/Dropbox/notes/MyNotes/") end, opts)
map("n", "<leader>s.", function() utils.find_files_in_path("~/.config/nvim/") end, opts)
map("n", "<leader>g.", function() utils.live_grep_in_path("~/.config/nvim/") end, opts)
map("n", "<leader>vo", utils.vim_options, opts)
map("n", "<leader>rm", utils.reload_module, opts)
map("n", "<leader>/", utils.buffer_fuzzy_search, opts)
map("n", "<leader>:", utils.search_history, opts)
map("n", "<leader>sp", function() utils.find_files_in_path("~/Documents/git/") end, opts)
