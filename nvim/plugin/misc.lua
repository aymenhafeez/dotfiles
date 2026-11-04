vim.schedule(function()
  vim.pack.add({
    "https://github.com/neogitorg/neogit",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/esmuellert/codediff.nvim",
  }, { load = true })

  require("gitsigns").setup {
    current_line_blame = true,
  }

  vim.keymap.set("n", "gH", "<cmd>Gitsigns preview_hunk<CR>")
  vim.keymap.set("n", "gI", "<cmd>Gitsigns preview_hunk_inline<CR>")
  vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<CR>")
  vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<CR>")
  vim.keymap.set("n", "<leader>gd", "<cmd>Gitsigns diffthis<CR>")

  local is_ghostty = vim.fn.getenv("TERM") == "xterm-ghostty"
  require("neogit").setup {
    graph_style = is_ghostty and "kitty" or "unicode"
  }
end)

vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
    if not normal.bg then return end
    io.write(string.format("\027]11;#%06x\027\\", normal.bg))
  end,
})

vim.api.nvim_create_autocmd("UILeave", {
  callback = function() io.write("\027]111\027\\") end,
})
