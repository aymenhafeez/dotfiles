local termOpts = vim.api.nvim_create_augroup("TermOpts", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  -- command = "setlocal nonumber norelativenumber nocursorline",
  callback = function()
    vim.api.nvim_exec2("setlocal nonumber norelativenumber nocursorline", {})
    vim.opt.winhighlight = "Normal:NeoTreeNormal,SignColumn:NeoTreeNormal"
  end,
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
    vim.highlight.on_yank({
      higroup = "Visual",
      timeout = 75
    })
  end,
  pattern = '*',
  group = highlightGroup,
})

vim.api.nvim_create_autocmd("BufReadPre", {
  pattern = "*",
  callback = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "<buffer>",
      once = true,
      callback = function()
        vim.cmd(
          [[if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif]]
        )
      end,
    })
  end,
})

local helpFiles = vim.api.nvim_create_augroup("HelpHelp", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  callback = function()
    vim.api.nvim_exec2("wincmd L | vertical resize -8", {})
    vim.opt.winhighlight = "Normal:NeoTreeNormal,SignColumn:NeoTreeNormal"
    vim.opt_local.wrap = false
    vim.opt_local.linebreak = false
  end,
  group = helpFiles
})

local packerHighlight = vim.api.nvim_create_augroup("PackerHiglight", { clear = true})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "packer",
  -- command = "lua vim.opt.winhighlight = 'Normal:NvimTreeNormal,SignColumn:NvimTreeNormal'",
  callback = function()
    vim.opt.winhighlight = "Normal:NeoTreeNormal,SignColumn:NeoTreeNormal"
  end,
  group = packerHighlight
})

local closeNvimTree = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  command = "if (winnr('$') == 1 && &filetype == 'nvimtree') | q | endif",
  group = closeNvimTree
})

local checkTime = vim.api.nvim_create_augroup("CheckTime", { clear = false })
vim.api.nvim_create_autocmd("FocusGained", {
  pattern = "*",
  command = "checktime",
  group = checkTime
})
