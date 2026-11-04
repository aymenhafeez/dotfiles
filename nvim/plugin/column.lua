_G.statuscolumn = function()
  local winid = vim.g.statusline_winid or 0
  local wo = vim.wo[winid]
  local show_numbers = wo.number or wo.relativenumber

  if vim.v.virtnum ~= 0 then
    return ""
  end

  local line_number = vim.v.lnum
  if wo.relativenumber and vim.v.relnum > 0 then
    line_number = vim.v.relnum
  end

  if not show_numbers then
    return " "
  end

  local width = math.max(wo.numberwidth or 1, 1)
  return string.format("%" .. width .. "d ", line_number)
end

vim.schedule(function()
  vim.opt.statuscolumn = "%{%v:lua.statuscolumn()%}%C%s"
end)

local ns = vim.api.nvim_create_namespace("colorcolumn")
local column = 100

vim.api.nvim_set_decoration_provider(ns, {
  on_win = function(_, win, bufnr, toprow, botrow)
    if vim.api.nvim_get_current_win() ~= win then
      return false
    end

    if vim.bo[bufnr].buftype ~= "" then
      return false
    end

    if not vim.bo[bufnr].modifiable then
      return false
    end

    local target0 = column - 1
    if vim.opt.filetype:get() == "tex" then
      target0 = 86
    end

    for lnum = toprow, botrow do
      -- get the line and compute its display width (tabs, wide chars, etc.)
      local line = vim.api.nvim_buf_get_lines(bufnr, lnum, lnum + 1, false)[1] or ""
      local w = vim.fn.strdisplaywidth(line)

      -- only draw if the text ends before the target column
      if w < target0 then
        vim.api.nvim_buf_set_extmark(bufnr, ns, lnum, 0, {
          ephemeral = true,
          virt_text = { { "│", "WinSeparator" } },
          virt_text_pos = "overlay",
          virt_text_win_col = target0,
          hl_mode = "combine",
          priority = 1
        })
      end
    end

    return false
  end,
})


