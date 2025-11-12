local state = {
  buf = -1,
  win = -1,
}

local function create_window(opts)
  opts = opts or {}
  local direction = opts.split or "below"
  local is_vertical = direction == "left" or direction == "right"
  local size_key = is_vertical and "width" or "height"
  local size = is_vertical and math.floor(vim.o.columns * 0.45) or math.floor(vim.o.lines * 0.3)

  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  local win_config = {
    split = direction,
    [size_key] = size,
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

local function toggle_terminal(cmd, direction)
  cmd = cmd or ""
  direction = direction or "below"
  if not vim.api.nvim_win_is_valid(state.win) then
    state = create_window { buf = state.buf, split = direction }
    if vim.bo[state.buf].buftype ~= "terminal" then
      vim.cmd("terminal " .. cmd)
      vim.cmd "startinsert"
    end
  else
    vim.api.nvim_win_hide(state.win)
  end
end

local directions = { "left", "right", "above", "below" }

vim.api.nvim_create_user_command("TermTog", function(opts)
  local args = opts.fargs
  local cmd, direction
  if #args == 0 then
    cmd = ""
    direction = "below"
  elseif #args == 1 then
    if vim.tbl_contains(directions, args[1]) then
      cmd = ""
      direction = args[1]
    else
      cmd = args[1]
      direction = "below"
    end
  else
    cmd = args[1]
    direction = args[2]
  end
  -- Validate direction
  if not vim.tbl_contains(directions, direction) then
    direction = "below"
  end
  toggle_terminal(cmd, direction)
end, { nargs = "*" })
