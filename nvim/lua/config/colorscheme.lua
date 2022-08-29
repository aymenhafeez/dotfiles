local colorscheme = "neodark"

if colorscheme == "tokyonight" then
  vim.g.tokyonight_style = "night"
end

if colorscheme == "onedark" then
  require("onedark").setup({
    style = "darker"
  })
end

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
