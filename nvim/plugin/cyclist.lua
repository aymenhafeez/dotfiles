-- simplified lua implementation of cyclist.vim
vim.opt.list = true
vim.opt.listchars = { tab = "  ", nbsp = "␣", extends = "⋯", precedes = "⋯", trail = "·" }
local listchars = {
  { tab = "⊳ ", eol = "↲", nbsp = "␣", extends = "⋯", precedes = "⋯", trail = "·" },
  { tab = ">-", eol = "¬", nbsp = "␣", extends = ">", precedes = "<", trail = "-" },
  { tab = ">-", eol = "↵", nbsp = "␣", extends = ">", precedes = "<", trail = "-" },
  { tab = "  ", eol = "↲", nbsp = "␣", extends = "⋯", precedes = "⋯", trail = "·" },
  { tab = "  ", eol = "↲", nbsp = "␣", extends = ">", precedes = "<", trail = "·" },
  { tab = "»·", eol = "↲", nbsp = "␣", extends = "⋯", precedes = "⋯", trail = "·" },
  {},
}
local listchar_index = 1
local cyclelist_chars = function()
  listchar_index = listchar_index % #listchars + 1
  vim.opt.listchars = listchars[listchar_index]
end

vim.keymap.set("n", "<leader>cl", function()
  cyclelist_chars()
end)
