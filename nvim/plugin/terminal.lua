vim.keymap.set("t", "<C-[><C-[>", "<C-\\><C-n>")

vim.keymap.set("t", "<C-w><C-h>", "<cmd>wincmd h<CR>")
vim.keymap.set("t", "<C-w><C-j>", "<cmd>wincmd j<CR>")
vim.keymap.set("t", "<C-w><C-k>", "<cmd>wincmd k<CR>")
vim.keymap.set("t", "<C-w><C-l>", "<cmd>wincmd l<CR>")

vim.keymap.set("t", "<M-h>", "<C-\\><C-n><C-W>1<i")
vim.keymap.set("t", "<M-l>", "<C-\\><C-n><C-W>2>i")
vim.keymap.set("t", "<M-j>", "<C-\\><C-n><C-W>2-i")
vim.keymap.set("t", "<M-k>", "<C-\\><C-n><C-W>2+i")

vim.keymap.set("t", "gt", "<cmd>tabn<CR>")
vim.keymap.set("t", "gT", "<cmd>tabp<CR>")

vim.keymap.set({ "n", "t" }, ";tt", function()
  require("terminal").toggle_terminal {}
end)

vim.keymap.set("n", ";lg", function()
  require("terminal").toggle_terminal { name = "lazygit", floating = true, cmd = "lazygit" }
end)

vim.keymap.set({ "n", "t" }, ";vt", function()
  require("terminal").toggle_terminal { direction = "right" }
end)

vim.keymap.set({ "n", "t" }, ";;t", function()
  vim.cmd "tabnew"
  vim.cmd "term"
  vim.cmd "startinsert"
end)

vim.keymap.set({ "n", "t" }, ";ft", function()
  require("terminal").toggle_terminal { name = "floating", floating = true }
end)

local group = vim.api.nvim_create_augroup("TerminalSettings", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
  group = group,
  pattern = "*",
  callback = function()
    vim.opt_local.cursorline = false
    vim.opt_local.cursorlineopt = "number"
    vim.opt_local.scrolloff = 0
    vim.wo.statuscolumn = ""
    vim.wo.winfixwidth = true
    vim.wo.winfixheight = true
    vim.bo.filetype = "terminal"
    vim.opt_local.winhighlight = "Normal:TerminalNormal"
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = group,
  pattern = "*",
  callback = function()
    if vim.bo.buftype == "terminal" then
      vim.cmd "startinsert"
    end
  end,
})
