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
        vim.wo.cursorline = value
      end,
    })
  end

  set_cursorline({ "InsertEnter", "WinLeave" }, false)
  set_cursorline({ "InsertLeave", "WinEnter" }, true)
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

local is_konsole = os.getenv("KONSOLE_VERSION") ~= nil
local original_background
local background_ready = not is_konsole

local function set_terminal_background(color)
  io.write("\027]11;" .. color .. "\027\\")
  io.flush()
end

local function match_editor_background()
  if not background_ready then return end
  local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
  if normal.bg then
    set_terminal_background(string.format("#%06x", normal.bg))
  end
end

vim.api.nvim_create_autocmd("UIEnter", {
  callback = function()
    if not is_konsole then
      match_editor_background()
      return
    end

    -- save Konsole's current background so it can be restored explicitly
    vim.tty.request("\027]11;?\027\\", {
      timeout = 500,
      on_timeout = function()
        background_ready = true
        match_editor_background()
      end,
    }, function(response)
      local r, g, b = response:match("^\027%]11;rgb:(%x+)/(%x+)/(%x+)")
      if not r then return end
      local function to_byte(component)
        return math.floor(tonumber(component, 16) * 255 / (16 ^ #component - 1) + 0.5)
      end
      original_background = string.format("#%02x%02x%02x", to_byte(r), to_byte(g), to_byte(b))
      background_ready = true
      match_editor_background()
      return true
    end)
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = match_editor_background,
})

vim.api.nvim_create_autocmd("UILeave", {
  callback = function()
    if original_background then
      set_terminal_background(original_background)
    else
      io.write("\027]111\027\\")
      io.flush()
    end
  end,
})
