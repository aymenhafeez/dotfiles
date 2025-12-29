return {
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		config = function()
			require("oil").setup {
				columns = {
					"icon",
					"permissions",
					"size",
					"mtime",
				},
				delete_to_trash = true,
				keymaps = {
					["<C-s>"] = { "actions.select", opts = { horizontal = true } },
					["<C-v>"] = { "actions.select", opts = { vertical = true } },
				},
			}
			vim.keymap.set("n", "<leader>-", "<cmd>Oil<CR>")
		end,
		-- Optional dependencies
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
	},
}
