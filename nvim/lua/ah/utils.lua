local M = {}

M.source_lua = function()
  if vim.bo.filetype == "lua" then
    vim.api.nvim_exec("luafile %", false)
  elseif vim.bo.filetype == "vim" then
    vim.api.nvim_exec("source %", false)
  end
end

return M
