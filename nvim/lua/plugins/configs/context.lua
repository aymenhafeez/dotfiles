local present, context = pcall(require, "treesitter-context")
if not present then
  return
end

local options = {
  enable = true,
  max_lines = 1,
  min_window_height = 0,
  line_numbers = true,
  multiline_threshold = 20,
  trim_scope = 'outer',
  mode = 'cursor',
  separator = nil,
  zindex = 20,
  on_attach = nil,
}

context.setup(options)
