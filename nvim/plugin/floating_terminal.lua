local state = {
  floating = {
    buf = -1,
    win = -1
  }
}

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

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
    relative = "editor",
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

local function float_terminal(cmd)
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

vim.api.nvim_create_user_command("FloatTerm",
  function(opts)
    local cmd = table.concat(opts.fargs, " ")
    float_terminal(cmd)
  end, { nargs = "*"})
