local function tabline()
  local s = ""
  local tabpages = vim.api.nvim_list_tabpages()
  local current_tab = vim.api.nvim_get_current_tabpage()
  local total_tabs = #tabpages

  local buffers = vim.api.nvim_list_bufs()
  local current_buf = vim.api.nvim_get_current_buf()

  for _, buf in ipairs(buffers) do
    if vim.api.nvim_get_option_value("buflisted", { buf = buf }) then
      local is_current = (buf == current_buf)
      local is_modified = vim.api.nvim_get_option_value("modified", { buf = buf })

      if is_current then
        s = s .. "%#TabLineSel#"
      elseif is_modified then
        s = s .. "%#DiagnosticError#"
      else
        s = s .. "%#TabLine#"
      end

      s = s .. "%" .. buf .. "@v:lua._tabline_goto_buffer@"

      local buf_name = vim.api.nvim_buf_get_name(buf)
      if buf_name == "" then
        buf_name = "[No name]"
      else
        buf_name = buf_name:gsub("%%", "%%%%")
      end

      local fname
      local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })
      if filetype == "help" then
        fname = vim.fn.fnamemodify(buf_name, ":p:t")
      else
        fname = vim.fn.fnamemodify(buf_name, ":~:.")
      end

      local max_len = 20
      if #fname > max_len then
        fname = "…" .. fname:sub(#fname - max_len, #fname)
      end

      s = s .. " " .. fname .. " "
      s = s .. "%X"

      s = s .. "%" .. buf .. "@v:lua._tabline_close_buffer@✕%X "
      -- s = s .. "%" .. buf .. "@v:lua._new_window@"
      -- s = s .. " + "
    end
  end

  s = s .. "%#TabLineFill#%T"

  s = s .. "%="
  if total_tabs > 1 then
    for _, tab in ipairs(tabpages) do
      local tab_num = vim.api.nvim_tabpage_get_number(tab)
      local is_current = (tab == current_tab)
      s = s .. (is_current and "%#TabLineSel#" or "%#TabLine#")
      s = s .. "%" .. tab .. "@v:lua._tabline_goto_tab@ " .. tab_num .. " "
    end
  end

  s = s .. "%#TabLineSel#"
  s = s .. "%@v:lua._new_tab@"
  s = s .. " + "

  return s
end

_G._tabline_goto_buffer = function(buf)
  if type(buf) == "string" then
    buf = tonumber(buf)
  end
  if buf and vim.api.nvim_buf_is_valid(buf) then
    vim.api.nvim_set_current_buf(buf)
  end
end

_G._tabline_close_buffer = function(buf)
  if type(buf) == "string" then
    buf = tonumber(buf)
  end
  if buf and vim.api.nvim_buf_is_valid(buf) then
    vim.api.nvim_buf_delete(buf, { force = false })
  end
end

_G._tabline_goto_tab = function(tab)
  if type(tab) == "string" then
    tab = tonumber(tab)
  end
  if tab and vim.api.nvim_tabpage_is_valid(tab) then
    vim.api.nvim_set_current_tabpage(tab)
  end
end

_G._new_window = function(tab)
  if type(tab) == "string" then
    tab = tonumber(tab)
  end
  if tab and vim.api.nvim_tabpage_is_valid(tab) then
    vim.cmd("enew")
  end
end

_G._new_tab = function(tab)
  if type(tab) == "string" then
    tab = tonumber(tab)
  end
  if tab and vim.api.nvim_tabpage_is_valid(tab) then
    vim.cmd("tabnew")
  end
end

return {
  tabline = tabline
}
