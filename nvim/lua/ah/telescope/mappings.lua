if not pcall(require, 'telescope') then
  return
end

local utils = require("ah.telescope.utils")
local telescope = require("telescope.builtin")
local telescope_extensions = require("telescope").extensions
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- nvim-telescope/telescope.nvim
map("n", "<leader>sb", telescope.buffers, opts)
map("n", "<leader>sf", telescope.find_files, opts)
map("n", "<leader>hh", telescope.help_tags, opts)
map("n", "<leader>sw", telescope.grep_string, opts)
map("n", "<leader>sg", telescope.live_grep, opts)
map("n", "<leader>sd", telescope.diagnostics, opts)
map("n", "<leader>sh", telescope.command_history, opts)
map("n", "<leader>tl", telescope.builtin, opts)
map("n", "<leader>s=", telescope.spell_suggest, opts)
map("n", "<leader>sr", telescope.oldfiles, opts)
map("n", "<leader>/", utils.buffer_fuzzy_search, opts)
map("n", "<leader>sn", utils.search_notes, opts)
map("n", "<leader>s.", utils.search_dotfiles, opts)
map("n", "<leader>s]", "<cmd>Telescope heading theme=ivy<CR>", opts)
