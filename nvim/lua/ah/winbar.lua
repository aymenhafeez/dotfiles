local M = {}

local colors = require("ah.colors")
local navic = require("nvim-navic")

vim.api.nvim_set_hl(0, "WinBarFilename", { fg = colors.blue })
vim.api.nvim_set_hl(0, "WinBarContext", { fg = colors.blue })

-- see if porting this and this whole winbar config to nvim navic will work
vim.cmd [[
hi link EmptyWinbar NvimTreeNormal
hi link EmptyWinbar NeoTreeNormal
]]

M.winbar_filetype_exclude = {
  "NvimTree",
  "neo-tree",
  "help",
  "terminal"
}

local excludes = function()
  if vim.tbl_contains(M.winbar_filetype_exclude, vim.bo.filetype) then
    vim.opt_local.winbar = nil
    return true
  end
  return false
end

local function is_empty(s)
  return s == nil or s == ""
end

local function get_location()
  local location = navic.get_location()
  if not is_empty(location) then
    return "%#WinBarContext#" .. " " .. location
  end
  return ""
end

function M.get_winbar()
  if excludes() then
    return "%#EmptyWinbar#" .. ""
  end
  if navic.is_available() then
    return get_location()
  else
    return ""
  end
end

return M
