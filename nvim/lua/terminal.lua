local M = {}

local instances = {}

local create_window = function(opts)
  opts = opts or {}
  local direction = opts.split or "below"
  local is_vertical = direction == "left" or direction == "right"
  local size_key = is_vertical and "width" or "height"
  local size = is_vertical and math.floor(vim.o.columns * 0.45) or math.floor(vim.o.lines * 0.35)
  local relative = "editor" or ""
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)
  local buf = nil

  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  local win_config

  if opts.floating == true then
    win_config = {
      relative = relative,
      width = width,
      height = height,
      col = col,
      row = row,
    }
  else
    win_config = {
      split = direction,
      [size_key] = size,
    }
  end

  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

M.toggle_terminal = function(opts)
  opts = opts or {}
  local cmd = opts.cmd or ""
  local direction = opts.direction or "below"
  local floating = opts.floating or false or ""
  local name = opts.name or "default"

  if not instances[name] then
    instances[name] = { buf = -1, win = -1 }
  end

  local state = instances[name]

  if not vim.api.nvim_win_is_valid(state.win) then
    state.buf = vim.api.nvim_buf_is_valid(state.buf) and state.buf or -1
    local result = create_window { buf = state.buf, split = direction, floating = floating }
    state.buf = result.buf
    state.win = result.win

    if vim.bo[state.buf].buftype ~= "terminal" then
      vim.cmd("terminal " .. cmd)
      vim.cmd "startinsert"
    end
  else
    vim.api.nvim_win_hide(state.win)
  end
end


M.list_instances = function()
  local active = {}
  for name, state in pairs(instances) do
    if vim.api.nvim_buf_is_valid(state.buf) then
      table.insert(active, name)
    end
  end
  return active
end

M.close_instance = function(name)
  if instances[name] and vim.api.nvim_buf_is_valid(instances[name].buf) then
    vim.api.nvim_buf_delete(instances[name].buf, { force = true })
    instances[name] = nil
  end
end

M.close_all = function()
  for name, _ in pairs(instances) do
    M.close_instance(name)
  end
end

return M
