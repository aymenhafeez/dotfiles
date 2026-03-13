vim.keymap.set("t", "<C-[><C-[>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>", { desc = "Move to left window" })
vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>", { desc = "Move to bottom window" })
vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>", { desc = "Move to top window" })
vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>", { desc = "Move to right window" })


vim.keymap.set({ "n", "t" }, ";tt", function()
  require("terminal").toggle_terminal {}
end, { desc = "Toggle terminal" })

vim.keymap.set({ "n", "t" }, ";vt", function()
  require("terminal").toggle_terminal { direction = "right" }
end, { desc = "Toggle vertical terminal" })

vim.keymap.set({ "n", "t" }, ";;t", function()
  vim.cmd "tabnew"
  vim.cmd "term"
  vim.cmd "startinsert"
end, { desc = "Open terminal in new tab" })

vim.keymap.set({ "n", "t" }, ";ft", function()
  require("terminal").toggle_terminal { name = "floating", floating = true }
end, { desc = "Toggle floating terminal" })

local group = vim.api.nvim_create_augroup("TerminalSettings", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
  group = group,
  pattern = "*",
  callback = function()
    vim.opt_local.scrolloff = 0
    vim.wo.statuscolumn = ""
    vim.wo.winfixwidth = true
    vim.wo.winfixheight = true
    vim.bo.filetype = "terminal"
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
