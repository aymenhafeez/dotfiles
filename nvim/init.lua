-- ------------------------------------------------------------------------
--         ________  ___  ___
--        |\   __  \|\  \|\  \
--        \ \  \|\  \ \  \\\  \      Aymen Hafeez
--         \ \   __  \ \   __  \     https://github.com/aymenhafeez
--          \ \  \ \  \ \  \ \  \    https://aymenhafeez.github.io
--           \|__|\|__|\|__|\|__|
-- ------------------------------------------------------------------------

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- plugin build hooks, define before vim.pack.add() call
local function pack_hooks(ev)
	local name = ev.data.spec.name
	local kind = ev.data.kind
	local path = ev.data.path
	-- run :TSUpdate after install/update
	if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
		if not ev.data.active then
			vim.cmd.packadd("nvim-treesitter")
		end
		vim.schedule(function()
			local ok, err = pcall(vim.cmd, "TSUpdate")
			if not ok then
				vim.notify("TSUpdate failed: " .. tostring(err), vim.log.levels.WARN)
			end
		end)
	end

	-- build jsregexp for LuaSnip
	if name == "LuaSnip" and (kind == "install" or kind == "update") then
		vim.notify("Building LuaSnip jsregexp...", vim.log.levels.INFO)
		local result = vim.system({ "make", "install_jsregexp" }, { cwd = path }):wait()
		if result.code ~= 0 then
			vim.notify("LuaSnip build failed: " .. (result.stderr or ""), vim.log.levels.WARN)
		end
	end
end

vim.api.nvim_create_autocmd("PackChanged", {
	callback = pack_hooks,
})

vim.pack.add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = "main",
	},
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
		version = "main",
	},
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter-context",
	},
	{
		src = "https://github.com/mason-org/mason.nvim",
	},
	{
		src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	{
		src = "https://github.com/j-hui/fidget.nvim",
	},
	{
		src = "https://github.com/onsails/lspkind.nvim",
	},
	{
		src = "https://github.com/nvim-mini/mini.nvim",
	},
	{
		src = "https://github.com/lewis6991/gitsigns.nvim",
	},
	{
		src = "https://github.com/NMAC427/guess-indent.nvim",
	},
	{
		src = "https://github.com/luukvbaal/statuscol.nvim",
	},
	{
		src = "https://github.com/lervag/vimtex",
	},
	{
		src = "https://github.com/brianhuster/live-preview.nvim",
	},
}, {
	load = false,
	confirm = true,
})

require("ah.treesitter").setup()
require("ah.lsp")

vim.api.nvim_create_autocmd({ "InsertEnter", "CmdLineEnter" }, {
	group = vim.api.nvim_create_augroup("LazyLoad", {}),
	callback = function()
		vim.cmd.packadd("blink.cmp")
		vim.cmd.packadd("LuaSnip")

		require("ah.completion")
		require("ah.luasnip").setup()
	end
})

require("ah.mini").setup()
require("gitsigns").setup()
require("guess-indent").setup()

require("statuscol").setup {
	relculright = true,
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

vim.g.vimtex_imaps_enabled = false
vim.g.vimtex_mappings_enabled = false
vim.g.vimtex_view_enabled = true
vim.g.vimtex_view_general_viewer = "okular"
vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
vim.keymap.set("n", "<leader>ct", "<cmd>VimtexTocToggle<CR>", { desc = "Toggle contents" })
