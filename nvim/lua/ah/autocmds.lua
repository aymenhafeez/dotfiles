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
    vim.highlight.on_yank({
      higroup = "Visual",
      timeout = 100
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
    vim.api.nvim_exec("wincmd L | vertical resize -9", false)
    vim.opt.winhighlight = "Normal:NvimTreeNormal,SignColumn:NvimTreeNormal"
  end,
  group = helpFiles
})

local packerHighlight = vim.api.nvim_create_augroup("PackerHiglight", { clear = true})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "packer",
  -- command = "lua vim.opt.winhighlight = 'Normal:NvimTreeNormal,SignColumn:NvimTreeNormal'",
  callback = function()
    vim.opt.winhighlight = "Normal:NvimTreeNormal,SignColumn:NvimTreeNormal"
  end,
  group = packerHighlight
})

local closeNvimTree = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  command = "if (winnr('$') == 1 && &filetype == 'nvimtree') | q | endif",
  group = closeNvimTree
})
