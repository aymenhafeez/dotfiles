local M = {}

function M.reload_config()
  for name, _ in pairs(package.loaded) do
    if name:match("ah") then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  vim.notify("Reloaded configuration", vim.log.levels.INFO, { title = "init.lua" })
end

function M.execute_line()
  if vim.bo.filetype == "lua" then
    vim.api.nvim_exec("execute(printf(\":lua %s\", getline(\".\")))", false)
  elseif vim.bo.filetype == "vim" then
    vim.api.nvim_exec("execute getline('>')", false)
  end
end

function M.source_lua()
  if vim.bo.filetype == "lua" then
    vim.api.nvim_exec("luafile %", false)
  elseif vim.bo.filetype == "vim" then
    vim.api.nvim_exec("source %", false)
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
      { title = "Neovim: not running nightly!" }
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

M.packer_cmds = {
  "PackerSnapshot",
  "PackerSnapshotRollback",
  "PackerSnapshotDelete",
  "PackerInstall",
  "PackerUpdate",
  "PackerSync",
  "PackerClean",
  "PackerCompile",
  "PackerStatus",
  "PackerProfile",
  "PackerLoad",
}

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
  Namespace = "",
  Text = "﬍ ",
  Method = " ",
  Function = " ",
  Constructor = " ",
  Field = "",
  Variable = " ",
  Class = " ",
  Interface = " ",
  Module = " ",
  Property = " ",
  Unit = " ",
  Value = " ",
  Enum = " ",
  Keyword = " ",
  Snippet = " ",
  Color = " ",
  File = " ",
  Reference = " ",
  Folder = " ",
  EnumMember = " ",
  Constant = " ",
  Struct = " ",
  Event = " ",
  Operator = " ",
  TypeParameter = " ",
  Table = "",
  Object = "  ",
  Tag = "",
  Array = "[]",
  Boolean = " ",
  Number = " ",
  Null = "ﳠ",
  String = " ",
  Calendar = "",
  Watch = " ",
  Package = " ",
}

--[[ -- testing some stuff
M.open_float = function()
  local opts = {
    relative = "cursor",
    bufpos = {0, 1},
    width = 40,
    height = 10,
    border = "rounded",
  }
  local buf vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(0, 0, -1, true, {"0", "1"})
  vim.api.nvim_open_win(0, true, opts)
end

M.tableCount = function(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end ]]

return M
