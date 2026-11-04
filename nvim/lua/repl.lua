local M = {}

M.job_id = nil
M.backend = nil
M.qtconsole_python = "python3"

local bridge = debug.getinfo(1, "S").source:sub(2):gsub("repl%.lua$", "repl_qtconsole.py")

M.create_repl = function()
  if M.job_id then
    return
  end
  M.backend = vim.g.repl_opt or "ipython"
  local on_exit = function()
    M.job_id = nil
  end
  if M.backend == "qtconsole" then
    M.job_id = vim.fn.jobstart({ M.qtconsole_python, bridge }, { on_exit = on_exit })
  else
    if vim.api.nvim_win_get_width(0) < 180 then
      vim.cmd("botright 15new")
    else
      vim.cmd(math.floor(vim.o.columns * 0.45) .. "vnew")
    end
    M.job_id = vim.fn.jobstart({ "ipython" }, { term = true, on_exit = on_exit })
    vim.wait(100)
  end
end

local function send(code)
  M.create_repl()
  if M.backend == "qtconsole" then
    vim.fn.chansend(M.job_id, vim.json.encode(code) .. "\n")
  else
    vim.fn.chansend(M.job_id, "\x1b[200~" .. code .. "\x1b[201~\n\n")
  end
end

M.send_repl_line = function()
  send(vim.fn.getline("."))
end

M.send_repl_selection = function()
  local lines = vim.fn.getregion(vim.fn.getpos("'<"), vim.fn.getpos("'>"), { type = vim.fn.visualmode() })
  send(table.concat(lines, "\n"))
end

M.send_repl_buffer = function()
  send(table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n"))
end

return M
