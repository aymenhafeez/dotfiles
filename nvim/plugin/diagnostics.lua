vim.diagnostic.config {
  severity_sort = true,
  signs = false,
  virtual_text = true,
  jump = {
    float = true,
    wrap = false,
  },
  float = {
    source = true
  }
}

-- :h diagnostic-toggle-virtual-lines-example
vim.keymap.set("n", "gL", function()
  local virtlines_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = virtlines_config })
end)

-- toggle virtual_text
vim.keymap.set("n", "gV", function()
  local virttext_config = not vim.diagnostic.config().virtual_text
  vim.diagnostic.config({ virtual_text = virttext_config })
end)
