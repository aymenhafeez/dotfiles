-- ============================================================================
-- TELESCOPE PICKER FUNCTIONS
-- ============================================================================

local M = {}

local telescope = require("telescope.builtin")
local extension = require("telescope").extensions
local theme = require("telescope.themes")
local utils = require("ah.utils")

local ignore_patterns = {
  "%.pdf",
  "%.py",
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
  "%_region_",
  "%.mat",
}

if pcall(require, "plenary") then
  RELOAD = require("plenary.reload").reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end

-- function M.reload_module()
--   local function get_module_name(s)
--     local module_name = s:gsub("%.lua", "")
--     module_name = module_name:gsub("%/", ".")
--     module_name = module_name:gsub("%.init", "")
--
--     return module_name
--   end
--
--   local path = vim.fn.stdpath("config")
--
--   require('telescope.builtin').find_files {
--     cwd = path,
--     prompt_title = "Reload module",
--     preview_title = "",
--     results_title = "",
--     layout_config = {
--       width = 0.8,
--       height = 0.85,
--     },
--     attach_mappings = function(_, map)
--       map("i", "<cr>", function(_)
--         local entry = require("telescope.actions.state").get_selected_entry()
--         local name = get_module_name(entry.value)
--
--         R(name)
--         utils.info(name .. " Reloaded")
--       end)
--
--       return true
--     end
--   }
-- end

function M.find_files()
  telescope.find_files {
    prompt_title = "Files",
    results_title = "",
    preview_title = "",
    path_display = { "truncate" },
    layout_config = {
      width = 0.8,
      height = 0.75,
      preview_width = 0.55,
    },
  }
end

function M.buffer_fuzzy_search()
  telescope.current_buffer_fuzzy_find {
    prompt_title = "Buffer search",
    preview_title = "",
    results_title = "",
    layout_config = {
      width = 0.8,
      height = 0.75,
      preview_width = 0.55,
    },
  }
end

function M.current_buffer_diagnostics()
  telescope.diagnostics {
    bufnr = 0,
    results_title = "",
    prompt_title = "Buffer diagnostics",
    preview_title = "",
    layout_config = {
      width = 0.8,
      height = 0.75,
      preview_width = 0.55,
    },
  }
end

function M.all_diagnostics()
  telescope.diagnostics {
    results_title = "",
    prompt_title = "Diagnostics",
    preview_title = "",
    layout_config = {
      width = 0.8,
      height = 0.75,
      preview_width = 0.55,
    },
  }
end

function M.search_highlights()
  telescope.highlights {
    results_title = "",
    prompt_title = "Highlights",
    preview_title = "",
    layout_config = {
      width = 0.8,
      height = 0.75,
      preview_width = 0.55,
    },
  }
end

function M.search_notes()
  telescope.find_files {
    cwd = "~/Dropbox/notes/MyNotes/",
    results_title = "",
    preview_title = "",
    prompt_title = "Notes",
    path_display = { "tail" },
    file_ignore_patterns = ignore_patterns,
    layout_config = {
      width = 0.8,
      height = 0.75,
      preview_width = 0.55,
    },
  }
end

function M.grep_notes()
  telescope.live_grep {
    cwd = "~/Dropbox/notes/MyNotes",
    preview_title = "",
    results_title = "",
    prompt_title = "Notes",
    path_display = { "tail" },
    file_ignore_patterns = ignore_patterns,
    layout_config = {
      width = 0.8,
      height = 0.75,
    },
  }
end

function M.search_config()
  telescope.find_files {
    cwd = vim.fn.stdpath("config"),
    results_title = "",
    prompt_title = "Config",
    preview_title = "",
    layout_config = {
      width = 0.8,
      height = 0.75,
      preview_width = 0.55,
    },
  }
end

function M.grep_config()
  telescope.live_grep {
    cwd = vim.fn.stdpath("config"),
    preview_title = "",
    results_title = "",
    prompt_title = "Config",
    path_display = { "tail" },
    layout_config = {
      width = 0.8,
      height = 0.75,
    },
  }
end

function M.search_buffers()
  telescope.buffers {
    preview_title = "",
    prompt_title = "Buffers",
    results_title = "",
    path_display = { "truncate" },
    sort_mru = true,
    sort_lastused = true,
    layout_config = {
      prompt_position = "bottom",
      height = 0.8,
      width = 0.75,
      preview_width = 0.55
    },
  }
end

function M.search_help()
  telescope.help_tags {
    results_title = "",
    prompt_title = "Neovim help",
    preview_title = "",
    layout_config = {
      width = 0.8,
      height = 0.75,
      preview_width = 0.55,
    },
  }
end

function M.spell_check()
  telescope.spell_suggest (
    theme.get_cursor {
      prompt_title = "",
      layout_config = {
        prompt_position = "bottom",
        height = 0.15,
        width = 0.25,
      },
    })
end

function M.search_history()
  telescope.command_history {
    results_title = "",
    prompt_title = "",
    prompt_prefix = ":",
    layout_config = {
      width = 0.8,
      height = 0.75,
    },
  }
end

function M.search_builtins()
  telescope.builtin {
    previewer = false,
    layout_config = {
      width = 0.8,
      height = 0.75,
      preview_width = 0.55,
    },
  }
end

function M.vim_options()
  telescope.vim_options {
    layout_config = {
      width = 0.8,
      height = 0.75,
    },
  }
end

function M.oldfiles()
  telescope.oldfiles {
    prompt_title = "Recent files",
    preview_title = "",
    results_title = "",
    path_display = { "truncate" },
    layout_config = {
      width = 0.8,
      height = 0.75,
      preview_width = 0.55,
    },
  }
end

function M.live_grep()
  telescope.live_grep {
    results_title = "",
    preview_title = "",
    prompt_title = "Live grep",
    layout_config = {
      width = 0.8,
      height = 0.75,
    },
  }
end

function M.grep_string()
  telescope.grep_string {
    prompt_title = "Grep string",
    preview_title = "",
    results_title = "",
    layout_config = {
      width = 0.8,
      height = 0.75,
    },
  }
end

function M.search_projects_dir()
  telescope.find_files {
    cwd = "~/Documents/",
    results_title = "",
    preview_title = "",
    prompt_title = "Projects",
    path_display = { "truncate" },
    layout_config = {
      width = 0.8,
      height = 0.75,
      preview_width = 0.55,
    },
  }
end

function M.file_browser()
  extension.file_browser.file_browser {
    preview_title = "",
    prompt_title = "",
    -- display_stat = false,
    layout_config = {
      width = 0.8,
      height = 0.75,
      preview_width = 0.55,
    },
  }
end

function M.search_open_buffers()
  telescope.live_grep {
    grep_open_files = true,
    layout_config = {
      width = 0.8,
      height = 0.75,
      preview_width = 0.55,
    },
  }
end

function M.change_colourscheme()
  telescope.colorscheme {
    enable_preview = true,
    ignore_builtins = true,
    preview = false,
    layout_config = {
      width = 0.45,
      height = 0.4,
    },
  }
end

function M.keymaps()
  telescope.keymaps {
    layout_config = {
      width = 0.8,
      height = 0.75,
      preview_width = 0.55,
    }
  }
end

function M.notifications()
  extension.notify.notify {
    prompt_title = "Notifications",
    results_title = "",
    preview_title = "",
    layout_config = {
      width = 0.8,
      height = 0.75,
      preview_width = 0.55,
    },
  }
end

return M
