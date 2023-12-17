local present, tree = pcall(require, 'neo-tree')
if not present then
  return
end

local options = {
  close_if_last_window = true,
  enable_normal_mode_for_inputs = true,
  hide_root_node = true,
  open_files_do_not_replace_types = { "terminal", "trouble", "qf", "help" },
  add_blank_line_at_top = false,
  source_selector = {
    winbar = true,
    sources = {
      {
        source = "filesystem",
        display_name = "  Files "
      },
      {
        source = "buffers",
        display_name = "  Buffers "
      },
      {
        source = "git_status",
        display_name = "  Git "
      },
    },
  },
  default_component_configs = {
    indent = {
      with_markers = true,
      last_indent_marker = "╰",
      padding = 2
    },
    symbols = {
      added     = "✚",
      deleted   = "✖",
      modified  = "",
      renamed   = "󰁕",
      untracked = "",
      ignored   = "",
      unstaged  = "󰄱",
      staged    = "",
      conflict  = "",
    },
    diagnostics = {
      symbols = {
        hint = "",
        info = "",
        warn = "",
        error = "",
      },
      highlights = {
        hint = "DiagnosticSignHint",
        info = "DiagnosticSignInfo",
        warn = "DiagnosticSignWarn",
        error = "DiagnosticSignError",
      },
    },
  },
  window = {
    width = 34,
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
    window = {
      mappings = {
        ["o"] = "system_open",
      },
    },
    commands = {
      system_open = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        path = vim.fn.shellescape(path, 1)
        vim.api.nvim_command("silent !open -g " .. path)
      end,
    },
    follow_current_file = {
      enabled = true,
      leave_dirs_open = true
    }
  }
}

return tree.setup(options)

