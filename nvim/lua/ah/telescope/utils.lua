local M = {}

local telescope = require("telescope.builtin")
local theme = require("telescope.themes")

M.buffer_fuzzy_search = function()
  telescope.current_buffer_fuzzy_find(
    theme.get_dropdown {
      winblend = 10,
      previewer = false
    })
end

M.search_notes = function()
  telescope.find_files {
    cwd = "~/Dropbox/notes/MyNotes/",
    prompt_title = "Notes",
    winblend = 10
  }
end

M.search_dotfiles = function()
  telescope.find_files {
    cwd = "~/.config/nvim/",
    prompt_title = "dotfiles",
    winblend = 10
  }
end

return M
