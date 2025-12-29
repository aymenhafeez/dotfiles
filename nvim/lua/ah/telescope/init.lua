local action = require "telescope.actions"
local themes = require "telescope.themes"

local M = {}

local ignore_patterns = {
	"%.ipynb",
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
		cwd = "~/Documents/projects/",
		file_ignore_patterns = ignore_patterns,
		prompt_title = "Projects",
	}

	require("telescope.builtin").find_files(opts)
end

function M.help_tags()
	local opts = {
		-- sorting_strategy = "ascending",
		winblend = 10,
		layout_config = {
			prompt_position = "top",
		},
		-- attach_mappings = function(_, map)
		-- 	map("i", "<C-n>", action.move_selection_next)
		-- 	map("i", "<C-p>", action.move_selection_previous)
		-- 	return true
		-- end,
	}

	require("telescope.builtin").help_tags(opts)
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
		winblend = 10,
		border = true,
		shorten_path = false,
		sorting_strategy = "ascending",
		layout_config = {
			prompt_position = "top",
		},
		attach_mappings = function(_, map)
			map("i", "<C-n>", action.move_selection_next)
			map("i", "<C-p>", action.move_selection_previous)
			return true
		end,
	}
	require("telescope.builtin").current_buffer_fuzzy_find(opts)
end

function M.buffers()
	local opts = {
		sorting_strategy = "descending",
		layout_strategy = "bottom_pane",
		layout_config = {
			prompt_position = "bottom",
			height = 0.55,
		},
		-- attach_mappings = function(_, map)
		-- 	map("i", "<C-n>", action.move_selection_next)
		-- 	map("i", "<C-p>", action.move_selection_previous)
		-- 	return true
		-- end,
	}

	require("telescope.builtin").buffers(opts)
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
		height = 0.5,
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
			width = 0.3,
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
	opts.layout_config = {
		prompt_position = "bottom",
		width = math.floor(0.75 * vim.o.columns),
		height = 0.5,
		anchor = "SW",
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
