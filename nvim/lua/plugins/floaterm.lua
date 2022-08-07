local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>tt", ":FloatermToggle<CR>", opts)
keymap("t", "<leader>tt", "<C-\\><C-n>:FloatermToggle<CR>", opts)

vim.g.floaterm_wintype = "split"
vim.g.floaterm_height = 11
vim.g.floaterm_position = 'rightbelow'
