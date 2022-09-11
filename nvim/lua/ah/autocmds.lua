local termOpts = vim.api.nvim_create_augroup("TermOpts", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  command = "setlocal nonumber norelativenumber nocursorline",
  group = termOpts
})

local quickFix = vim.api.nvim_create_augroup("QuickFix", { clear = true })
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  pattern = "[^l]*",
  command = "cwindow",
  group = quickFix
})

local highlightGroup = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual" })
  end,
  pattern = '*',
  group = highlightGroup,
})

local lastEditPos = vim.api.nvim_create_augroup("LastEditedPos", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufReadPost" }, {
  callback = function()
    local row, column = unpack(vim.api.nvim_buf_get_mark(0, "\""))
    local buf_line_count = vim.api.nvim_buf_line_count(0)

    if row >= 1 and row <= buf_line_count then
      vim.api.nvim_win_set_cursor(0, { row, column })
    end
  end,
  group = lastEditPos
})

local helpFiles = vim.api.nvim_create_augroup("HelpHelp", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  command = "resize +13",
  group = helpFiles
})

local closeNvimTree = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  command = "if (winnr('$') == 1 && &filetype == 'nvimtree') | q | endif",
  group = closeNvimTree
})
