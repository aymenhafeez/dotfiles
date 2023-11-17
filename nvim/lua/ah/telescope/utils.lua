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

  local opts = {
    cwd = path,
    prompt_title = "",
    preview_title = "",
    results_title = "Neovim modules",
    layout_config = {
      height = 0.7,
      width = 0.75,
      preview_width = 0.6
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
  }

  require('telescope.builtin').find_files(opts)
end

function M.find_files()
  telescope.find_files {
    results_title = "",
    prompt_title = "",
    preview_title = "",
    path_display = { "truncate" },
    layout_config = {
      width = 0.85,
      height = 0.9,
      preview_width = 0.55
    }
  }
end

function M.buffer_fuzzy_search()
  telescope.current_buffer_fuzzy_find(
    theme.get_ivy {
      prompt_title = "",
      preview_title = "",
      results_title = "Buffer search",
      layout_config = {
        prompt_position = "bottom",
        height = 0.45,
        preview_width = 0.55
      }
    })
end

function M.search_diagnostics()
  telescope.diagnostics(
    theme.get_ivy {
      results_title = "Diagnostics",
      prompt_title = "",
      preview_title = "",
      layout_config = {
        prompt_position = "bottom",
        height = 0.35
      }
    })
end

function M.search_notes()
  telescope.find_files {
    cwd = "~/Dropbox/notes/MyNotes/",
    results_title = "Notes",
    preview_title = "",
    prompt_title = "",
    path_display = { "tail" },
    file_ignore_patterns = ignore_patterns,
    layout_strategy = "flex",
    layout_config = {
      width = 0.85,
      height = 0.9,
      -- preview_width = 0.55
    }
  }
end

function M.grep_notes()
  telescope.live_grep {
    cwd = "~/Dropbox/notes/MyNotes",
    preview_title = "Notes",
    results_title = "",
    prompt_title = "",
    layout_strategy = "vertical",
    path_display = { "tail" },
    file_ignore_patterns = ignore_patterns,
    layout_config = {
      width = 0.65,
      height = 0.9,
      preview_height = 0.6
    }
  }
end

function M.search_dotfiles()
  telescope.find_files {
    cwd = "~/.config/nvim/",
    results_title = "dotfiles",
    prompt_title = "",
    preview_title = "",
    layout_config = {
      width = 0.85,
      height = 0.9,
      preview_width = 0.55
    }
  }
end

function M.grep_dotfiles()
  telescope.live_grep {
    cwd = "~/.config/nvim/",
    preview_title = "dotfiles",
    results_title = "",
    prompt_title = "",
    layout_strategy = "vertical",
    path_display = { "tail" },
    layout_config = {
      width = 0.65,
      height = 0.9,
      preview_height = 0.6
    }
  }
end

function M.search_buffers()
  telescope.buffers(
    theme.get_dropdown {
      preview_title = "",
      prompt_title = "",
      results_title = "",
      previewer = false,
      layout_config = {
        height = 0.4
      }
    })
end

function M.search_help()
  telescope.help_tags {
    results_title = "",
    prompt_title = "Neovim help",
    preview_title = "",
    layout_config = {
      prompt_position = "top",
      width = 0.85,
      height = 0.9,
      preview_width = 0.55
    }
  }
end

function M.spell_check()
  telescope.spell_suggest(
    theme.get_cursor {
      prompt_title = "",
      layout_config = {
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
    theme.get_dropdown {
      previewer = false,
      layout_config = {
        height = 0.4
      }
    })
end

function M.vim_options()
  telescope.vim_options {
    layout_config = {
      width = 0.5,
      height = 0.75
    }
  }
end

function M.oldfiles()
  telescope.oldfiles {
    prompt_title = "",
    preview_title = "",
    results_title = "Recent files",
    path_display = { "truncate" },
    layout_config = {
      width = 0.85,
      preview_width = 0.5
    }
  }
end

function M.live_grep()
  telescope.live_grep {
    results_title = "",
    preview_title = "",
    prompt_title = "Live grep",
    layout_strategy = "vertical",
    layout_config = {
      height = 0.85,
      -- width = 0.65,
      preview_height = 0.6
    }
  }
end

function M.grep_string()
  telescope.grep_string {
    prompt_title = "",
    preview_title = "",
    results_title = "Grep string",
    layout_config = {
      width = 0.85,
      preview_width = 0.6
    }
  }
end

function M.search_projects_dir()
  telescope.find_files {
    cwd = "~/Documents/git/",
    results_title = "Projects",
    preview_title = "",
    prompt_title = "",
    path_display = { "truncate" },
    layout_config = {
      -- height = 0.75,
      -- width = 0.75,
      width = 0.85,
      height = 0.85,
      preview_width = 0.6
    }
  }
end

function M.file_browser()
  extension.file_browser.file_browser {
    -- layout_config = {
    --   -- height = 0.75,
    --   -- width = 0.8,
    --   width = 0.85,
    --   height = 0.85,
    --   preview_width = 0.5
    -- }
  }
end

function M.notify()
  telescope.notify {
    results_title = "Notifications",
    preview_title = "",
    prompt_title = "",
    -- layout_config = {
    --   width = 0.85,
    --   height = 0.85
    -- }
  }
end

return M
