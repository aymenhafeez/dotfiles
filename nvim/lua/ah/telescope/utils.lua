local M = {}

local telescope = require("telescope.builtin")
local theme = require("telescope.themes")

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
    theme.get_dropdown {
      previewer = false,
      layout_config = {
        anchor = "S",
        height = 0.25
      }
    })
end

function M.search_notes()
  telescope.find_files {
    cwd = "~/Dropbox/notes/MyNotes/",
    results_title = "Notes",
    preview_title = "",
    prompt_title = "",
    layout_config = {
      height = 0.85,
      width = 0.95
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
    layout_config = {
      height = 0.85,
      width = 0.75
    }
  }
end

function M.search_dotfiles()
  telescope.find_files {
    results_title = "dotfiles",
    prompt_title = "",
    preview_title = "",
    cwd = "~/.config/nvim/",
    layout_config = {
      height = 0.75,
      width = 0.75,
      preview_width = 0.6
    }
  }
end

function M.grep_dotfiles()
  telescope.live_grep {
    results_title = "dotfiles grep",
    prompt_title = "",
    preview_title = "",
    cwd = "~/.config/nvim/",
    layout_config = {
      height = 0.75,
      width = 0.75,
      preview_width = 0.6
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
      height = 0.85,
      width = 0.85,
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
        width = 0.2
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
    preview_title = ""
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
      height = 0.5,
      prompt_position = "top"
    }
  }
end

function M.oldfiles()
  telescope.oldfiles {
    prompt_title = "",
    preview_title = "",
    results_title = "Recent files",
  }
end

function M.grep_string()
  telescope.grep_string {
    prompt_title = "",
    preview_title = "",
    results_title = "Grep string",
  }
end

return M
