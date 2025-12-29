return {
	{
		"benlubas/molten-nvim",
		version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
		dependencies = {
			-- {
			--   "3rd/image.nvim",
			--   config = function()
			--     require("image").setup {
			--       backend = "sixel",
			--     }
			--   end,
			-- },
			{
				"willothy/wezterm.nvim",
				config = true,
			},
		},
		build = ":UpdateRemotePlugins",
		init = function()
			-- this is an example, not a default. Please see the readme for more configuration options
			vim.g.molten_output_win_max_height = 12
			vim.g.molten_output_win_max_width = 80
			vim.g.molten_image_provider = "wezterm"
			vim.g.molten_auto_open_output = false
			vim.keymap.set("n", "<leader>mm", "<cmd>MoltenEvaluateLine<CR>")
			vim.keymap.set("n", "<leader>mv", "<cmd>MoltenEvaluateVisual<CR>")
			vim.keymap.set("n", "<leader>ms", "<cmd>MoltenShowOutput<CR>")
			vim.keymap.set("n", "<leader>mh", "<cmd>MoltenHideOutput<CR>")
			vim.keymap.set("n", "<leader>mw", "<cmd>MoltenEnterOutput<CR>")
		end,
	},
}
