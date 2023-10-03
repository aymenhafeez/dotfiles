local present, scratch = pcall(require, "scratch")
if not present then
  return
end

local vpad = 7
local hpad = 10

local options = {
  relative = "cursor",
  width = vim.o.columns - hpad * 2,
  height = vim.o.lines - vpad * 2,
  vpad = vpad,
  hpad = hpad,
  border = "double"
}

scratch.setup(options)
