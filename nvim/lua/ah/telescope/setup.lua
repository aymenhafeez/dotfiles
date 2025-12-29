local present, telescope = pcall(require, "telescope")
if not present then
	return
end

local action = require "telescope.actions"
local action_layout = require "telescope.actions.layout"
local builtin = require "telescope.builtin"
local extensions = require("telescope").extensions
local theme = require "telescope.themes"
local action_state = require "telescope.actions.state"

local icons = require "nvim-nonicons"

local options = {
	defaults = {
		prompt_prefix = " " .. icons.get "telescope" .. "  ",
		selection_caret = "|>",
		multi_icon = "<>",

		path_display = {
			truncate = 3,
		},

		layout_strategy = "flex",
		-- layout_strategy = "bottom_pane",
		results_title = "",
		prompt_title = "",
		layout_config = {
			width = 0.9,
			height = 0.9,
			prompt_position = "bottom",

			horizontal = {
				preview_width = 0.6,
				preview_cutoff = 180,
			},

			vertical = {
				width = 0.9,
				height = 0.85,
				preview_height = 0.6,
			},

			-- flex = {
			--   horizontal = {
			--     preview_width = 0.9,
			--   },
			-- },
		},

		sorting_strategy = "descending",

		winblend = 0,
		dynamic_preview_title = true,
		mappings = {
			i = {
				["<C-n>"] = action.move_selection_previous,
				["<C-p>"] = action.move_selection_next,
				["<C-e>"] = action.results_scrolling_down,
				["<C-y>"] = action.results_scrolling_up,
				["<C-s>"] = action.select_horizontal,
				["<M-p>"] = action_layout.toggle_preview,
				["<M-t>"] = action_layout.toggle_prompt_position,
				["<C-o>"] = function()
					local entry = action_state.get_selected_entry()
					local path = vim.fs.joinpath(entry.cwd, entry.value)
					vim.ui.open(path)
				end,
			},
		},
	},
	-- pickers = {
	-- 	lsp_references = {
	-- 		theme = "ivy",
	-- 	},
	-- },
	extensions = {
		file_browser = {
			layout_strategy = "bottom_pane",
			hijack_netrw = true,
			sorting_strategy = "descending",
			mappings = {
				i = {
					["<C-n>"] = action.move_selection_previous,
					["<C-p>"] = action.move_selection_next,
				},
			},
			layout_config = {
				prompt_position = "bottom",
				height = 0.65,
				preview_width = 0.6,
			},
		},
		["ui-select"] = {
			theme.get_dropdown(),
		},
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
}

telescope.setup(options)

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")
pcall(require("telescope").load_extension, "file_browser")
pcall(require("telescope").load_extension, "notify")
pcall(require("telescope").load_extension, "tab_buffers")
pcall(require("telescope").load_extension, "pydoc")
