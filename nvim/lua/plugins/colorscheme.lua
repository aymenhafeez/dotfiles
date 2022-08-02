local colorscheme = "onedark"

require('onedark').setup {
    style = 'darker'
}

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

-- 181b20
