vim.schedule(function()
  vim.pack.add({ "https://github.com/stevearc/oil.nvim" }, { load = true })
  require("oil").setup {
    columns = {
      "permissions",
      "size",
      "mtime",
    },
    view_options = { show_hidden = true },
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    keymaps = {
      ["<C-v>"] = { "actions.select", opts = { vertical = true } },
      ["<C-s>"] = { "actions.select", opts = { horizontal = true } },
    }
  }
end)

vim.keymap.set("n", "<leader>-", function()
  require("oil").open()
end)

vim.keymap.set("n", "<M-.>", function() require("oil").toggle_hidden() end)

vim.keymap.set("n", "<leader>d-", function()
  local home = vim.fn.expand("~")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local split_direction = vim.api.nvim_win_get_width(0) > 130 and "vsplit" or "split"

  require("telescope.builtin").find_files({
    cwd = home,
    prompt_title = "Directories",
    prompt_prefix = "Directory> ",
    previewer = require("telescope.previewers").vim_buffer_cat.new({ cwd = home }),
    find_command = {
      "fd", "--type", "d", "--hidden", "--color=never", "--max-depth", "8", "--one-file-system",
      "--exclude", "node_modules", "--exclude", ".local", "--exclude", ".cargo",
      "--exclude", ".rustup", "--exclude", ".var", "--exclude", ".codex", "--exclude", ".claude",
      "--exclude", ".vscode", "--exclude", "go", "--exclude", ".zig", "--exclude", "__pycache__",
      "--exclude", ".venv", "--exclude", "*Cache", "--exclude", "*cache", "--exclude", "Cache*"
    },
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selected = action_state.get_selected_entry()
        if not selected then
          return
        end

        actions.close(prompt_bufnr)
        vim.cmd(split_direction)
        require("oil").open(vim.fs.joinpath(home, selected.value))
      end)
      return true
    end,
  })
end)
