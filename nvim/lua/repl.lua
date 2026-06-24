local M = {}

M.job_id = nil
M.pane_id = nil

local in_zellij = function()
  return vim.env.ZELLIJ ~= nil
end

local run_zellij_action = function(args)
  local cmd = { "zellij", "action" }
  vim.list_extend(cmd, args)
  local res = vim.system(cmd, { text = true }):wait()

  return res.code == 0, vim.trim(res.stdout or ""), vim.trim(res.stderr or "")
end

local get_selection = function()
  local start_pos = vim.api.nvim_buf_get_mark(0, "<")
  local end_pos = vim.api.nvim_buf_get_mark(0, ">")
  local text = vim.api.nvim_buf_get_text(0, start_pos[1] - 1, start_pos[2], end_pos[1] - 1, end_pos[2] + 1, {})

  return table.concat(text, "\n")
end

M.create_repl = function()
  if in_zellij() then
    if M.pane_id then
      return
    end

    local ok, out, err = run_zellij_action({
      "new-pane",
      "--direction",
      "right",
      "--name",
      "ipython",
      "--",
      "ipython",
    })

    if not ok then
      vim.notify("Failed to open zellij ipython pane: " .. err, vim.log.levels.ERROR)
      return
    end

    local pane_id = out:match("(terminal_%d+)") or out:match("(%d+)")
    if pane_id and pane_id:match("^%d+$") then
      pane_id = "terminal_" .. pane_id
    end

    if not pane_id then
      vim.notify("Could not detect new zellij pane id", vim.log.levels.ERROR)
      return
    end

    M.pane_id = pane_id
    run_zellij_action({ "focus-previous-pane" })
    return
  end

  local width = math.floor(vim.o.columns * 0.43)
  local win_width = vim.api.nvim_win_get_width(0)
  if not M.job_id then
    if win_width < 100 then
      vim.cmd("botright 15new")
      vim.bo.buflisted = false
    else
      vim.cmd(width .. "vnew")
      vim.bo.buflisted = false
    end
    M.job_id = vim.fn.jobstart({ "ipython" }, {
      term = true,
      on_exit = function()
        M.job_id = nil
      end,
    })

    vim.wait(100, function()
      return false
    end)
  end
end

local send_to_zellij_repl = function(text)
  if not M.pane_id then
    return false
  end

  local ok = run_zellij_action({ "paste", "--pane-id", M.pane_id, text })
  if not ok then
    M.pane_id = nil
    M.create_repl()
    if not M.pane_id then
      return false
    end
    ok = run_zellij_action({ "paste", "--pane-id", M.pane_id, text })
    if not ok then
      return false
    end
  end

  run_zellij_action({ "send-keys", "--pane-id", M.pane_id, "Enter" })
  return true
end

M.send_repl_line = function()
  M.create_repl()

  if in_zellij() then
    send_to_zellij_repl(vim.fn.getline ".")
    return
  end

  vim.fn.chansend(M.job_id, vim.fn.getline "." .. "\n")
end

M.send_repl_selection = function()
  M.create_repl()

  if in_zellij() then
    send_to_zellij_repl(get_selection())
    return
  end

  local selection = get_selection()
  local bracketed_paste_start = "\x1b[200~"
  local bracketed_paste_end = "\x1b[201~"

  vim.fn.chansend(M.job_id, bracketed_paste_start .. selection .. bracketed_paste_end .. "\n\n")
  vim.wait(50, function() return false end)
end

return M
