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
						sign = { namespace = { "gitsigns" }, maxwidth = 1, auto = true, fillchar = " " },
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

	{ "kyazdani42/nvim-web-devicons" },
	{
		"yamatsum/nvim-web-nonicons",
		config = function()
			require("nvim-nonicons").setup {}
		end,
	},

	-- {
	-- 	"sonph/onehalf",
	-- 	-- config = function()
	-- 	-- 	vim.cmd [[
	-- 	--     colorscheme darcula-solid
	-- 	--     set winborder=rounded
	-- 	--     hi StatusLine guibg=#5E74AA
	-- 	--     ]]
	-- 	-- end,
	-- },
}
