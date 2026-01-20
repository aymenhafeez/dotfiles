return {
	-- {
	-- 	"folke/lazydev.nvim",
	-- 	ft = "lua", -- only load on lua files
	-- 	opts = {
	-- 		library = {
	-- 			-- See the configuration section for more details
	-- 			-- Load luvit types when the `vim.uv` word is found
	-- 			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
	-- 		},
	-- 	},
	-- },
	{
		"saghen/blink.cmp",
		event = "VimEnter",
		version = "1.*",
		dependencies = {
			{ "onsails/lspkind.nvim" },
		},
		config = function()
			require "ah.completion"
		end,
	},

	-- {
	-- 	"supermaven-inc/supermaven-nvim",
	-- 	enabled = false,
	-- 	cmd = "SupermavenToggle",
	-- 	config = function()
	-- 		require("supermaven-nvim").setup {
	-- 			keymaps = {
	-- 				accept_suggestion = "<C-l>",
	-- 				accept_word = "<M-l>",
	-- 				clear_suggestion = "<C-c><C-c>",
	-- 			},
	-- 		}
	-- 		vim.keymap.set("n", "<leader>sm", "<cmd>SupermavenToggle<CR>")
	-- 	end,
	-- },
}
