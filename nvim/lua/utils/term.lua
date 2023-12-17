local M = {}

---Get the name of the process running in the terminal
---@param buf integer terminal buffer handler
---@return string process name
function M.proc_name(buf)
  if not vim.api.nvim_buf_is_valid(buf) or vim.bo[buf].bt ~= 'terminal' then
    return ''
  end
  local channel = vim.bo[buf].channel
  local chan_valid, pid = pcall(vim.fn.jobpid, channel)
  if not chan_valid then
    return ''
  end
  return vim.trim(vim.fn.system('ps h -o comm -g ' .. pid .. ' | tail -n1'))
end

return M
