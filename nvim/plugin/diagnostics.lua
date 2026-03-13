vim.diagnostic.config {
  severity_sort = true,
  signs = true,
  virtual_text = false,
  jump = {
    float = true,
    wrap = false,
  },
}

-- :h diagnostic-toggle-virtual-lines-example
vim.keymap.set("n", "gL", function()
  local virtlines_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = virtlines_config })
end, { desc = "Toggle virtual diagnostic lines" })

vim.keymap.set("n", "gV", function()
  local virttext_config = not vim.diagnostic.config().virtual_text
  vim.diagnostic.config({ virtual_text = virttext_config })
end, { desc = "Toggle virtual diagnostic text" })

vim.keymap.set("n", "<leader>sd", vim.diagnostic.setloclist, { desc = "Diagnostics to location list" })
vim.keymap.set("n", "<leader>sD", vim.diagnostic.setqflist, { desc = "Diagnostics to quickfix" })
