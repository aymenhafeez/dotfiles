local action = require "telescope.actions"
local themes = require "telescope.themes"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local action_set = require "telescope.actions.set"
local make_entry = require "telescope.make_entry"

local M = {}

local function width()
	-- local win_width = vim.api.nvim_win_get_width(0)
	local win_width = vim.api.nvim_list_uis()[1].width
	if win_width < 120 then
		return 0.75
	else
		return 0.5
	end
end

local ignore_patterns = {
	"%.ipynb",
	"%.pyx",
	"%.gif",
	"%.GIF",
	"%.log",
	"%.aux",
	"%.out",
	"%.png",
	"%.fdb_latexmk",
	"%.fls",
	"%.tex~",
	"%.texl1#",
	"%.dvi",
	"%.jpg",
	"%.jpeg",
	"%.json",
	"%_region_",
	"%.mat",
	"%.listing",
	"%lazy-lock.json",
}

local live_grep_opts = {
	path_display = { "shorten" },
	sorting_strategy = "ascending",
	layout_strategy = "flex",
	layout_config = {
		prompt_position = "top",
		width = 0.9,
		height = 0.8,
	},
	attach_mappings = function(_, map)
		map("i", "<C-n>", action.move_selection_next)
		map("i", "<C-p>", action.move_selection_previous)
		return true
	end,
}

local function find_headers()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
	local headers = {}
	for k, v in ipairs(lines) do
		if string.find(v, "section") then
			table.insert(headers, {
				lnum = k,
				text = v,
			})
		end
	end

	return headers
end

function M.latex_headings(opts)
	opts = opts or {}

	local headers = find_headers()
	local current_file = vim.api.nvim_buf_get_name(0)

	pickers
		.new(opts, {
			prompt_title = "Headings",
			winblend = 10,
			sorting_strategy = "ascending",
			layout_config = {
				prompt_position = "top",
				height = 0.75,
				width = width(),
			},
			finder = finders.new_table {
				results = headers,
				entry_maker = function(entry)
					return make_entry.set_default_entry_mt({
						value = entry.text,
						display = entry.text,
						ordinal = entry.text,
						lnum = entry.lnum,
						filename = current_file,
					}, opts)
				end,
			},

			sorter = conf.generic_sorter(opts),
			previewer = conf.grep_previewer(opts),

			attach_mappings = function(prompt_bufnr, map)
				action_set.select:replace(function(_)
					local selection = action_state.get_selected_entry()
					if not selection then
						vim.notify("No selection", vim.log.levels.WARN)
					end
					actions.close(prompt_bufnr)

					local lnum = selection.lnum or 1
					vim.api.nvim_win_set_cursor(0, { lnum, 0 })
				end)

				map("i", "<C-n>", action.move_selection_next)
				map("i", "<C-p>", action.move_selection_previous)
				return true
			end,
		})
		:find()
end

local function find_todo()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
	local todo = {}
	for k, v in ipairs(lines) do
		if string.find(v, "TODO") then
			table.insert(todo, {
				lnum = k,
				text = v,
			})
		end
	end

	return todo
end

function M.todo_comments(opts)
	opts = opts or {}

	local todo = find_todo()
	local current_file = vim.api.nvim_buf_get_name(0)

	pickers
		.new(opts, {
			prompt_title = "TODO",
			winblend = 10,
			sorting_strategy = "ascending",
			layout_config = {
				prompt_position = "top",
				height = 0.75,
				width = width(),
			},
			finder = finders.new_table {
				results = todo,
				entry_maker = function(entry)
					return make_entry.set_default_entry_mt({
						value = entry.text,
						display = entry.text,
						ordinal = entry.text,
						lnum = entry.lnum,
						filename = current_file,
					}, opts)
				end,
			},

			sorter = conf.generic_sorter(opts),
			previewer = conf.grep_previewer(opts),

			attach_mappings = function(prompt_bufnr, map)
				action_set.select:replace(function(_)
					local selection = action_state.get_selected_entry()
					if not selection then
						vim.notify("No selection", vim.log.levels.WARN)
					end
					actions.close(prompt_bufnr)

					local lnum = selection.lnum or 1
					vim.api.nvim_win_set_cursor(0, { lnum, 0 })
				end)

				map("i", "<C-n>", action.move_selection_next)
				map("i", "<C-p>", action.move_selection_previous)
				return true
			end,
		})
		:find()
end

function M.search_config()
	local opts = {
		cwd = vim.fn.stdpath "config",
		file_ignore_patterns = ignore_patterns,
		prompt_title = "Config",
	}

	require("telescope.builtin").find_files(opts)
end

function M.search_plugins()
	local opts = {
		cwd = vim.fs.joinpath(vim.fn.stdpath "data", "lazy"),
		prompt_title = "Plugins",
	}

	require("telescope.builtin").find_files(opts)
end

function M.search_notes()
	local opts = {
		cwd = "~/Documents/DataSci/",
		file_ignore_patterns = ignore_patterns,
		path_display = { "shorten" },
		prompt_title = "Notes",
	}

	require("telescope.builtin").find_files(opts)
end

function M.search_projects()
	local opts = {
		cwd = "~/projects/",
		file_ignore_patterns = ignore_patterns,
		prompt_title = "Projects",
	}

	require("telescope.builtin").find_files(opts)
end

function M.help_tags()
	local opts = {
		sorting_strategy = "descending",
		layout_strategy = "bottom_pane",
		winblend = 10,
		layout_config = {
			-- anchor = "S",
			-- anchor_padding = 0,
			prompt_position = "bottom",
			height = 0.65,
		},
		attach_mappings = function(_, map)
			map("i", "<C-p>", action.move_selection_next)
			map("i", "<C-n>", action.move_selection_previous)
			return true
		end,
	}

	require("telescope.builtin").help_tags(themes.get_dropdown(opts))
end

function M.file_browser()
	require("telescope").extensions.file_browser.file_browser()
end

function M.browse_notes()
	local opts = {
		cwd = "~/Documents/DataSci/",
		file_ignore_patterns = ignore_patterns,
	}

	require("telescope").extensions.file_browser.file_browser(opts)
end

function M.cur_buffer_search()
	local opts = {
		layout_strategy = "bottom_pane",
		sorting_strategy = "descending",
		winblend = 10,
		previewer = false,
		layout_config = {
			prompt_position = "bottom",
			height = 0.6,
		},
		attach_mappings = function(_, map)
			map("i", "<C-p>", action.move_selection_next)
			map("i", "<C-n>", action.move_selection_previous)
			return true
		end,
	}

	require("telescope.builtin").current_buffer_fuzzy_find(opts)
end

function M.buffers()
	local opts = {
		-- layout_strategy = "bottom_pane",
		sorting_strategy = "ascending",
		previewer = false,
		layout_config = {
			prompt_position = "top",
			height = 0.35,
			-- preview_width = 0.6,
		},
		attach_mappings = function(_, map)
			map("i", "<C-n>", action.move_selection_next)
			map("i", "<C-p>", action.move_selection_previous)
			return true
		end,
	}

	require("telescope.builtin").buffers(themes.get_dropdown(opts))
end

function M.buf_diagnostics()
	require("telescope.builtin").diagnostics {
		bufnr = 0,
	}
end

function M.grep_notes(opts)
	opts = opts or {}
	opts.cwd = "~/Documents/DataSci/"
	opts.prompt_title = "Notes"
	opts.file_ignore_patterns = ignore_patterns

	local grep_notes_opts = vim.tbl_extend("keep", live_grep_opts, opts)

	require("telescope.builtin").live_grep(grep_notes_opts)
end

function M.grep_plugins(opts)
	opts = opts or {}
	opts.cwd = vim.fs.joinpath(vim.fn.stdpath "data", "lazy")
	opts.prompt_title = "Plugins"

	local plugin_grep_opts = vim.tbl_extend("keep", live_grep_opts, opts)

	require("telescope.builtin").live_grep(plugin_grep_opts)
end

function M.grep_config(opts)
	opts = opts or {}
	opts.cwd = vim.fn.stdpath "config"
	opts.file_ignore_patterns = ignore_patterns

	require("telescope.builtin").live_grep(vim.tbl_extend("keep", live_grep_opts, opts))
end

function M.grep_projects(opts)
	opts = opts or {}
	opts.cwd = "~/projects/"
	opts.prompt_title = "Projects"
	opts.file_ignore_patterns = ignore_patterns

	local grep_notes_opts = vim.tbl_extend("keep", live_grep_opts, opts)

	require("telescope.builtin").live_grep(grep_notes_opts)
end

function M.live_grep()
	require("telescope.builtin").live_grep(live_grep_opts)
end

function M.grep_open_files(opts)
	opts = opts or {}
	opts.grep_open_files = true
	opts.path_display = { "shorten" }
	opts.prompt_title = "Live Grep in Open Files"

	local grep_files_opts = vim.tbl_extend("keep", live_grep_opts, opts)

	require("telescope.builtin").live_grep(grep_files_opts)
end

function M.git_files(opts)
	opts = opts or {}
	opts.previewer = false
	opts.layout_config = {
		prompt_position = "top",
		width = 0.4,
		height = 0.35,
	}
	opts.attach_mappings = function(_, map)
		map("i", "<C-n>", action.move_selection_next)
		map("i", "<C-p>", action.move_selection_previous)
		return true
	end

	require("telescope.builtin").git_files(themes.get_dropdown(opts))
end

function M.spell_suggest()
	require("telescope.builtin").spell_suggest(themes.get_cursor {
		layout_config = {
			height = 0.25,
			width = 0.25,
		},
		attach_mappings = function(_, map)
			map("i", "<C-n>", action.move_selection_next)
			map("i", "<C-p>", action.move_selection_previous)
			return true
		end,
	})
end

function M.search_quickfix()
	local opts = {
		sorting_strategy = "ascending",
		previewer = false,
		layout_config = {
			prompt_position = "top",
		},
	}

	require("telescope.builtin").quickfixhistory(themes.get_dropdown(opts))
end

function M.command_history(opts)
	opts = opts or {}
	opts.previewer = false
	opts.sorting_strategy = "descending"
	opts.layout_config = {
		prompt_position = "bottom",
		width = math.floor(0.75 * vim.o.columns),
		height = 0.5,
		anchor = "SW",
		anchor_padding = 0,
	}
	opts.attach_mappings = function(_, map)
		map("i", "<C-n>", action.move_selection_next)
		map("i", "<C-p>", action.move_selection_previous)
		return true
	end

	require("telescope.builtin").command_history(themes.get_dropdown(opts))
end

return setmetatable({}, {
	__index = function(_, k)
		if M[k] then
			return M[k]
		else
			return require("telescope.builtin")[k]
		end
	end,
})
