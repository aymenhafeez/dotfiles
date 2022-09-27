local present, barbar = pcall(require, "bufferline")
if not present then
  return
end

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

barbar.setup {
  -- autohide = true,
  closable = true,
  icon_close_tab = "",
  icon_separator_inactive = "",
  maximum_length = 15,
  icon_pinned = ""
}

map("n", "<leader>1", "<cmd>BufferGoto 1<CR>", opts)
map("n", "<leader>2", "<cmd>BufferGoto 2<CR>", opts)
map("n", "<leader>3", "<cmd>BufferGoto 3<CR>", opts)
map("n", "<leader>4", "<cmd>BufferGoto 4<CR>", opts)
map("n", "<leader>5", "<cmd>BufferGoto 5<CR>", opts)
map("n", "<leader>6", "<cmd>BufferGoto 6<CR>", opts)
map("n", "<leader>7", "<cmd>BufferGoto 7<CR>", opts)
map("n", "<leader>8", "<cmd>BufferGoto 8<CR>", opts)
map("n", "<leader>9", "<cmd>BufferGoto 9<CR>", opts)

local nvim_tree_events = require('nvim-tree.events')
local bufferline_state = require('bufferline.state')

local function get_tree_size()
  return require'nvim-tree.view'.View.width
end

nvim_tree_events.subscribe('TreeOpen', function()
  bufferline_state.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe('Resize', function()
  bufferline_state.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe('TreeClose', function()
  bufferline_state.set_offset(0)
end)
