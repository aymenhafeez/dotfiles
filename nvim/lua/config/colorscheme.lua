local colorscheme = "neodark"

-- require("neodark").setup({
--   theme_style = "neodark"
-- })

-- require("onedark").setup({
--   style = "neodark"
-- })

if colorscheme == "tokyonight" then
    vim.g.tokyonight_style = "night"
end

if colorscheme == "onedark" then
    require("onedark").setup({
      style = "deep"
    })
end

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
