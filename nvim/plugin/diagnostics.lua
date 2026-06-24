vim.diagnostic.config {
  severity_sort = true,
  signs = false,
  virtual_text = {
    source = "if_many",
    -- prefix = " ■",
  },
  float = {
    source = "if_many",
  },
  jump = {
    on_jump = function()
      vim.diagnostic.open_float()
    end,
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

vim.keymap.set("n", "<leader>sd", vim.diagnostic.setloclist, { desc = "Document diagnostics" })
vim.keymap.set("n", "<leader>sD", vim.diagnostic.setqflist, { desc = "Workspace diagnostics" })
