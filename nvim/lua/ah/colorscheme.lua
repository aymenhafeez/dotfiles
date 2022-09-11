local colorscheme = "neodark"

if colorscheme == "onedark" then
  require("onedark").setup({
    style = "darker"
  })
end

if colorscheme == "catppuccin" then
  vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
end

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  -- vim.notify = require("notify")
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
