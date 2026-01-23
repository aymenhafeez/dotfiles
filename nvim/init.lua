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
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter",             version = "main" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
	"https://github.com/nvim-treesitter/nvim-treesitter-context",
	"https://github.com/j-hui/fidget.nvim",
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.0") },
	"https://github.com/nvim-mini/mini.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/NMAC427/guess-indent.nvim",
	"https://github.com/luukvbaal/statuscol.nvim",
	"https://github.com/lervag/vimtex",
	"https://github.com/brianhuster/live-preview.nvim",
	"https://github.com/UtkarshVerma/molokai.nvim",
}, {
	load = false,
})

-- -- experimental, :h vim._extui
-- require("vim._extui").enable({
-- 	enable = true, -- Whether to enable or disable the UI.
-- 	msg = {       -- Options related to the message module.
-- 		---@type 'cmd'|'msg' Where to place regular messages, either in the
-- 		---cmdline or in a separate ephemeral message window.
-- 		target = "msg",
-- 		timeout = 4000, -- Time a message is visible in the message window.
-- 	},
-- })
