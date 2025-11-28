local present, telescope = pcall(require, "telescope")
if not present then
  return
end

local action = require "telescope.actions"
local action_layout = require "telescope.actions.layout"
local builtin = require "telescope.builtin"
local extensions = require("telescope").extensions
local theme = require "telescope.themes"
local action_state = require "telescope.actions.state"

local options = {
  defaults = {
    layout_strategy = "flex",
    layout_config = {
      height = 0.87,
      horizontal = {
        preview_width = 0.55,
        preview_cutoff = 110,
      },
      vertical = {
        preview_height = 0.55,
      },
    },
    prompt_prefix = " > ",
    selection_caret = " > ",
    entry_prefix = "   ",
    multi_icon = "<>",
    dynamic_preview_title = true,
    mappings = {
      i = {
        ["<C-n>"] = action.move_selection_previous,
        ["<C-p>"] = action.move_selection_next,
        ["<C-e>"] = action.results_scrolling_down,
        ["<C-y>"] = action.results_scrolling_up,
        ["<C-s>"] = action.select_horizontal,
        ["<M-p>"] = action_layout.toggle_preview,
        ["<C-o>"] = function()
          local entry = action_state.get_selected_entry()
          local path = vim.fs.joinpath(entry.cwd, entry.value)
          vim.ui.open(path)
        end,
      },
    },
  },
  pickers = {
    find_files = {
      results_title = vim.fn.getcwd(),
    },
    spell_suggest = {
      theme = "cursor",
      mappings = {
        i = {
          ["<C-n>"] = action.move_selection_next,
          ["<C-p>"] = action.move_selection_previous,
        },
      },
    },
  },
  extensions = {
    file_browser = {
      hijack_netrw = true,
    },
    ["ui-select"] = {
      theme.get_dropdown(),
    },
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
}

telescope.setup(options)

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")
pcall(require("telescope").load_extension, "file_browser")
pcall(require("telescope").load_extension, "notify")
pcall(require("telescope").load_extension, "tab_buffers")

local ignore_patterns = {
  -- "%.pdf",
  "%.py",
  "%.ipynb",
  "%.gif",
  "%.GIF",
  "%.log",
  "%.aux",
  "%.out",
  "%.png",
  "%.fdb_latexmk",
  "%.fls",
  "%.tex~",
  "%.texl1#",
  "%.dvi",
  "%.jpg",
  "%.jpeg",
  "%.json",
  "%_region_",
  "%.mat",
  "%.listing",
  "%lazy-lock.json",
}

vim.keymap.set("n", "<leader>sf", builtin.find_files)
vim.keymap.set("n", "<leader>sw", builtin.grep_string)
vim.keymap.set("n", "<leader>sr", builtin.oldfiles)
vim.keymap.set("n", "<leader>sb", builtin.buffers)
vim.keymap.set("n", "<leader>sh", builtin.help_tags)
vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find)
vim.keymap.set("n", "<leader>sD", builtin.diagnostics)
vim.keymap.set("n", "<leader>s=", builtin.spell_suggest)
vim.keymap.set("n", "<leader>sg", builtin.live_grep)

vim.keymap.set("n", "<leader>sd", function()
  builtin.diagnostics { bufnr = 0 }
end)

vim.keymap.set("n", "<leader>gn", function()
  builtin.live_grep {
    cwd = "~/Documents/DataSci/",
    file_ignore_patterns = ignore_patterns,
    path_display = { "shorten" },
    prompt_title = "notes",
  }
end)

vim.keymap.set("n", "<leader>s.", function()
  builtin.find_files {
    cwd = vim.fn.stdpath "config",
    file_ignore_patterns = ignore_patterns,
    prompt_title = "config",
  }
end)

vim.keymap.set("n", "<leader>sl", function()
  builtin.find_files {
    cwd = vim.fs.joinpath(vim.fn.stdpath "data", "lazy"),
    prompt_title = "plugins",
  }
end)

vim.keymap.set("n", "<leader>gl", function()
  builtin.live_grep {
    cwd = vim.fs.joinpath(vim.fn.stdpath "data", "lazy"),
  }
end)

vim.keymap.set("n", "<leader>g.", function()
  builtin.live_grep {
    cwd = vim.fn.stdpath "config",
    file_ignore_patterns = ignore_patterns,
  }
end)

vim.keymap.set("n", "<leader>fb", function()
  extensions.file_browser.file_browser()
end)

vim.keymap.set("n", "<leader>tn", function()
  extensions.notify.notify()
end)

vim.keymap.set("n", "<leader>sn", function()
  builtin.find_files {
    cwd = "~/Documents/DataSci/",
    file_ignore_patterns = ignore_patterns,
    prompt_title = "notes",
  }
end)

vim.keymap.set("n", "<leader>fn", function()
  extensions.file_browser.file_browser {
    cwd = "~/Documents/DataSci/",
    file_ignore_patterns = ignore_patterns,
  }
end)

vim.keymap.set("n", "<leader>sp", function()
  builtin.find_files {
    cwd = "~/Documents/projects/",
    file_ignore_patterns = ignore_patterns,
    prompt_title = "projects",
  }
end)
