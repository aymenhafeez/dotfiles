local status, scroll = pcall(require, "neoscroll")
if (not status) then return end

scroll.setup({
  -- All these keys will be mapped to their corresponding default scrolling animation
  hide_cursor = true, -- Hide cursor while scrolling
  stop_eof = false, -- Stop at <EOF> when scrolling downwards
  respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
  cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
  easing_function = nil, -- Default easing function
  pre_hook = nil, -- Function to run before the scrolling animation starts
  post_hook = nil, -- Function to run after the scrolling animation ends
  performance_mode = false, -- Disable "Performance Mode" on all buffers.
})

local t    = {}
-- Syntax: t[keys] = {function, {function arguments}}
-- Use the "sine" easing function
t['<C-u>'] = { 'scroll', { '-vim.wo.scroll', 'true', '150', nil } }
t['<C-d>'] = { 'scroll', { 'vim.wo.scroll', 'true', '150', nil } }
-- Use the "circular" easing function
t['<C-b>'] = { 'scroll', { '-vim.api.nvim_win_get_height(0)', 'true', '300', nil } }
t['<C-f>'] = { 'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '300', nil } }
-- Pass "nil" to disable the easing animation (constant scrolling speed)
t['<C-y>'] = { 'scroll', { '-0.20', 'false', '100', nil } }
t['<C-e>'] = { 'scroll', { '0.20', 'false', '100', nil } }
t['zt']    = { 'zt', { '100' } }
t['zz']    = { 'zz', { '100' } }
t['zb']    = { 'zb', { '100' } }

require('neoscroll.config').set_mappings(t)
