local present, telescope = pcall(require, "telescope")
if not present then
  return
end

local action = require("telescope.actions")
local action_layout = require "telescope.actions.layout"

telescope.setup {
  defaults = {
    prompt_prefix = "   ",
    selection_caret = " ",
    multi_icon = "",
    sorting_strategy = "ascending",
    winblend = 10,
    color_devicons = true,

    layout_config = {
      horizontal = {
        prompt_position = "bottom",
        preview_width = 0.5,
        results_width = 0.5
      },
      width = 0.9,
      height = 0.75,
    },

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
    media_files = {
      filetypes = { "png", "webp", "jpg", "jpeg" },
      find_cmd = "rg"
    },
    heading = {
      theme = "ivy",
      layout_config = {
        height = 0.35
      },
      treesitter = true,
    },
  }
}

telescope.load_extension("heading")
telescope.load_extension("fzf")
telescope.load_extension("ui-select")
--[[ 
-- doesn't work if packer is in the opt dir --> tries to load extension before telescope has been loaded
telescope.load_extension("packer")
]]
