if not pcall(require, 'telescope') then
  return
end

local utils = require("ah.telescope.utils")
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<leader>sf", utils.find_files, opts)
map("n", "<leader>sw", utils.grep_string, opts)
map("n", "<leader>sr", utils.oldfiles, opts)
map("n", "<leader>sg", utils.live_grep, opts)
map("n", "<leader>tl", utils.search_builtins, opts)
map("n", "<leader>s=", utils.spell_check, opts)
map("n", "<leader>sb", utils.search_buffers, opts)
map("n", "<leader>sd", utils.search_diagnostics, opts)
map("n", "<leader>sh", utils.search_help, opts)
map("n", "<leader>sn", utils.search_notes, opts)
map("n", "<leader>gn", utils.grep_notes, opts)
map("n", "<leader>s.", utils.search_dotfiles, opts)
map("n", "<leader>g.", utils.grep_dotfiles, opts)
map("n", "<leader>vo", utils.vim_options, opts)
map("n", "<leader>rm", utils.reload_module, opts)
map("n", "<leader>/", utils.buffer_fuzzy_search, opts)
map("n", "<leader>:", utils.search_history, opts)
map("n", "<leader>sp", utils.search_projects_dir, opts)
map("n", "<leader>fb", utils.file_browser, opts)
