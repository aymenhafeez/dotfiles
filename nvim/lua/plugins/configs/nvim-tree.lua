local present, tree = pcall(require, "nvim-tree")
if not present then
  return
end

local function custom_on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))
end

local options = {
  on_attach = custom_on_attach,
  hijack_cursor = true,
  disable_netrw = true,
  hijack_netrw = true,
  respect_buf_cwd = true,
  hijack_unnamed_buffer_when_opening = false,
  update_focused_file = {
    enable = true,
    update_cwd = false,
  },
  sort_by = "case_sensitive",
  view = {
    width = 35,
    adaptive_size = false,
    preserve_window_proportions = true,
    -- mappings = {
    --   list = {
    --     { key = "u", action = "dir_up" },
    --   },
    -- },
  },
  renderer = {
    root_folder_label = false,
    group_empty = true,
    icons = {
      show = {
        folder_arrow = false,
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
}

tree.setup(options)
