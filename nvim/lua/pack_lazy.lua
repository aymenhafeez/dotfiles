local M = {}

local group = vim.api.nvim_create_augroup("lazy-load", { clear = false })

function M.on(event, fn, pattern)
  vim.api.nvim_create_autocmd(event, {
    group = group,
    once = true,
    pattern = pattern,
    callback = fn
  })
end

return M
