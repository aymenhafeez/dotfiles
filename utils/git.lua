local M = {}

---Print git command error
---@param cmd string[] shell command
---@param msg string error message
---@param lev number? log level to use for errors, defaults to WARN
---@return nil
function M.error(cmd, msg, lev)
  lev = lev or vim.log.levels.WARN
  vim.notify(
    '[git] failed to execute git command: '
      .. table.concat(cmd, ' ')
      .. '\n'
      .. msg,
    lev
  )
end

---Execute git command in given directory synchronously
---@param path string
---@param cmd string[] git command to execute
---@param error_lev number? log level to use for errors, hide errors if nil or false
---@reurn { success: boolean, output: string }
function M.dir_execute(path, cmd, error_lev)
  local shell_args = { 'git', '-C', path, unpack(cmd) }
  local shell_out = vim.fn.system(shell_args)
  if vim.v.shell_error ~= 0 then
    if error_lev then
      M.error(shell_args, shell_out, error_lev)
    end
    return {
      success = false,
      output = shell_out,
    }
  end
  return {
    success = true,
    output = shell_out,
  }
end

---Execute git command in current directory synchronously
---@param cmd string[] git command to execute
---@param error_lev number? log level to use for errors, hide errors if nil or false
---@return { success: boolean, output: string }
function M.execute(cmd, error_lev)
  local shell_args = { 'git', unpack(cmd) }
  local shell_out = vim.fn.system(shell_args)
  if vim.v.shell_error ~= 0 then
    if error_lev then
      M.error(shell_args, shell_out, error_lev)
    end
    return {
      success = false,
      output = shell_out,
    }
  end
  return {
    success = true,
    output = shell_out,
  }
end

---Store git branch names for each path
---@type table<string, string>
local path_branches = {}

vim.api.nvim_create_autocmd('FileChangedShellPost', {
  group = vim.api.nvim_create_augroup('RefreshGitBranchCache', {}),
  callback = function()
    path_branches = {}
  end,
})

---Get the current branch name asynchronously
---@param path string? defaults to the path to the current buffer
---@return string branch name
function M.branch(path)
  path = vim.fs.normalize(path or vim.api.nvim_buf_get_name(0))
  local dir = vim.fs.dirname(path)
  if not dir then
    return ''
  end
  local branch = path_branches[dir]
  if branch then
    return branch
  end
  vim.system(
    { 'git', '-C', dir, 'rev-parse', '--abbrev-ref', 'HEAD' },
    { stderr = false },
    function(err, _)
      path_branches[dir] = err.stdout:gsub('\n.*', '')
    end
  )
  return ''
end

---Store git diff stats for each buffer
---@type table<string, {added: integer, removed: integer, changed: integer}>
local buf_diffstats = {}

vim.api.nvim_create_autocmd('BufWrite', {
  group = vim.api.nvim_create_augroup('RefreshGitDiffCache', {}),
  callback = function(info)
    buf_diffstats[info.buf] = nil
  end,
})

---Get the diff stats for the current buffer asynchronously
---@param buf integer? buffer handler, defaults to the current buffer
---@return {added: integer?, removed: integer?, changed: integer?} diff stats
function M.diffstat(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  local path = vim.fs.normalize(vim.api.nvim_buf_get_name(buf))
  local dir = vim.fs.dirname(path)
  if not dir or M.branch(path):find('^%s*$') then
    return {}
  end
  local diffstat = buf_diffstats[buf]
  if diffstat then
    return diffstat
  end
  vim.system({
    'git',
    '-C',
    dir,
    '--no-pager',
    'diff',
    '-U0',
    '--no-color',
    '--no-ext-diff',
    '--',
    path,
  }, { stderr = false }, function(err, _)
    local stat = { added = 0, removed = 0, changed = 0 }
    for _, line in ipairs(vim.split(err.stdout, '\n')) do
      if line:find('^@@ ') then
        local num_lines_old, num_lines_new =
          line:match('^@@ %-%d+,?(%d*) %+%d+,?(%d*)')
        num_lines_old = tonumber(num_lines_old) or 1
        num_lines_new = tonumber(num_lines_new) or 1
        local num_lines_changed = math.min(num_lines_old, num_lines_new)
        stat.changed = stat.changed + num_lines_changed
        if num_lines_old > num_lines_new then
          stat.removed = stat.removed + num_lines_old - num_lines_changed
        else
          stat.added = stat.added + num_lines_new - num_lines_changed
        end
      end
    end
    buf_diffstats[buf] = stat
  end)
  return {}
end

return M
