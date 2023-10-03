local present, indent = pcall(require, "mini.indentscope")
if not present then
  return
end

local options = {
  symbol = "│"
}

vim.cmd("hi link MiniIndentscopeSymbol Comment")

return indent.setup(options)
