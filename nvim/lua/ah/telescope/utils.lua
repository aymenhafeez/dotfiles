local M = {}

local telescope = require("telescope.builtin")
local theme = require("telescope.themes")

function M.buffer_fuzzy_search()
  telescope.current_buffer_fuzzy_find(
    theme.get_ivy {
      layout_config = {
        height = 0.35
      }
    })
end

function M.search_diagnostics()
  telescope.diagnostics(
    theme.get_ivy {
      layout_config = {
        height = 0.35
      }
    })
end

function M.search_buffers()
  telescope.buffers(
    theme.get_dropdown {
      previewer = false,
      layout_config = {
        anchor = "SE",
        height = 0.25
      }
    })
end

function M.search_notes()
  telescope.find_files {
    cwd = "~/Dropbox/notes/MyNotes/",
    prompt_title = "Notes",
    path_display = "smart",
    layout_config = {
      height = 0.85
    }
  }
end

function M.grep_notes()
  telescope.live_grep {
    cwd = "~/Dropbox/notes/MyNotes/",
    prompt_title = "Notes",
    path_display = "smart",
    layout_strategy = "vertical",
    layout_config = {
      height = 0.85,
      width = 0.75
    }
  }
end

function M.search_dotfiles()
  telescope.find_files {
    prompt_title = "dotfiles",
    cwd = "~/.config/nvim/",
  }
end

function M.search_help()
  telescope.help_tags {
    prompt_title = "Neovim help",
    layout_config = {
      prompt_position = "top",
      height = 0.85
    }
  }
end

function M.spell_check()
  telescope.spell_suggest(
    theme.get_cursor {
      prompt_prefix = "   ",
      prompt_title = "",
      layout_config = {
        height = 0.25,
        width = 0.25
      }
    })
end

function M.search_history()
  telescope.command_history(
    theme.get_ivy {
      results_title = "",
      layout_config = {
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

return M
