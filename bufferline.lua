local present, bufferline = pcall(require, "bufferline")
if not present then
  return
end

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
    always_show_bufferline = true,
    offsets = { { filetype = "NvimTree", text = "", padding = 1 }, { filetype = "neo-tree", text = "", padding = 0 } },
    numbers = "none",
    show_buffer_close_icons = true,
    show_tab_indicators = true,
    enforce_regular_tabs = true,
    max_name_length = 30,
    max_prefix_length = 30,
    tab_size = 21,
    color_icons = true,
    separator_style = "thin",
    buffer_close_icon = "",
    modified_icon = "●",
    close_icon = "",
    show_close_icon = false,
    left_trunc_marker = "",
    right_trunc_marker = "",
    indicator = {
      -- icon = "▎",
      -- style = "icon"
      style = "none"
    },
  },
  highlights = {
    fill = {
      bg = { attribute = 'bg', highlight = 'Normal' },
    },
    background = {
      bg = { attribute = 'bg', highlight = 'Normal' },
    },
    tab = {
      bg = { attribute = 'bg', highlight = 'Normal' },
    },
    tab_close = {
      bg = { attribute = 'bg', highlight = 'Normal' },
    },
    close_button = {
      bg = { attribute = 'bg', highlight = 'Normal' },
      fg = { attribute = 'fg', highlight = 'NonText' },
    },
    close_button_visible = {
      bg = { attribute = 'bg', highlight = 'Normal' },
      fg = { attribute = 'fg', highlight = 'Comment' },
    },
    -- close_button_selected = {
    --   fg = { attribute = 'fg', highlight = 'NonText' },
    -- },
    buffer_visible = {
      bg = { attribute = 'bg', highlight = 'Normal' },
      fg = { attribute = 'fg', highlight = 'Comment' },
      bold = true,
      italic = false,
    },
    indicator_visible = {
      bg = { attribute = 'bg', highlight = 'Normal' },
    },
    indicator_selected = {
      bg = { attribute = 'bg', highlight = 'Normal' },
    },
    modified = {
      bg = { attribute = 'bg', highlight = 'Normal' },
      fg = { attribute = 'fg', highlight = 'Identifier' },
    },
    modified_visible = {
      bg = { attribute = 'bg', highlight = 'Normal' },
      -- fg = { attribute = 'fg', highlight = 'Identifier' },
    },
    modified_selected = {
      bg = { attribute = 'bg', highlight = 'Normal' },
      fg = { attribute = 'fg', highlight = 'Identifier' },
    },
    duplicate = {
      bg = { attribute = 'bg', highlight = 'Normal' },
    },
    duplicate_visible = {
      bg = { attribute = 'bg', highlight = 'Normal' },
    },
    separator = {
      fg = { attribute = 'bg', highlight = 'Normal' },
      bg = { attribute = 'bg', highlight = 'Normal' },
    },
    separator_selected = {
      fg = { attribute = 'bg', highlight = 'Normal' },
      bg = { attribute = 'bg', highlight = 'Normal' }
    },
    separator_visible = {
      fg = { attribute = 'bg', highlight = 'Normal' },
      bg = { attribute = 'bg', highlight = 'Normal' },
    },
  },
}
