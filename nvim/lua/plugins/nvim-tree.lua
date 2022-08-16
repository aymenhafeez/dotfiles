local status, tree = pcall(require, "nvim-tree")
if (not status) then return end

-- local opts = { noremap = true, silent = true }
-- local keymap = vim.api.nvim_set_keymap

-- toggle NvimTree
-- keymap("n", "<leader>-", ":NvimTreeToggle<CR>", opts)

tree.setup({
  hijack_cursor = true,
  sort_by = "case_sensitive",
  respect_buf_cwd = true,
  view = {
    width = 29,
    adaptive_size = false,
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
    icons = {
        show = {
            folder_arrow = false
        },
    },
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

vim.cmd [[
    autocmd bufenter * if (winnr("$") == 1 && &filetype == "nvimtree") | q | endif
]]
