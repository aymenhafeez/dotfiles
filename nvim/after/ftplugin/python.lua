local opts = { noremap = true, silent = true }
local nopts = { noremap = true, silent = false }
local map = vim.api.nvim_set_keymap

vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.cmd [[
function! GetFilePath()
  let @" = '%run ' . expand("%:p")
endfunction
]]

-- map("n", "<leader>py", ":%w !QT_QPA_PLATFORM=wayland python3<CR>", nopts)
-- map("n", "<leader>px", "mxVgg:%w !python<CR>`x", nopts)
-- map("x", "<leader>py", ":%w !python<CR>", nopts)

-- map("n", "<leader>jc", "<cmd>JupyterConnect<CR>", opts)
-- map("n", "<leader>jr", "<cmd>JupyterRunFile<CR>", opts)
-- map("n", "<leader>js", "<cmd>JupyterSendRange<CR>", opts)
-- map("v", "<leader>jr", "<cmd>JupyterRunVisual<CR>", opts)
-- map("x", "<leader>jr", "<cmd>JupyterSendCell<CR>", opts)

-- vim.keymap.set("n", "<leader>me", "<cmd>MoltenEvaluateLine<CR>", {})

-- insert python environment for ipynb files
map("n", "<leader>ip", "i```python<CR>```<Esc>O", { silent = true })
