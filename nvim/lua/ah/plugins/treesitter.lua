return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			branch = "main",
		},
		{
			"nvim-treesitter/nvim-treesitter-context",
			event = "BufReadPost",
			opts = {
				max_lines = 2,
			},
		},
	},
	config = function()
		require("ah.treesitter").setup()
	end,
}
