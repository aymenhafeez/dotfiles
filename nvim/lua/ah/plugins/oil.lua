return {
	{
		"stevearc/oil.nvim",
		enabled = false,
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
					["g?"] = { "actions.show_help", mode = "n" },
					["<CR>"] = "actions.select",
					["<C-t>"] = { "actions.select", opts = { tab = true } },
					["<C-p>"] = "actions.preview",
					["<C-c>"] = { "actions.close", mode = "n" },
					["<M-r>"] = "actions.refresh",
					["-"] = { "actions.parent", mode = "n" },
					["_"] = { "actions.open_cwd", mode = "n" },
					["`"] = { "actions.cd", mode = "n" },
					["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
					["gs"] = { "actions.change_sort", mode = "n" },
					["gx"] = "actions.open_external",
					["g."] = { "actions.toggle_hidden", mode = "n" },
					["g\\"] = { "actions.toggle_trash", mode = "n" },
				},
				use_default_keymaps = false,
				float = {
					max_height = 0.6,
					max_width = 0.6,
					win_options = {
						number = false,
						relativenumber = false,
						signcolumn = "no",
						statuscolumn = "",
					},
				},
			}
			vim.keymap.set("n", "<leader>-", "<cmd>lua require('oil').toggle_float()<CR>")
		end,
		-- Optional dependencies
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
	},
}
