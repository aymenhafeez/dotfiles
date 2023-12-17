local M = {}

---Get string representation of a string with highlight
---@param str? string sign symbol
---@param hl? string name of the highlight group
---@param restore? boolean restore highlight after the sign, default true
---@return string sign string representation of the sign with highlight
function M.hl(str, hl, restore)
  restore = restore == nil or restore
  if restore then
    return table.concat({ '%#', hl or '', '#', str or '', '%*' })
  else
    return table.concat({ '%#', hl or '', '#', str or '' })
  end
end

---Make a winbar string clickable
---@param str string
---@param callback string
---@return string
function M.make_clickable(str, callback)
  return string.format('%%@%s@%s%%X', callback, str)
end

return M
