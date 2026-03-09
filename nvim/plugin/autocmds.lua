local function open_help()
  local win_width = vim.api.nvim_win_get_width(0)
  if win_width > 160 then
    vim.cmd "wincmd L"
    vim.cmd "vertical resize -11"
  end
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "man" },
  callback = open_help
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.txt",
  callback = function()
    if vim.bo.buftype == "help" then
      open_help()
    end
  end
})

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
