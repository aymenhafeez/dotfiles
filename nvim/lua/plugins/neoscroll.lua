local present, scroll = pcall(require, "neoscroll")
if not present then
  return
end

scroll.setup({
  hide_cursor = true,
  stop_eof = false,
  respect_scrolloff = false,
  cursor_scrolls_alone = true,
  easing_function = nil,
  pre_hook = nil,
  post_hook = nil,
  performance_mode = false,
})

local t    = {}
t['<C-u>'] = { 'scroll', { '-vim.wo.scroll', 'true', '150', nil } }
t['<C-d>'] = { 'scroll', { 'vim.wo.scroll', 'true', '150', nil } }
t['<C-b>'] = { 'scroll', { '-vim.api.nvim_win_get_height(0)', 'true', '300', nil } }
t['<C-f>'] = { 'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '300', nil } }
t['<C-y>'] = { 'scroll', { '-0.20', 'false', '100', nil } }
t['<C-e>'] = { 'scroll', { '0.20', 'false', '100', nil } }
t['zt']    = { 'zt', { '100' } }
t['zz']    = { 'zz', { '100' } }
t['zb']    = { 'zb', { '100' } }

require('neoscroll.config').set_mappings(t)
