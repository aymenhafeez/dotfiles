local present, telescope = pcall(require, "telescope")
if not present then
  return
end

telescope.setup(
  {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case"
      },
      prompt_prefix = "   ",
      selection_caret = "  ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.5,
          results_width = 0.5
        },
        width = 0.9,
        -- height = 0.6,
        -- preview_cutoff = 75
      },
      file_sorter = require "telescope.sorters".get_fuzzy_file,
      file_ignore_patterns = {},
      generic_sorter = require "telescope.sorters".get_generic_fuzzy_sorter,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      use_less = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      file_previewer = require "telescope.previewers".vim_buffer_cat.new,
      grep_previewer = require "telescope.previewers".vim_buffer_vimgrep.new,
      qflist_previewer = require "telescope.previewers".vim_buffer_qflist.new,
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require "telescope.previewers".buffer_previewer_maker
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
      media_files = {
        filetypes = { "png", "webp", "jpg", "jpeg" },
        find_cmd = "rg"
      },
      heading = {
        theme = 'ivy',
        layout_config = {
          height = 0.35
        },
        treesitter = true,
      },
      packer = {
        theme = 'ivy',
        layout_config = {
          height = 0.5
        }
      }
    }
  }
)

require('telescope').load_extension('heading')
require('telescope').load_extension('fzf')
require("telescope").load_extension('ui-select')
require("telescope").load_extension('packer')
require'telescope'.load_extension('zoxide')
