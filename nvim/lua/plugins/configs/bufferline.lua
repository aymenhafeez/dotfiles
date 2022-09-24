local present, bufferline = pcall(require, "bufferline")
if not present then
  return
end

local colors = require("ah.colors")
local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

map("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>", opts)
map("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>", opts)
map("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>", opts)
map("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>", opts)
map("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>", opts)
map("n", "<leader>6", ":BufferLineGoToBuffer 6<CR>", opts)
map("n", "<leader>7", ":BufferLineGoToBuffer 7<CR>", opts)

bufferline.setup {
  options = {
    offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
    numbers = "none",
    show_buffer_close_icons = false,
    show_tab_indicators = true,
    enforce_regular_tabs = true,
    max_name_length = 30,
    max_prefix_length = 30,
    tab_size = 21,
    color_icons = true,
    separator_style = "thin",
    buffer_close_icon = "",
    modified_icon = "●",
    close_icon = "",
    show_close_icon = false,
    left_trunc_marker = "",
    right_trunc_marker = "",
    indicator = {
      icon = "▎",
      style = "icon"
    },
  },
  -- highlights = {
  --   background = {
  --     fg = colors.grey_fg,
  --     bg = colors.deep_bg,
  --   },
  --   buffer_visible = {
  --     fg = colors.light_grey,
  --     bg = colors.deep_bg,
  --   },
  -- },
  highlights = {
    background = {
      bg = colors.black4,
    },
    buffer_visible = {
      bg = colors.black4,
    },
  },
}
