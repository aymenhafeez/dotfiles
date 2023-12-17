local present, bufferline = pcall(require, "bufferline")
if not present then
  return
end

bufferline.setup {
  options = {
    always_show_bufferline = true,
    -- style_preset = {
    --   bufferline.style_preset.no_italic,
    --   bufferline.style_preset.no_bold
    -- },
    offsets = {
      { filetype = "NvimTree", text = "", padding = 1 },
      { filetype = "neo-tree", text = "", padding = 0 },
    },
    numbers = "none",
    show_buffer_close_icons = false,
    show_tab_indicators = true,
    enforce_regular_tabs = true,
    max_name_length = 30,
    max_prefix_length = 30,
    tab_size = 21,
    color_icons = true,
    buffer_close_icon = "",
    modified_icon = "",
    show_close_icon = false,
    left_trunc_marker = "",
    right_trunc_marker = "",
    indicator = {
      -- icon = "▎",
      -- style = "icon"
      -- style = "underline"
      style = "none"
    },
  },
  highlights = {
    fill = {
      bg = { attribute = 'bg', highlight = 'StatusLine' },
    },
    -- background = {
    --   bg = { attribute = 'bg', highlight = 'Normal' },
    -- },
  --   tab = {
  --     bg = { attribute = 'bg', highlight = 'Normal' },
  --   },
  --   tab_close = {
  --     bg = { attribute = 'bg', highlight = 'Normal' },
  --   },
  --   close_button = {
  --     bg = { attribute = 'bg', highlight = 'Normal' },
  --     fg = { attribute = 'fg', highlight = 'NonText' },
  --   },
  --   close_button_visible = {
  --     bg = { attribute = 'bg', highlight = 'Normal' },
  --     fg = { attribute = 'fg', highlight = 'Comment' },
  --   },
  --   -- close_button_selected = {
  --   --   fg = { attribute = 'fg', highlight = 'NonText' },
  --   -- },
    -- buffer_selected = {
    --   bg = { attribute = 'bg', highlight = 'NeoTreeNormal' },
    --   fg = { attribute = 'fg', highlight = 'Normal' },
    -- },
  --   buffer_visible = {
  --     bg = { attribute = 'bg', highlight = 'Normal' },
  --     fg = { attribute = 'fg', highlight = 'Comment' },
  --     bold = true,
  --     italic = false,
  --   },
    -- indicator_visible = {
    --   bg = { attribute = 'bg', highlight = 'NeoTreeNormal' },
    -- },
    -- indicator_selected = {
    --   bg = { attribute = 'bg', highlight = 'NeoTreeNormal' },
    --   fg = { attribute = 'fg', highlight = 'Special' },
    -- },
    modified = {
      -- bg = { attribute = 'bg', highlight = 'NeoTreeNormal' },
      fg = { attribute = 'fg', highlight = 'Special' },

    },
    modified_visible = {
      -- bg = { attribute = 'bg', highlight = 'NeoTreeNormal' },
      fg = { attribute = 'fg', highlight = 'Special' },
    },
    modified_selected = {
      -- bg = { attribute = 'bg', highlight = 'NeoTreeNormal' },
      fg = { attribute = 'fg', highlight = 'Special' },
    },
  --   duplicate = {
  --     bg = { attribute = 'bg', highlight = 'Normal' },
  --   },
  --   duplicate_visible = {
  --     bg = { attribute = 'bg', highlight = 'Normal' },
  --   },
    -- separator = {
    --   -- fg = { attribute = 'bg', highlight = 'BufferLineBufferVisible' },
    --   bg = { attribute = 'bg', highlight = 'BufferLineBufferVisible' },
    -- },
    -- separator_selected = {
    --   bg = { attribute = 'bg', highlight = 'NeoTreeNormal' }
    -- },
    -- separator_visible = {
    --   fg = { attribute = 'bg', highlight = 'Normal' },
    --   bg = { attribute = 'bg', highlight = 'Normal' },
    -- },
  },
}
