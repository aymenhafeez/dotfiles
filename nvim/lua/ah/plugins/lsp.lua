return {
	{
		"mason-org/mason.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		lazy = false,
		dependencies = { "mason-org/mason.nvim" },
		config = function()
			require "ah.lsp"
		end,
	},
}
