-- ============================================================================
-- HELPER FUNCTIONS
-- ============================================================================

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
    vim.api.nvim_exec2("execute getline('.')", {})
  end
end

function M.run_visual_selection()
  -- Get the range of the visual selection
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_line, end_line = start_pos[2], end_pos[2]

  -- Get selected lines
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  if #lines == 0 then return end

  -- Join into a single command string
  local cmd = table.concat(lines, "\n")

  -- Run the command(s)
  vim.cmd(cmd)
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

local state = {
  floating = {
    buf = -1,
    win = -1
  }
}

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.75)

  -- calculate the position to center the window
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local buf = nil
  -- if the buffer exists then set it to buf
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    -- if the buffer doesnt't exist create a new one
    buf = vim.api.nvim_create_buf(false, true)
  end

  -- configure window
  local win_config = {
    relative = "win",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
  }

  -- create the floating window
  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

function M.float_terminal(cmd)
  cmd = cmd or ""
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window { buf = state.floating.buf}
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.cmd("terminal " .. cmd)
      vim.cmd.startinsert()
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
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

local variant = { "calmblue", "darkerblue" }
local current = 1
function M.toggle_colourschemes()
  current = current % #variant + 1
  -- vim.cmd("colorscheme " .. variant[current])
  vim.g.calmblue_variant = variant[current]
  print("Variant set to " .. variant[current])
end

local background = { 'dark', 'light' }
local current_background = 1
function M.toggle_light_and_dark_background()
  current_background = current_background % #background + 1
  vim.cmd("set background=" .. background[current_background])
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


return M
