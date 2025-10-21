-- ============================================================================
-- AUTOCOMMANDS
-- ============================================================================

-- Terminal customization
local term_augroup = vim.api.nvim_create_augroup("TerminalSettings", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Configure terminal appearance",
  pattern = "*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.cursorline = false
    vim.opt_local.winhighlight = "Normal:NormalDark"
    vim.b.miniindentscope_disable = true
  end,
  group = term_augroup
})

-- File type specific settings
local filetype_augroup = vim.api.nvim_create_augroup("FileTypeSettings", { clear = true })

-- Mason filetype customization
vim.api.nvim_create_autocmd("FileType", {
  desc = "Configure Mason interface",
  pattern = "mason",
  callback = function()
    vim.opt_local.cursorline = false
  end,
  group = filetype_augroup
})

-- QuickFix automation
local quickfix_augroup = vim.api.nvim_create_augroup("QuickFixSettings", { clear = true })
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  desc = "Auto-open QuickFix window for non-location list commands",
  pattern = "[^l]*",
  command = "cwindow",
  group = quickfix_augroup
})

-- Visual feedback on yank
local highlight_augroup = vim.api.nvim_create_augroup("HighlightSettings", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight yanked text briefly",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "Visual",
      timeout = 100
    })
  end,
  group = highlight_augroup
})

-- Cursor position restoration
local cursor_augroup = vim.api.nvim_create_augroup("CursorPosition", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Restore cursor position on file open",
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  group = cursor_augroup
})

-- File monitoring
local file_augroup = vim.api.nvim_create_augroup("FileMonitoring", { clear = true })
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  desc = "Check for file changes when focus is gained",
  pattern = "*",
  command = "checktime",
  group = file_augroup
})

-- sync alacritty background to neovim theme on ColorScheme change
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    if vim.g.colors_name == "calmblue" then
      local variant = vim.g.calmblue_variant or "calmblue"
      local bg = vim.o.background or "dark"
      local alacritty_variant
      if variant == "calmblue" and bg == "dark" then
        alacritty_variant = "calmblue-dark"
      elseif variant == "calmblue" and bg == "light" then
        alacritty_variant = "calmblue-light"
      elseif variant == "darkerblue" and bg == "dark" then
        alacritty_variant = "darkerblue-dark"
      elseif variant == "darkerblue" and bg == "light" then
        alacritty_variant = "darkerblue-light"
      end
      if alacritty_variant then
        vim.fn.system({"/usr/bin/bash", "/home/aymen/tmp/scripts/alacritty-theme.sh", alacritty_variant})
      end
    end
  end,
})
