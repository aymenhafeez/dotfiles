if not pcall(require, 'telescope') then
  return
end

local utils = require("ah.telescope.utils")
local telescope = require("telescope.builtin")
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- nvim-telescope/telescope.nvim
map("n", "<leader>sf", telescope.find_files, opts)
map("n", "<leader>sw", telescope.grep_string, opts)
map("n", "<leader>sg", telescope.live_grep, opts)
map("n", "<leader>sr", telescope.oldfiles, opts)
map("n", "<leader>tl", utils.search_builtins, opts)
map("n", "<leader>sh", utils.search_history, opts)
map("n", "<leader>s=", utils.spell_check, opts)
map("n", "<leader>sb", utils.search_buffers, opts)
map("n", "<leader>sd", utils.search_diagnostics, opts)
map("n", "<leader>hh", utils.search_help, opts)
map("n", "<leader>/", utils.buffer_fuzzy_search, opts)
map("n", "<leader>sn", utils.search_notes, opts)
map("n", "<leader>gn", utils.grep_notes, opts)
map("n", "<leader>s.", utils.search_dotfiles, opts)
map("n", "<leader>s]", "<cmd>Telescope heading theme=ivy<CR>", opts)
map("n", "<leader>cd", "<cmd>Telescope zoxide list theme=ivy<CR>", opts)
map("n", "<leader>pl", "<cmd>Telescope packer<CR>", opts)

map("n", "<leader>s[", "<cmd>lua require('ah.telescope.utils').spell_check<CR>", opts)
