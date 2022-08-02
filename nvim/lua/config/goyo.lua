local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>g", "Goyo<CR>", opts)

vim.g.goyo_height = '100'
vim.g.goyo_width = '84'
