return {
	{
		"saghen/blink.cmp",
		event = "InsertEnter",
		version = "1.*",
		dependencies = {
			{ "onsails/lspkind.nvim" },
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
						{ path = "/usr/share/awesome/lib/", words = { "awesome" } },
						{ "nvim-dap-ui" },
						{ "plenary" },
					},
				},
			},
		},
		config = function()
			require "ah.completion"
		end,
	},

	{
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup {
				keymaps = {
					accept_suggestion = "<C-l>",
					accept_word = "<M-l>",
					clear_suggestion = "<C-c><C-c>",
				},
			}
			vim.keymap.set("n", "<leader>sm", "<cmd>SupermavenToggle<CR>")
		end,
	},
}
