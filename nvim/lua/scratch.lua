local M = {}

local width = math.floor(vim.o.columns * 0.8)
local height = math.floor(vim.o.lines * 0.8)
local col = math.floor((vim.o.columns - width) / 2)
local row = math.floor((vim.o.lines - height) / 2)

local default_config = {
  window_type = "split",

  float_config = {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = " Scratch ",
    title_pos = "center",
  },

  split_config = {
    split = "below",
  },

  buf_options = {
    buftype = "nofile",
    bufhidden = "hide",
    swapfile = false,
    filetype = "markdown",
  },

  win_options = {
    number = false,
    relativenumber = false,
    wrap = true,
  },
}

local state = {
  buf = -1,
  win = -1,
  config = {},
}

local function merge_tables(target, source)
  for key, value in pairs(source) do
    if type(value) == "table" and type(target[key]) == "table" then
      merge_tables(target[key], value)
    else
      target[key] = value
    end
  end
  return target
end

local function get_or_create_buffer()
  if state.buf and vim.api.nvim_buf_is_valid(state.buf) then
    return state.buf
  end

  local buf = vim.api.nvim_create_buf(false, true)

  for option, value in pairs(state.config.buf_options) do
    vim.api.nvim_set_option_value(option, value, { buf = buf })
  end

  state.buf = buf
  return buf
end

local function create_float_window(buf)
  local config = vim.deepcopy(state.config.float_config)

  if not config.row then
    config.row = math.floor((vim.o.lines - config.height) / 2)
  end
  if not config.col then
    config.col = math.floor((vim.o.columns - config.width) / 2)
  end

  local win = vim.api.nvim_open_win(buf, true, config)

  for option, value in pairs(state.config.win_options) do
    ---@diagnostic disable-next-line: deprecated
    vim.api.nvim_win_set_option(win, option, value)
  end

  return win
end

local function create_split_window(buf)
  local config = vim.deepcopy(state.config.split_config)
  local split_direction = config.split or "below"

  local is_vertical = split_direction == "left" or split_direction == "right"
  local size_key = is_vertical and "width" or "height"

  if not config[size_key] then
    if is_vertical then
      ---@diagnostic disable-next-line: assign-type-mismatch
      config[size_key] = math.floor(vim.o.columns * 0.3)
    else
      ---@diagnostic disable-next-line: assign-type-mismatch
      config[size_key] = math.floor(vim.o.lines * 0.3)
    end
  end

  local win = vim.api.nvim_open_win(buf, true, config)

  for option, value in pairs(state.config.win_options) do
    ---@diagnostic disable-next-line: deprecated
    vim.api.nvim_win_set_option(win, option, value)
  end

  return win
end

local function create_regular_window(buf)
  vim.cmd("enew")
  vim.api.nvim_win_set_buf(0, buf)

  for option, value in pairs(state.config.win_options) do
    ---@diagnostic disable-next-line: deprecated
    vim.api.nvim_win_set_option(0, option, value)
  end

  return vim.api.nvim_get_current_win()
end

function M.open(opts)
  opts = opts or {}

  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_set_current_win(state.win)
    return
  end

  local buf = get_or_create_buffer()
  local win

  local temp_config = vim.deepcopy(state.config)
  if opts.window_type then
    temp_config.window_type = opts.window_type
  end
  if opts.float_config then
    temp_config.float_config = merge_tables(temp_config.float_config, opts.float_config)
  end
  if opts.split_config then
    temp_config.split_config = merge_tables(temp_config.split_config, opts.split_config)
  end

  local window_type = temp_config.window_type
  if window_type == "float" then
    state.config = temp_config
    win = create_float_window(buf)
  elseif window_type == "split" then
    state.config = temp_config
    win = create_split_window(buf)
  else
    state.config = temp_config
    win = create_regular_window(buf)
  end

  state.win = win
end

function M.close()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, false)
    state.win = nil
  end
end

function M.toggle(opts)
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    M.close()
  else
    M.open(opts)
  end
end

function M.clear()
  if state.buf and vim.api.nvim_buf_is_valid(state.buf) then
    vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, {})
  end
end

function M.setup(user_config)
  user_config = user_config or {}

  state.config = vim.deepcopy(default_config)
  state.config = merge_tables(state.config, user_config)

  vim.api.nvim_create_user_command("ScratchOpen", function()
    M.open()
  end, {})

  vim.api.nvim_create_user_command("ScratchClose", function()
    M.close()
  end, {})

  vim.api.nvim_create_user_command("ScratchToggle", function()
    M.toggle()
  end, {})

  vim.api.nvim_create_user_command("ScratchClear", function()
    M.clear()
  end, {})
end

return M
