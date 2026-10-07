vim.keymap.set("t", "<C-[><C-[>", "<C-\\><C-n>")

vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>")
vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>")
vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>")
vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>")


vim.keymap.set({ "n", "t" }, ";tt", function()
  require("terminal").toggle_terminal {}
end)

vim.keymap.set({ "n", "t" }, "<C-Space>", function()
  require("terminal").toggle_terminal {}
end)

vim.keymap.set({ "n", "t" }, ";vt", function()
  require("terminal").toggle_terminal { direction = "right" }
end)

vim.keymap.set({ "n", "t" }, ";;t", function()
  vim.cmd "tabnew"
  vim.cmd "term"
  vim.cmd "startinsert"
end)

vim.keymap.set("n", ";st", function()
  vim.cmd "15new"
  vim.cmd "term"
  vim.cmd "wincmd J"
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
    vim.opt_local.scrolloff = 0
    -- vim.wo.winfixwidth = true
    -- vim.wo.winfixheight = true
    vim.bo.filetype = "terminal"
    vim.wo.cursorline = false
    vim.wo.cursorlineopt = "number"
    -- vim.opt_local.winhighlight = "Normal:TerminalNormal"
    vim.wo.statuscolumn = ""
    vim.b.miniindentscope_disable = true
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = group,
  pattern = "*",
  callback = function()
    if vim.bo.buftype == "terminal" then
      vim.cmd "startinsert"
      vim.wo.spell = false
    end
  end,
})
