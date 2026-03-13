_G._new_tab = function(tab)
  if type(tab) == "string" then
    tab = tonumber(tab)
  end
  if tab and vim.api.nvim_tabpage_is_valid(tab) then
    vim.cmd("tabnew")
  end
end

local modes = {
  ["n"] = "NOR",
  ["no"] = "N·OP",
  ["v"] = "VIS",
  ["V"] = "V·L",
  [""] = "V·B",
  ["s"] = "SEL",
  ["S"] = "S·L",
  [""] = "S·B",
  ["i"] = "INS",
  ["ic"] = "I·C",
  ["ix"] = "I·C",
  ["R"] = "REP",
  ["Rv"] = "V·R",
  ["c"] = "CMD",
  ["cv"] = "V·E",
  ["ce"] = "Ex",
  ["r"] = "Hit<CR>",
  ["rm"] = "More",
  ["r?"] = "CON",
  ["!"] = "SH",
  ["t"] = "TER",
  ["ntT"] = "nTER",
}

local function show_mode()
  local mode = modes[vim.fn.mode()] or " "
  local mode_hl
  if vim.fn.mode() == "n" then
    mode_hl = "%6*"
  else
    mode_hl = "%5*"
  end

  if vim.opt.showmode:get() == false then
    return string.format("%s %s   ", mode_hl, mode)
  else
    return " "
  end
end

local function filename(buf)
  local name = vim.api.nvim_buf_get_name(buf)
  if name == "" then
    name = "[No name]"
  else
    name = name:gsub("%%", "%%%%")
  end

  local fname
  if vim.bo.filetype == "help" then
    fname = vim.fn.fnamemodify(name, ":p:t")
  else
    fname = vim.fn.fnamemodify(name, ":~:.")
  end

  local max_len = 35
  if #fname > max_len then
    fname = "…" .. fname:sub(#fname - max_len, #fname)
  end

  return fname .. " "
end

local function git_info()
  local signs = {}

  local head = vim.b.minigit_summary_string
  if head and head ~= "" then
    local branch_info = " " .. head
    table.insert(signs, branch_info)
  end

  local summary = vim.b.minidiff_summary
  if summary then
    local added = summary.add or 0
    local changed = summary.change or 0
    local removed = summary.delete or 0

    if added > 0 then
      table.insert(signs, "+" .. added)
    end
    if changed > 0 then
      table.insert(signs, "~" .. changed)
    end
    if removed > 0 then
      table.insert(signs, "-" .. removed)
    end
  end

  if #signs > 0 then
    return table.concat(signs, " ")
  end
  return ""
end

local function word_count()
  local wc = vim.fn.wordcount()
  if wc.words == 0 then
    return ""
  end

  if wc.visual_words and wc.visual_words > 0 then
    return "(Word count: " .. wc.visual_words .. "/" .. wc.words .. ") "
  end

  return "(Word count: " .. wc.words .. ") "
end

local function lsp_status()
  local ft = vim.bo.filetype:gsub("^%l", string.upper)
  if ft == "" then
    return ""
  else
    local clients = vim.lsp.get_clients { bufnr = 0 }

    local client_names = {}
    for _, client in ipairs(clients) do
      table.insert(client_names, client.name)
    end

    local lsp_client = table.concat(client_names, ",")

    if next(clients) ~= nil then
      return string.format(" %s/%s ", ft, lsp_client)
    else
      return string.format(" %s ", ft)
    end
  end
end

local function diagnostics()
  if next(vim.diagnostic.get(0)) == nil then
    return ""
  else
    return vim.diagnostic.status() .. " "
  end
end

local function tabline()
  local tabpagenr = vim.fn.tabpagenr()
  local tabs = vim.api.nvim_list_tabpages()
  local current_tab = vim.api.nvim_get_current_tabpage()
  local items = {}

  for i, tab in ipairs(tabs) do
    local hi = (i == tabpagenr) and "TabLineSel" or "TabLine"
    local win = vim.api.nvim_tabpage_get_win(tab)
    local buf = vim.api.nvim_win_get_buf(win)
    local bufname = vim.api.nvim_buf_get_name(buf)

    local cwd = vim.fn.pathshorten(vim.fn.fnamemodify(bufname, ":~:."))
    table.insert(items, string.format("%%#%s#%%T %s ", hi, cwd))
  end
  table.insert(items, "%#TabLineFill#%T")

  table.insert(items, "%=")
  if #tabs > 1 then
    for _, tab in ipairs(tabs) do
      local tab_num = vim.api.nvim_tabpage_get_number(tab)
      local is_current = (tab == current_tab)
      table.insert(items, is_current and "%#TabLineSel#" or "%#TabLine#")
      table.insert(items, "%" .. tab .. "@v:lua._tabline_goto_tab@ " .. tab_num .. " ")
    end
  end
  table.insert(items, "%#StatusLine#%@v:lua._new_tab@ + ")

  return table.concat(items)
end

local function statusline()
  local buf = vim.api.nvim_get_current_buf()
  local win = vim.api.nvim_get_current_win()
  local curwin = tonumber(vim.g.actual_curwin) == win

  local components = {}

  table.insert(components, show_mode())

  if curwin then
    table.insert(components, "%#Bold#")
  end

  table.insert(components, filename(buf))
  table.insert(components, "%*")

  table.insert(components, "%h%w%m%r  ")

  table.insert(components, git_info() .. "   ")

  table.insert(components, "%<")

  local writing_ft = { tex = true, markdown = true, text = true }
  if writing_ft[vim.bo.filetype] then
    local wc = word_count()
    if wc ~= "" then
      table.insert(components, wc)
    end
  end

  table.insert(components, "%=")

  if curwin then
    table.insert(components, "%8*")
  end

  table.insert(components, lsp_status())
  table.insert(components, "%*")

  table.insert(components, "  ")

  table.insert(components, diagnostics())

  table.insert(components, "%-14.(%l,%c%V%) %P ")

  return table.concat(components)
end

return {
  statusline = statusline,
  tabline = tabline
}
