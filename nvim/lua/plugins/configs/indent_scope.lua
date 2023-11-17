local present, indent = pcall(require, "mini.indentscope")
if not present then
  return
end

local options = {
  symbol = "│",
  exclude_filetypes = {
    "help",
    "alpha",
    "NeoTree",
    "log",
    "lspinfo",
    "toggleterm",
  }
}

return indent.setup(options)
