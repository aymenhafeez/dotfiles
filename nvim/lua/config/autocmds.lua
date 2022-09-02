-- remove cursorline and numbers in terminal window
local termOpts = vim.api.nvim_create_augroup('TermOpts', { clear = true })
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  command = 'setlocal nonumber norelativenumber nocursorline',
  group = termOpts
})

-- automatically open quickfix window when there's errors
local quickFix = vim.api.nvim_create_augroup('QuickFix', { clear = true })
vim.api.nvim_create_autocmd( 'QuickFixCmdPost', {
  pattern = '[^l]*',
  command = 'cwindow',
  group = quickFix
})

-- highlight on yank
local highlightGroup = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  pattern = '*',
  group = highlightGroup,
})

-- return to last edited position
local lastEdit = vim.api.nvim_create_augroup('LastEditedPos', { clear = true })
vim.api.nvim_create_autocmd({ 'BufRead', 'BufReadPost' }, {
  callback = function()
    local row, column = unpack(vim.api.nvim_buf_get_mark(0, '"'))
    local buf_line_count = vim.api.nvim_buf_line_count(0)

    if row >= 1 and row <= buf_line_count then
      vim.api.nvim_win_set_cursor(0, { row, column })
    end
  end,
  group = lastEdit
})
