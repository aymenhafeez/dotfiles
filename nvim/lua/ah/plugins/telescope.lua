return {
	{
		"nvim-telescope/telescope.nvim",
		enabled = false,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			-- { "nvim-tree/nvim-web-devicons", opts = {} },
			{ "kyazdani42/nvim-web-devicons" },
			{
				"yamatsum/nvim-web-nonicons",
				config = function()
					require("nvim-nonicons").setup {}
				end,
			},
			-- {
			-- 	"rcarriga/nvim-notify",
			-- 	config = function()
			-- 		---@diagnostic disable-next-line: missing-fields
			-- 		require("notify").setup {
			-- 			timeout = 4000,
			-- 			top_down = true,
			-- 			max_width = 60,
			-- 			render = "wrapped-compact",
			-- 			stages = "slide_out",
			-- 		}
			-- 		vim.notify = require "notify"
			-- 	end,
			-- },

			{
				dir = "~/Documents/projects/pydoc.nvim/",
				-- "aymenhafeez/pydoc.nvim",
				-- branch = "feat/telescope-integration",
				config = function()
					require("pydoc-nvim").setup()
				end,
			},

			{
				dir = "~/projects/pydoc.nvim/",
				dependencies = {
					"nvim-telescope/telescope.nvim",
					"nvim-lua/plenary.nvim",
					{
						dir = "~/Documents/projects/pydoc.nvim/",
						opts = {},
					},
				},
			},

			-- {
			-- 	dir = "~/Documents/projects/telescope-tab-buffers.nvim/",
			-- 	keys = {
			-- 		{
			-- 			"<leader>ab",
			-- 			function()
			-- 				require("telescope").extensions.tab_buffers.tab_buffers()
			-- 			end,
			-- 			desc = "Tab Buffers",
			-- 		},
			-- 	},
			-- },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable "make" == 1
				end,
			},
		},
		config = function()
			require "ah.telescope.setup"
			require "ah.telescope.telescope_keymaps"
		end,
	},
}
