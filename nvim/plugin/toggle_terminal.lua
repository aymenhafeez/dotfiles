local state = {
  floating = {
    buf = -1,
    win = -1
  }
}

local function create_floating_window(opts)
  opts =opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.4)

  local buf = nil
  -- if the buffer exists then set it to buf
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    -- if the buffer doesnt't exist create a new one
    buf = vim.api.nvim_create_buf(false, true)
  end

  local win_config = {
    split = "right",
    width = width
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

local toggle_terminal = function(cmd)
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

vim.api.nvim_create_user_command("TermTog",
  function(opts)
    local cmd = table.concat(opts.fargs, " ")
    toggle_terminal(cmd)
  end, { nargs = "*" }
)
