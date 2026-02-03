local function tabline()
  local t = ""
  local tabpages = vim.api.nvim_list_tabpages()
  local current_tab = vim.api.nvim_get_current_tabpage()

  for _, tab in ipairs(tabpages) do
    local tab_num = vim.api.nvim_tabpage_get_number(tab)
    local is_current = (tab == current_tab)

    t = t .. "%" .. tab_num .. "T"
    t = t .. (is_current and "%#TabLineSel#" or "%#TabLine#")
    t = t .. " "

    local win = vim.api.nvim_tabpage_get_win(tab)
    local buf = vim.api.nvim_win_get_buf(win)
    local bufname = vim.api.nvim_buf_get_name(buf)

    local filename = vim.fn.fnamemodify(bufname, ":.")
    if filename == "" then
      filename = "[No name]"
    end

    if vim.api.nvim_get_option_value("modified", { buf = buf }) then
      t = t .. "[+]"
    end

    t = t .. filename .. " "
    t = t .. "%" .. tab_num .. "X✕%X "
  end

  t = t .. "%#TabLineFill#%T"

  return t
end

return {
  tabline = tabline
}
