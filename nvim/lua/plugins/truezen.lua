local api = vim.api
local opts = { noremap = true, silent = true }
-- local term_opts = { silent = true }

api.nvim_set_keymap("n", "<leader>z", ":TZMinimalist<CR>", opts)
api.nvim_set_keymap("n", "<leader>x", ":TZAtaraxis<CR>", opts)

require("true-zen").setup{
    modes = {
        ataraxis = {
            minimum_writing_area = {
                width = 83,
            }
        },
        minimalist = {
			ignored_buf_types = { "nofile" },
			options = {
				numberwidth = 11,
				signcolumn = "yes",
			},
		},
    }
}
