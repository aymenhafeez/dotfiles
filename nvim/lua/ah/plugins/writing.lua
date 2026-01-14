return {
	{
		"lervag/vimtex",
		ft = "tex",
		lazy = false,
		keys = {
			{ "<leader>ct", "<cmd>VimtexTocToggle<CR>", desc = "Toggle contents" },
		},
		init = function()
			vim.g.vimtex_imaps_enabled = false
			vim.g.vimtex_mappings_enabled = false
			vim.g.vimtex_view_enabled = true
			vim.g.vimtex_view_general_viewer = "okular"
			vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
		end,
	},
	{
		"brianhuster/live-preview.nvim",
		ft = { "markdown", "md" },
		dependencies = { "nvim-telescope/telescope.nvim" },
	},

	-- {
	-- 	"OXY2DEV/markview.nvim",
	-- 	ft = { "markdown", "md" },
	-- 	opts = {
	-- 		preview = {
	-- 			icon_provider = "internal", -- "mini" or "devicons"
	-- 		},
	-- 	},
	--
	-- 	-- Completion for `blink.cmp`
	-- 	-- dependencies = { "saghen/blink.cmp" },
	-- },
}
