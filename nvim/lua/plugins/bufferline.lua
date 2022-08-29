local status, bufferline = pcall(require, "bufferline")
if (not status) then return end

local colors = require("config.colors")
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>", opts)
keymap("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>", opts)
keymap("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>", opts)
keymap("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>", opts)
keymap("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>", opts)
keymap("n", "<leader>6", ":BufferLineGoToBuffer 6<CR>", opts)
keymap("n", "<leader>7", ":BufferLineGoToBuffer 7<CR>", opts)

bufferline.setup {
  options = {
    offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
    show_buffer_close_icons = false,
    show_tab_indicators = true,
    enforce_regular_tabs = true,
    max_name_length = 30,
    max_prefix_length = 30,
    tab_size = 21,
    separator_style = "thin",
    buffer_close_icon = "",
    modified_icon = "●",
    close_icon = "",
    show_close_icon = false,
    left_trunc_marker = "",
    right_trunc_marker = "",
    indicator = {
      icon = "▎",
      style = "icon"
    }
  },
  highlights = {
    background = {
      fg = colors.grey_fg,
      bg = colors.black4,
    },
    buffer_visible = {
      fg = colors.light_grey,
      bg = colors.black4,
    },
  },
}
