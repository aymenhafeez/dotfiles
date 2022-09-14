local present, navic = pcall(require, "nvim-navic")
if not present then
  return
end

local icons = require("ah.utils").icons

navic.setup {
  icons = icons,
  highlight = true,
  separator = "  ",
}
