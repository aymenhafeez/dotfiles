local present, bufferline = pcall(require, "bufferline")
if not present then
  return
end

bufferline.setup {
  options = {
    always_show_bufferline = true,
    numbers = "none",
    show_buffer_close_icons = false,
    show_tab_indicators = true,
    enforce_regular_tabs = true,
    max_name_length = 30,
    max_prefix_length = 30,
    tab_size = 21,
    color_icons = true,
    modified_icon = "",
    show_close_icon = false,
    left_trunc_marker = "",
    right_trunc_marker = "",
    indicator = {
      style = "none"
    },
  },
  highlights = {
    fill = {
      bg = { attribute = 'bg', highlight = 'Normal' },
    },
  },
}

