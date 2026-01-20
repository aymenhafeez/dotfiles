return {
	{
		"mason-org/mason.nvim",
		dependencies = {
			{
				"j-hui/fidget.nvim",
				opts = {
					-- options
				},
			},
		},
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
