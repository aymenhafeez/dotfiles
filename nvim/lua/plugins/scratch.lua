local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

map("n", "<leader>sc", ":Scratch<CR>", opts)
map("n", "<leader>ss", ":Sscratch<CR>", opts)

