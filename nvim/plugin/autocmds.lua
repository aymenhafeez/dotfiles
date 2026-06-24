vim.cmd [[
" :h restore-cursor
augroup RestoreCursor
  autocmd!
  autocmd BufReadPre * autocmd FileType <buffer> ++once
    \ let s:line = line("'\"")
    \ | if s:line >= 1 && s:line <= line("$") && &filetype !~# 'commit'
    \      && index(['xxd', 'gitrebase'], &filetype) == -1
    \      && !&diff
    \ |   execute "normal! g`\""
    \ | endif
augroup END

" :h vim.hl.on_yank()
autocmd TextYankPost * silent! lua vim.hl.on_yank {higroup='Visual', timeout=150}
]]

vim.opt.cursorline = true
if vim.opt.cursorline:get() == true then
  local group = vim.api.nvim_create_augroup("CursorLineCurrentWindow", { clear = true })
  local set_cursorline = function(event, value, pattern)
    vim.api.nvim_create_autocmd(event, {
      group = group,
      pattern = pattern,
      callback = function()
        vim.opt_local.cursorlineopt = value
      end,
    })
  end

  set_cursorline({ "InsertEnter", "BufLeave" }, "number")
  set_cursorline({ "InsertLeave", "BufEnter" }, "both")
  set_cursorline("FileType", "number", { "help" })
end


local function open_help()
  local win_width = vim.api.nvim_win_get_width(0)
  if win_width > 160 then
    vim.cmd "wincmd L"
    vim.cmd "vertical resize -11"
  end
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "man" },
  callback = open_help
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.txt",
  callback = function()
    if vim.bo.buftype == "help" then
      open_help()
    end
  end
})

-- vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
--   callback = function()
--     local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
--     if not normal.bg then return end
--     io.write(string.format("\027]11;#%06x\027\\", normal.bg))
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("UILeave", {
--   callback = function() io.write("\027]111\027\\") end,
-- })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "dbout", "dbui", "DiffviewFiles", "DiffviewFileHistory", "qf", "help", "man" },
  callback = function()
    vim.opt_local.winhighlight = "Normal:SidebarNormal"
    vim.wo.statuscolumn = ""
  end
})

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "dbout", "dbui", "DiffviewFileHistory" },
--   callback = function()
--     vim.opt_local.winhighlight = "Normal:SidebarNormal"
--     vim.wo.statuscolumn = ""
--   end
-- })
