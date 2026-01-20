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
		["<C-h>"] = { "show", "show_documentation", "hide_documentation", "fallback" },
		["<M-h>"] = { "show_signature", "hide_signature", "fallback" },
		["<C-e>"] = { "cancel", "fallback" },
		["<C-u>"] = { "scroll_signature_up", "fallback" },
		["<C-d>"] = { "scroll_signature_down", "fallback" },
		["<C-b>"] = { "scroll_documentation_up", "fallback" },
		["<C-f>"] = { "scroll_documentation_down", "fallback" },
	},
	cmdline = {
		enabled = true,
		keymap = {
			preset = "cmdline",
			["<CR>"] = { "accept_and_enter", "fallback" },
			["<C-n>"] = { "insert_next", "fallback_to_mappings" },
			["<C-p>"] = { "insert_prev", "fallback_to_mappings" },
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
					auto_insert = false,
				},
			},
		},
	},
	completion = {
		trigger = {
			show_on_blocked_trigger_characters = {},
			show_on_insert = false,
			show_on_backspace_in_keyword = true,
		},
		ghost_text = {
			enabled = true,
		},
		menu = {
			winblend = 10,
			auto_show = true,
			auto_show_delay_ms = 0,
			max_height = 15,
			draw = {
				align_to = "none",
				columns = {
					{ "label", "label_description", gap = 1 },
					{ "kind_icon", "kind", gap = 1 },
					{ "source_name", gap = 1 },
				},
				components = {
					kind_icon = {
						text = function(ctx)
							local icon = ctx.kind_icon
							if vim.tbl_contains({ "Path" }, ctx.source_name) then
								local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
								if dev_icon then
									icon = dev_icon
								end
							else
								icon = require("lspkind").symbolic(ctx.kind, {
									mode = "symbol",
								})
							end

							return icon .. ctx.icon_gap
						end,

						-- Optionally, use the highlight groups from nvim-web-devicons
						-- You can also add the same function for `kind.highlight` if you want to
						-- keep the highlight groups in sync with the icons.
						highlight = function(ctx)
							local hl = ctx.kind_hl
							if vim.tbl_contains({ "Path" }, ctx.source_name) then
								local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
								if dev_icon then
									hl = dev_hl
								end
							end
							return hl
						end,
					},
					label = {
						width = { max = 40 },
					},
					source_name = {
						text = function(ctx)
							return "[" .. ctx.source_name .. "]"
						end,
						width = { fill = true },
					},
				},
			},
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 0,
			window = {
				max_width = 75,
				max_height = 20,
				winblend = 10,
			},
		},
	},
	sources = {
		-- default = { "lazydev", "lsp", "path", "snippets", "buffer" },
		default = { "lsp", "path", "snippets", "buffer" },
		providers = {
			lsp = { fallbacks = {} },
			-- lazydev = {
			-- 	name = "LazyDev",
			-- 	module = "lazydev.integrations.blink",
			-- 	-- make lazydev completions top priority (see `:h blink.cmp`)
			-- 	score_offset = 100,
			-- },
		},
	},
	snippets = { preset = "luasnip" },
	fuzzy = { implementation = "prefer_rust_with_warning" },
	signature = {
		enabled = true,
		trigger = {
			show_on_insert = true,
		},
		window = {
			show_documentation = true,
			max_width = 75,
			max_height = 20,
			winblend = 10,
			scrollbar = false,
		},
	},
}

blink.setup(options)
