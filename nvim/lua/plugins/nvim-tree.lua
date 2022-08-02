local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- toggle NvimTree
keymap("n", "<leader>-", ":NvimTreeToggle<CR>", opts)

require("nvim-tree").setup({
  hijack_cursor = true,
  sort_by = "case_sensitive",
  view = {
    width = 25,
    adaptive_size = true,
    hide_root_folder = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
    -- root_folder_modifier = ":t",
  },
  filters = {
    dotfiles = true,
  },
  actions = {
    open_file = {
      window_picker = {
        enable = true
      }
    }
  }
})
