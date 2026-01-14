return {
	{ "NMAC427/guess-indent.nvim" },
	{ "kylechui/nvim-surround", event = "InsertEnter", opts = {} },
	{ "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
	{
		"moll/vim-bbye",
		cmd = { "Bdelete", "Bwipeout" },
		init = function()
			vim.keymap.set("c", "bd<CR>", "Bdelete<CR>")
		end,
	},
	{
		"mcauley-penney/visual-whitespace.nvim",
		event = "ModeChanged *:[vV\22]", -- optionally, lazy load on entering visual mode
		opts = {
			list_chars = {
				space = "·",
				tab = "··",
				nbsp = "␣",
				lead = "‹",
				trail = "›",
			},
		},
	},

	{
		"luukvbaal/statuscol.nvim",
		config = function()
			require("statuscol").setup {
				relculright = true,
				ft_ignore = { "neo-tree" },
				segments = {
					{ text = { require("statuscol.builtin").foldfunc }, click = "v:lua.ScFa" },
					{
						sign = { namespace = { "diagnostic" }, maxwidth = 1, colwidth = 1, auto = true },
						click = "v:lua.ScSa",
					},
					{ text = { require("statuscol.builtin").lnumfunc }, click = "v:lua.ScLa" },
					{ text = { "  " } },
					{
						sign = { namespace = { "gitsigns" }, maxwidth = 1, auto = true },
						click = "v:lua.ScSa",
					},
				},
			}
		end,
	},

	{
		"kndndrj/nvim-dbee",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		build = function()
			-- Install tries to automatically detect the install method.
			-- if it fails, try calling it with one of these parameters:
			--    "curl", "wget", "bitsadmin", "go"
			require("dbee").install()
		end,
		config = function()
			require("dbee").setup(--[[optional config]])
		end,
	},

	{
		"rmagatti/auto-session",
		lazy = false,
		---enables autocomplete for opts
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			auto_save = false,
			suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			-- log_level = 'debug',
		},
	},

	{ "kyazdani42/nvim-web-devicons" },
	{
		"yamatsum/nvim-web-nonicons",
		config = function()
			require("nvim-nonicons").setup {}
		end,
	},
}
