local M = {}

function M.setup()
	local ls = require "luasnip"
	local types = require "luasnip.util.types"

	ls.config.set_config {
		history = true,
		updateevents = "TextChanged,TextChangedI",
		enable_autosnippets = true,
		store_selection_keys = "<Tab>",
		ext_opts = {
			[types.choiceNode] = {
				active = {
					virt_text = { { "<-", "GruvboxOrange" } },
				},
			},
		},
	}

	require("luasnip.loaders.from_lua").load { paths = { "~/.config/nvim/lua/ah/snippets" } }

	vim.keymap.set({ "i", "s" }, "<C-j>", function()
		if ls.expand_or_jumpable() then
			ls.expand_or_jump()
		else
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-j>", true, false, true), "n", false)
		end
	end, { silent = true, desc = "LuaSnip: Expand or jump forward" })

	vim.keymap.set({ "i", "s" }, "<C-k>", function()
		if ls.jumpable(-1) then
			ls.jump(-1)
		end
	end, { silent = true, desc = "LuaSnip: Jump backward" })

	vim.keymap.set({ "i", "s" }, "<C-e>", function()
		if ls.choice_active() then
			ls.change_choice(1)
		end
	end, { silent = true, desc = "LuaSnip: Change choice" })

	vim.api.nvim_create_user_command("LuaSnipReload", function()
		require("luasnip.loaders.from_lua").load { paths = { "~/.config/nvim/lua/ah/snippets" } }
		vim.notify("LuaSnip snippets reloaded!", vim.log.levels.INFO)
	end, { desc = "Reload LuaSnip snippets" })
end

return M
