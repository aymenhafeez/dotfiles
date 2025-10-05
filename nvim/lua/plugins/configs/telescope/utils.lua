-- util functions with get_ivy picker layout

local M = {}

local telescope = require("telescope.builtin")
local extension = require "telescope".extensions
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

function M.reload_module()
  local function get_module_name(s)
    local module_name = s:gsub("%.lua", "")
    module_name = module_name:gsub("%/", ".")
    module_name = module_name:gsub("%.init", "")

    return module_name
  end

  local path = "~/.config/nvim/lua"

  require('telescope.builtin').find_files (
    theme.get_ivy {
      cwd = path,
      prompt_title = "Reload module",
      preview_title = "",
      results_title = "",
      layout_config = {
        height = 0.4,
        prompt_position = "bottom",
      },
      attach_mappings = function(_, map)
        map("i", "<cr>", function(_)
          local entry = require("telescope.actions.state").get_selected_entry()
          local name = get_module_name(entry.value)

          R(name)
          utils.info(name .. " Reloaded")
        end)

        return true
      end
    })
end

function M.find_files()
  telescope.find_files (
    theme.get_ivy {
      results_title = "",
      prompt_title = "Find files",
      preview_title = "",
      path_display = { "truncate" },
      layout_config = {
        prompt_position = "bottom",
        height = 0.4,
        preview_width = 0.55,
      }
    }
  )
end

function M.buffer_fuzzy_search()
  telescope.current_buffer_fuzzy_find(
    theme.get_ivy {
      prompt_title = "Buffer search",
      preview_title = "",
      results_title = "",
      layout_config = {
        prompt_position = "bottom",
        height = 0.4,
        preview_width = 0.5,
      }
    })
end

function M.search_diagnostics()
  telescope.diagnostics(
    theme.get_ivy {
      results_title = "",
      prompt_title = "Diagnostics",
      preview_title = "",
      layout_config = {
        prompt_position = "bottom",
        height = 0.4
      }
    })
end

function M.search_notes()
  telescope.find_files (
    theme.get_ivy {
      cwd = "~/Dropbox/notes/MyNotes/",
      results_title = "",
      preview_title = "",
      prompt_title = "Notes",
      path_display = { "tail" },
      file_ignore_patterns = ignore_patterns,
      layout_config = {
        prompt_position = "bottom",
        height = 0.4,
        preview_width = 0.55
      }
    }
  )
end

function M.grep_notes()
  telescope.live_grep (
    theme.get_ivy {
      cwd = "~/Dropbox/notes/MyNotes",
      preview_title = "",
      results_title = "",
      prompt_title = "Notes",
      layout_strategy = "vertical",
      path_display = { "tail" },
      file_ignore_patterns = ignore_patterns,
      layout_config = {
        prompt_position = "bottom",
        height = 0.4,
        preview_height = 0.6
      }
    }
  )
end

function M.search_config()
  telescope.find_files (
    theme.get_ivy {
      cwd = vim.fn.stdpath("config"),
      results_title = "",
      prompt_title = "Config",
      preview_title = "",
      layout_config = {
        prompt_position = "bottom",
        height = 0.4,
        preview_width = 0.55
      }
    }
  )
end

function M.grep_config()
  telescope.live_grep (
    theme.get_ivy {
      cwd = vim.fn.stdpath("config"),
      preview_title = "",
      results_title = "",
      prompt_title = "Config",
      -- layout_strategy = "vertical",
      path_display = { "tail" },
      layout_config = {
        prompt_position = "bottom",
        height = 0.4,
      }
    }
  )
end

function M.search_buffers()
  telescope.buffers(
    theme.get_ivy {
      preview_title = "",
      prompt_title = "Buffers",
      results_title = "",
      -- previewer = false,
      layout_config = {
        prompt_position = "bottom",
        height = 0.4
      }
    })
end

function M.search_help()
  telescope.help_tags (
    theme.get_ivy {
      results_title = "",
      prompt_title = "Neovim help",
      preview_title = "",
      layout_config = {
        prompt_position = "bottom",
        height = 0.4,
      }
    }
  )
end

function M.spell_check()
  telescope.spell_suggest(
    theme.get_cursor {
      prompt_title = "",
      layout_config = {
        prompt_position = "bottom",
        height = 0.2,
        width = 0.25
      }
    })
end

function M.search_history()
  telescope.command_history(
    theme.get_ivy {
      results_title = "",
      prompt_title = "",
      prompt_prefix = ":",
      layout_config = {
        prompt_position = "bottom",
        height = 0.25
      }
    })
end

function M.search_builtins()
  telescope.builtin(
    theme.get_ivy {
      previewer = false,
      layout_config = {
        prompt_position = "bottom",
        height = 0.4
      }
    })
end

function M.vim_options()
  telescope.vim_options (
    theme.get_ivy {
      layout_config = {
        prompt_position = "bottom",
        height = 0.4
      }
    }
  )
end

function M.oldfiles()
  telescope.oldfiles (
    theme.get_ivy {
      prompt_title = "Recent files",
      preview_title = "",
      results_title = "",
      path_display = { "truncate" },
      layout_config = {
        prompt_position = "bottom",
        height = 0.4,
      }
    }
  )
end

function M.live_grep()
  telescope.live_grep (
    theme.get_ivy {
      results_title = "",
      preview_title = "",
      prompt_title = "Live grep",
      layout_config = {
        prompt_position = "bottom",
        height = 0.4,
      }
    }
  )
end

function M.grep_string()
  telescope.grep_string (
    theme.get_ivy {
      prompt_title = "Grep string",
      preview_title = "",
      results_title = "Grep string",
      layout_config = {
        prompt_position = "bottom",
        height = 0.4,
      }
    }
  )
end

function M.search_projects_dir()
  telescope.find_files (
    theme.get_ivy {
      cwd = "~/Documents/DataSci/",
      results_title = "",
      preview_title = "",
      prompt_title = "Projects",
      path_display = { "truncate" },
      layout_config = {
        prompt_position = "bottom",
        height = 0.4,
      }
    }
  )
end

function M.file_browser()
  extension.file_browser.file_browser (
    theme.get_ivy {
      preview_title = "",
      prompt_title = "",
      layout_config = {
        height = 0.4,
        prompt_position = "bottom"
      }
    }
  )
end

function M.search_open_buffers()
  telescope.live_grep (
    theme.get_ivy {
      grep_open_files = true,
      layout_config = {
        prompt_position = "bottom",
        height = 0.4
      }
    }
  )
end

function M.change_colourscheme()
  telescope.colorscheme (
    theme.get_ivy {
      layout_config ={
        prompt_position = "bottom",
        height = 0.4,
      }
    }
  )
end

function M.notifications()
  telescope.notify (
    theme.get_ivy {
      layout_config = {
        prompt_position = "bottom",
        height = 0.4
      }
    }
  )
end

return M
