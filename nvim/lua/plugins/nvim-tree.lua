local present, tree = pcall(require, "nvim-tree")
if not present then
  return
end

tree.setup({
  hijack_cursor = true,
  disable_netrw = true,
  hijack_netrw = true,
  respect_buf_cwd = false,
  sort_by = "case_sensitive",
  view = {
    width = 30,
    adaptive_size = false,
    hide_root_folder = true,
    preserve_window_proportions = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
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
})

-- vim.cmd [[
-- autocmd bufenter * if (winnr('$') == 1 && &filetype == 'nvimtree') | q | endif
-- ]]
