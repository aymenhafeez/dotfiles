local present, lualine = pcall(require, "lualine")
if not present then
  return
end

local colors = require("ah.colors")

local function location_scroll()
  local current_line = vim.fn.line "."
  local total_lines = vim.fn.line "$"
  local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

local options = {
  options = {
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    globalstatus = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      {
        'branch',
        icon = ' '
      },
      'diff', 'diagnostics'},
    lualine_c = {
      {
        'filename',
        symbols = {
          modified = '',
          readonly = ''
        }
      }
    },
    lualine_x = {'encoding'},
    lualine_y = {'filetype'},
    lualine_z = {
      'location',
      {
        location_scroll,
        color = { fg = colors.blue_6 },
        padding = { right = 0, left = 0}
      },
    }
  },
}

lualine.setup(options)
