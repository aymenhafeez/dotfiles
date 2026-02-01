local map = vim.keymap.set

vim.opt_local.autoindent = true
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4

vim.cmd [[
function! GetFilePath()
  let @" = '%run ' . expand("%:p")
endfunction
]]

vim.api.nvim_create_user_command("PY", function()
  local output = vim.fn.execute ":%w !QT_QPA_PLATFORM=wayland python3"
  local split_lines = vim.split(output, "\n")
  vim.fn.setqflist({}, "a", {
    title = "PYTHON",
    lines = split_lines,
  })
  vim.cmd "copen"
  vim.cmd "normal G"
end, {})

map("n", "<leader>po", "<cmd>PY<CR>")
