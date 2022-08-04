local colorscheme = "neodark"

require("neodark").setup({
  theme_style = "neodarker"
})

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
