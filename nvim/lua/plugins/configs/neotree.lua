local present, tree = pcall(require, 'neo-tree')
if not present then
  return
end

local options = {
  close_if_last_window = true,
  hide_root_node = true,
  open_files_do_not_replace_types = { "terminal", "trouble", "qf", "help" },
  default_component_configs = {
    indent = {
      padding = 2
    }
  },
  window = {
    width = 35,
    mappings = {
      ["<C-s>"] = "open_split",
      ["<C-v>"] = "open_vsplit",
      ["<C-t>"] = "open_tabnew",
      ["u"] = "navigate_up"
    },
  },
  buffers = {
    leave_dirs_open = true
  },
  filesystem = {
    follow_current_file = {
      enabled = true,
      leave_dirs_open = true
    }
  }
}

return tree.setup(options)
