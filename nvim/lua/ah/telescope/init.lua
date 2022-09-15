local present, telescope = pcall(require, "telescope")
if not present then
  return
end

local action = require("telescope.actions")
local action_layout = require "telescope.actions.layout"

telescope.setup {
  defaults = {
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.9,
      height = 0.75,
    },

    sorting_strategy = "ascending",
    prompt_prefix = "   ",
    prompt_title = "",
    preview_title = "",
    selection_caret = " ",
    multi_icon = "",
    winblend = 0,
    color_devicons = true,

    mappings = {
      i = {
        ["<C-e>"] = action.results_scrolling_down,
        ["<C-y>"] = action.results_scrolling_up,

        ["<M-p>"] = action_layout.toggle_preview,
        ["<M-m>"] = action_layout.toggle_mirror,
      }
    },

    file_sorter = require "telescope.sorters".get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter = require "telescope.sorters".get_generic_fuzzy_sorter,
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
  --   heading = {
  --     theme = "ivy",
  --     layout_config = {
  --       height = 0.35
  --     },
  --     treesitter = true,
  --   },
  --   packer = {
  --     theme = "ivy",
  --     layout_config = {
  --       height = 0.5
  --     }
  --   }
  }
}

-- pcall(telescope.load_extension, "heading")
-- pcall(telescope.load_extension, "packer")
-- pcall(telescope.load_extension, "zoxide")
telescope.load_extension("fzf")
telescope.load_extension("ui-select")
