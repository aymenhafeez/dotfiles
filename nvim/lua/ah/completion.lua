local present, blink = pcall(require, "blink.cmp")
if not present then
	return
end

--- @module 'blink.cmp'
--- @type blink.cmp.Config
local options = {
	keymap = {
		preset = "none",
		["<C-p>"] = { "select_prev", "fallback_to_mappings" },
		["<C-n>"] = { "select_next", "fallback_to_mappings" },
		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<CR>"] = { "accept", "fallback" },
		["<C-y>"] = { "accept", "fallback" },
		["<M-l>"] = { "show", "show_documentation", "hide_documentation", "fallback" },
		["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
		["<C-e>"] = { "cancel", "fallback" },
		["<C-b>"] = { "scroll_documentation_up", "fallback" },
		["<C-f>"] = { "scroll_documentation_down", "fallback" },
	},
	cmdline = {
		enabled = true,
		keymap = {
			preset = "cmdline",
			["<CR>"] = { "accept_and_enter", "fallback" },
			["<C-p>"] = { "select_prev", "fallback_to_mappings" },
			["<C-n>"] = { "select_next", "fallback_to_mappings" },
			["<Tab>"] = { "show", "fallback_to_mappings" },
			["<S-Tab>"] = { "select_prev", "fallback_to_mappings" },
		},
		completion = {
			menu = {
				auto_show = true,
			},
			list = {
				selection = {
					preselect = false,
					auto_insert = true,
				},
			},
		},
	},
	completion = {
		trigger = {
			show_on_blocked_trigger_characters = {},
			-- show_on_insert = false,
		},
		ghost_text = {
			enabled = true,
		},
		menu = {
			auto_show = true,
			-- auto_show_delay_ms = 0,
			max_height = 15,
			draw = {
				align_to = "none",
				columns = {
					{ "kind_icon",   gap = 1 },
					{ "label",       "label_description", gap = 1 },
					{ "source_name", gap = 1 },
				},
				components = {
					kind_icon = {
						text = function(ctx)
							local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
							return kind_icon
						end,
						-- (optional) use highlights from mini.icons
						highlight = function(ctx)
							local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
							return hl
						end,
					},
					kind = {
						-- (optional) use highlights from mini.icons
						highlight = function(ctx)
							local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
							return hl
						end,
					},
					label = {
						width = { max = 40 },
					},
					source_name = {
						text = function(ctx)
							return " " .. ctx.source_name .. " "
						end,
						width = { fill = true },
					},
				},
			},
		},
		documentation = {
			auto_show = true,
			window = {
				max_width = 75,
				max_height = 20,
			},
		},
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
		providers = {
			lsp = { fallbacks = {} },
		},
	},
	snippets = { preset = "luasnip" },
	fuzzy = { implementation = "prefer_rust_with_warning" },
	signature = {
		enabled = true,
		trigger = {
			enabled = true,
			show_on_keyword = false,
			blocked_trigger_characters = {},
			blocked_retrigger_characters = {},
			show_on_trigger_character = true,
			show_on_insert_on_trigger_character = true,
		},
		window = {
			show_documentation = true,
			max_width = 75,
			max_height = 20,
			scrollbar = false,
		},
	},
}

blink.setup(options)
