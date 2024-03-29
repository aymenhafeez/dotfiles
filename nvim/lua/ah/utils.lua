local M = {}

function M.reload_config()
  for name, _ in pairs(package.loaded) do
    if name:match("ah") then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  vim.api.nvim_exec2("source ~/.config/nvim/after/ftplugin/lua.lua", {})
  vim.notify("Reloaded configuration", vim.log.levels.INFO, { title = "init.lua" })
end

function M.execute_line()
  if vim.bo.filetype == "lua" then
    vim.api.nvim_exec2("execute(printf(\":lua %s\", getline(\".\")))", {})
  elseif vim.bo.filetype == "vim" then
    vim.api.nvim_exec2("execute getline('>')", {})
  end
end

function M.source_lua()
  local message = vim.fn.expand("%:t") .. " sourced"
  if vim.bo.filetype == "lua" then
    vim.api.nvim_exec2("luafile %", {})
    vim.notify(message)
  elseif vim.bo.filetype == "vim" then
    vim.api.nvim_exec2("source %", {})
    vim.notify(message)
  end
end

function M.require(mod)
  return M.try(require, mod)
end

function M.try(fn, ...)
  local args = { ... }

  return xpcall(function()
    return fn(unpack(args))
  end, function(err)
    local lines = {}
    table.insert(lines, err)
    table.insert(lines, debug.traceback("", 3))

    M.error(table.concat(lines, "\n"))
    return err
  end)
end

local function hexToRgb(hex_str)
  local hex = "[abcdef0-9][abcdef0-9]"
  local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
  hex_str = string.lower(hex_str)

  assert(string.find(hex_str, pat) ~= nil,
    "hex_to_rgb: invalid hex_str: " .. tostring(hex_str))

  local r, g, b = string.match(hex_str, pat)
  return { tonumber(r, 16), tonumber(g, 16), tonumber(b, 16) }
end

local function blend(fg, bg, alpha)
  bg = hexToRgb(bg)
  fg = hexToRgb(fg)

  local blendChannel = function(i)
    local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format("#%02X%02X%02X", blendChannel(1), blendChannel(2), blendChannel(3))
end

function M.darken(hex, amount, bg)
  return blend(hex, bg or M.bg, math.abs(amount))
end

function M.lighten(hex, amount, fg)
  return blend(hex, fg or M.fg, math.abs(amount))
end

function M.hl_str(str, hl_cur, hl_after)
  if hl_after == nil then
    return "%#" .. hl_cur .. "#" .. str .. "%*"
  end
  return "%#" .. hl_cur .. "#" .. str .. "%*" .. "%#" .. hl_after .. "#"
end

function M.float_terminal(cmd)
  local buf = vim.api.nvim_create_buf(false, true)
  local vpad = 4
  local hpad = 10
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = vim.o.columns - hpad * 2,
    height = vim.o.lines - vpad * 2,
    row = vpad,
    col = hpad,
    style = "minimal",
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  })
  vim.fn.termopen(cmd)
  local autocmd = {
    "autocmd! TermClose <buffer> lua",
    string.format("vim.api.nvim_win_close(%d, {force = true});", win),
    string.format("vim.api.nvim_buf_delete(%d, {force = true});", buf),
  }
  vim.cmd(table.concat(autocmd, " "))
  vim.cmd([[startinsert]])
end

function M.version()
  local v = vim.version()
  if not v.prerelease then
    vim.notify(
      ("Neovim v%d.%d.%d"):format(v.major, v.minor, v.patch),
      vim.log.levels.WARN,
      { title = "Neovim not running nightly" }
    )
  end
end

function M.warn(msg, name)
  vim.notify(msg, vim.log.levels.WARN, { title = name or "init.lua" })
end

function M.error(msg, name)
  vim.notify(msg, vim.log.levels.ERROR, { title = name or "init.lua" })
end

function M.info(msg, name)
  vim.notify(msg, vim.log.levels.INFO, { title = name or "init.lua" })
end

M.treesitter_cmds = {
  "TSInstall",
  "TSBufEnable",
  "TSBufDisable",
  "TSEnable",
  "TSDisable",
  "TSModuleInfo",
}

function M.border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

M.icons = {
  Namespace = "",
  Text = " ",
  Method = " ",
  Function = " ",
  Constructor = " ",
  Field = " ",
  Variable = "",
  Class = " ",
  Interface = " ",
  Module = " ",
  Property = " ",
  Unit = " ",
  Value = "󰉻 ",
  Enum = " ",
  Keyword = " ",
  Snippet = " ",
  Color = " ",
  File = " ",
  Reference = " ",
  Folder = " ",
  EnumMember = " ",
  Constant = " ",
  Struct = " ",
  Event = " ",
  Operator = " ",
  TypeParameter = " ",
  Table = "",
  Object = "  ",
  Tag = "",
  Array = "[]",
  Boolean = " ",
  Number = " ",
  Null = "ﳠ",
  String = " ",
  Calendar = "",
  Watch = " ",
  Package = " ",
}

M.diagnostic_signs = {
    Error = ' ',
    Warn = ' ',
    Info = ' ',
    Hint = ' ',
}

M.kind_icons = {
    Text = ' ',
    Method = ' ',
    Function = '󰊕 ',
    Constructor = ' ',
    Field = ' ',
    Variable = ' ',
    Class = '󰠱 ',
    Interface = ' ',
    Module = '󰏓 ',
    Property = ' ',
    Unit = ' ',
    Value = ' ',
    Enum = ' ',
    EnumMember = ' ',
    Keyword = '󰌋 ',
    Snippet = '󰲋 ',
    Color = ' ',
    File = ' ',
    Reference = ' ',
    Folder = ' ',
    Constant = '󰏿 ',
    Struct = '󰠱 ',
    Event = ' ',
    Operator = ' ',
    TypeParameter = '󰘦 ',
    TabNine = '󰚩 ',
    Copilot = ' ',
    Unknown = ' ',
}

-- doesn't quite work yet
-- function M.create_centered_floating_window()
--     local width = math.min(vim.api.nvim_get_option('columns') - 4, math.max(80, vim.api.nvim_get_option('columns') - 20))
--     local height = math.min(vim.api.nvim_get_option('lines') - 4, math.max(20, vim.api.nvim_get_option('lines') - 10))
--     local top = math.floor((vim.api.nvim_get_option('lines') - height) / 2) - 1
--     local left = math.floor((vim.api.nvim_get_option('columns') - width) / 2)
--     local opts = {
--         relative = 'editor',
--         row = top,
--         col = left,
--         width = width,
--         height = height,
--         style = 'minimal',
--     }
--
--     local top_border = '╭' .. string.rep('─', width - 2) .. '╮'
--     local mid_border = '│' .. string.rep(' ', width - 2) .. '│'
--     local bot_border = '╰' .. string.rep('─', width - 2) .. '╯'
--     local lines = {top_border}
--     for _ = 1, height - 2 do
--         table.insert(lines, mid_border)
--     end
--     table.insert(lines, bot_border)
--
--     local buf = vim.api.nvim_create_buf(false, true)
--     vim.api.nvim_buf_set_lines(buf, 0, -1, true, lines)
--     vim.api.nvim_open_win(buf, true, opts)
--     vim.cmd('set winhl=Normal:Floating')
--
--     opts.row = opts.row + 1
--     opts.height = opts.height - 2
--     opts.col = opts.col + 2
--     opts.width = opts.width - 4
--
--     local text_buf = vim.api.nvim_create_buf(false, true)
--     vim.api.nvim_open_win(text_buf, true, opts)
--
--     vim.cmd('autocmd BufWipeout <buffer> exe "bw " .. ' .. buf)
--     return text_buf
-- end

-- doesn't quite work yet
-- function M.floating_window_help(query)
--     local buf = M.create_centered_floating_window()
--     vim.api.nvim_set_current_buf(buf)
--     vim.api.nvim_buf_set_option(buf, 'filetype', 'help')
--     vim.api.nvim_buf_set_option(buf, 'buftype', 'help')
--     vim.cmd('execute "help " .. a:query')
-- end

-- function M.float_help()
--   -- Create a new buffer for the floating window
--   local buf = vim.api.nvim_create_buf(false, true)
--
--   -- Set padding for the floating window
--   local vpad = 4
--   local hpad = 10
--
--   -- Calculate the width and height of the floating window
--   local win_width = vim.o.columns - hpad * 2
--   local win_height = vim.o.lines - vpad * 2
--
--   -- Calculate the row and column positions for centering the window
--   local win_row = math.floor((vim.o.lines - win_height) / 2)
--   local win_col = math.floor((vim.o.columns - win_width) / 2)
--
--   -- Create the floating window with minimal styling and custom borders
--   local win = vim.api.nvim_open_win(buf, true, {
--     relative = "editor",
--     width = win_width,
--     height = win_height,
--     row = win_row,
--     col = win_col,
--     style = "minimal",
--     border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
--   })
--
--   -- Get the word under the cursor and display its help
--   local word_under_cursor = vim.fn.expand("<cword>")
--
--   -- Open the help in a new window
--   vim.cmd("help " .. word_under_cursor .. " new")
--
--   -- Move the newly opened help window to the floating window
--   local help_win = vim.fn.bufwinnr("^hlp")
--   if help_win ~= -1 then
--     vim.fn.win_gotoid(win)
--   end
--
--   -- Set up an autocmd to close the window and delete the buffer when it's no longer needed
--   local autocmd = {
--     "autocmd! BufWinLeave <buffer> lua",
--     string.format("vim.api.nvim_win_close(%d, {force = true});", win),
--     string.format("vim.api.nvim_buf_delete(%d, {force = true});", buf),
--   }
--   vim.cmd(table.concat(autocmd, " "))
-- end

return M
