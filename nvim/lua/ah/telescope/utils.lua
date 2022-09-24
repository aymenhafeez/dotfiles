local M = {}

local telescope = require("telescope.builtin")
local theme = require("telescope.themes")

local ignore_patterns = {
  "%.pdf",
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
  "%_region_"
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

  local prompt_title = ""
  local preview_title = ""
  local results_title = "Neovim modules"
  local info = require("ah.utils").info
  local layout_config = {
    height = 0.7,
    width = 0.75,
    preview_width = 0.6
  }

  local path = "~/.config/nvim/lua"

  local opts = {
    cwd = path,
    prompt_title = prompt_title,
    results_title = results_title,
    preview_title = preview_title,
    layout_config = layout_config,

    attach_mappings = function(_, map)
      map("i", "<cr>", function(_)
        local entry = require("telescope.actions.state").get_selected_entry()
        local name = get_module_name(entry.value)

        R(name)
        info(name .. " Reloaded")
      end)

      return true
    end
  }

  require('telescope.builtin').find_files(opts)
end

function M.buffer_fuzzy_search()
  telescope.current_buffer_fuzzy_find(
    theme.get_ivy {
      prompt_title = "",
      preview_title = "",
      results_title = "Buffer search",
      layout_config = {
        prompt_position = "bottom",
        height = 0.35
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

function M.search_buffers()
  telescope.buffers(
    theme.get_ivy {
      preview_title = "",
      prompt_title = "",
      results_title = "",
      layout_config = {
        prompt_position = "bottom",
        horizontal = {
          preview_width = 0.5,
          results_width = 0.5,
        },
        height = 0.25,
        width = 0.6
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
    layout_config = {
      height = 0.75,
      width = 0.75,
      preview_width = 0.6
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
      height = 0.85,
      width = 0.65,
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
      height = 0.75,
      width = 0.75,
      preview_width = 0.6
    }
  }
end

function M.grep_dotfiles()
  telescope.live_grep {
    cwd = "~/.config/nvim/",
    preview_title = "dotfiles grep",
    results_title = "",
    prompt_title = "",
    layout_strategy = "vertical",
    path_display = { "smart" },
    layout_config = {
      height = 0.85,
      width = 0.65,
      preview_height = 0.6
    }
  }
end

function M.search_help()
  telescope.help_tags {
    results_title = "",
    prompt_title = "Neovim help",
    preview_title = "",
    layout_config = {
      prompt_position = "top",
      height = 0.75,
      width = 0.75,
      preview_width = 0.6
    }
  }
end

function M.spell_check()
  telescope.spell_suggest(
    theme.get_cursor {
      prompt_title = "",
      layout_config = {
        height = 0.2,
        width = 0.3
      }
    })
end

function M.search_history()
  telescope.command_history(
    theme.get_ivy {
      results_title = "Command history",
      prompt_title = "",
      layout_config = {
        prompt_position = "bottom",
        height = 0.35
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

function M.find_files()
  telescope.find_files {
    results_title = "Find files",
    prompt_title = "",
    preview_title = "",
    path_display = { "smart" },
    layout_config = {
      width = 0.8,
      height = 0.8,
      preview_width = 0.6
    }
  }
end

function M.vim_options()
  telescope.vim_options {
    layout_config = {
      width = 0.5
    }
  }
end

function M.live_grep()
  telescope.live_grep {
    results_title = "",
    preview_title = "",
    prompt_title = "Live grep",
    layout_config = {
      height = 0.6,
      prompt_position = "top"
    }
  }
end

function M.oldfiles()
  telescope.oldfiles {
    prompt_title = "",
    preview_title = "",
    results_title = "Recent files",
    path_display = { "smart" },
    layout_config = {
      width = 0.75,
      preview_width = 0.6
    }
  }
end

function M.grep_string()
  telescope.grep_string {
    prompt_title = "",
    preview_title = "",
    results_title = "Grep string",
    layout_config = {
      width = 0.75,
      preview_width = 0.6
    }
  }
end
print("hi")
return M
