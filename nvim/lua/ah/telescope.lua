local action = require("telescope.actions")
local action_layout = require "telescope.actions.layout"

require("telescope").setup ({
  defaults = {
    dynamic_preview_title = true,
    sorting_strategy = "descending",
    prompt_prefix = "   ",
    -- prompt_prefix = "  ",
    selection_caret = " ",
    multi_icon = "",
    winblend = 0,
    border = true,
    mappings = {
      i = {
        ["<C-e>"] = action.results_scrolling_down,
        ["<C-y>"] = action.results_scrolling_up,
        ["<C-n>"] = action.move_selection_previous,
        ["<C-p>"] = action.move_selection_next,
        ["<C-s>"] = action.select_horizontal,
        ["<M-p>"] = action_layout.toggle_preview,
        ["<M-m>"] = action_layout.toggle_mirror,
      }
    },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    set_env = { ["COLORTERM"] = "truecolor" },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
      },
    },
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    file_browser = {
      hijack_netrw = true,
    }
  }
})

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")
pcall(require("telescope").load_extension, "file_browser")
pcall(require("telescope").load_extension, "notify")

local utils = require("ah.telescope.utils")

vim.keymap.set("n", "<leader>sf", utils.find_files)
vim.keymap.set("n", "<leader>sw", utils.grep_string)
vim.keymap.set("n", "<leader>sr", utils.oldfiles)
vim.keymap.set("n", "<leader>sg", utils.live_grep)
vim.keymap.set("n", "<leader>tl", utils.search_builtins)
vim.keymap.set("n", "<leader>s=", utils.spell_check)
vim.keymap.set("n", "<leader>sb", utils.search_buffers)
vim.keymap.set("n", "<leader>sd", utils.current_buffer_diagnostics)
vim.keymap.set("n", "<leader>sD", utils.all_diagnostics)
vim.keymap.set("n", "<leader>sh", utils.search_help)
vim.keymap.set("n", "<leader>sH", utils.search_highlights)
vim.keymap.set("n", "<leader>sn", utils.search_notes)
vim.keymap.set("n", "<leader>s/", utils.search_open_buffers)
vim.keymap.set("n", "<leader>gn", utils.grep_notes)
vim.keymap.set("n", "<leader>s.", utils.search_config)
vim.keymap.set("n", "<leader>g.", utils.grep_config)
vim.keymap.set("n", "<leader>vo", utils.vim_options)
vim.keymap.set("n", "<leader>/", utils.buffer_fuzzy_search)
vim.keymap.set("n", "<leader>:", utils.search_history)
vim.keymap.set("n", "<leader>sp", utils.search_projects_dir)
vim.keymap.set("n", "<leader>fb", utils.file_browser)
vim.keymap.set("n", "<leader>cs", utils.change_colourscheme)
vim.keymap.set("n", "<leader>sk", utils.keymaps)
vim.keymap.set("n", "<leader>tn", utils.notifications)
