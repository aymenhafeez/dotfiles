_G._new_tab = function(tab)
  if type(tab) == "string" then
    tab = tonumber(tab)
  end
  if tab and vim.api.nvim_tabpage_is_valid(tab) then
    vim.cmd("tabnew")
  end
end

local modes = {
  ["n"] = "<N>",
  ["no"] = "<NOP>",
  ["v"] = "<V>",
  ["V"] = "<VL>",
  [""] = "<VB>",
  ["s"] = "<S>",
  ["S"] = "<SL>",
  [""] = "<SB>",
  ["i"] = "<I>",
  ["ic"] = "<IC>",
  ["ix"] = "<IC>",
  ["R"] = "<R>",
  ["Rv"] = "<VR>",
  ["c"] = "<C>",
  ["cv"] = "<VE>",
  ["ce"] = "<E>",
  ["r"] = "<H<CR>>",
  ["rm"] = "<M>",
  ["r?"] = "<C>",
  ["!"] = "<S>",
  ["t"] = "<T>",
  ["ntT"] = "<nT>",
}

local function show_mode(hl)
  local mode = modes[vim.fn.mode()] or " "
  local mode_hl
  if vim.fn.mode() == "n" then
    mode_hl = "%6*"
  elseif vim.fn.mode() == "t" then
    mode_hl = "%9*"
  else
    mode_hl = "%5*"
  end

  -- if vim.opt.showmode:get() == false then
  -- return string.format("%s%s", mode_hl, "▉")
  return string.format("%s%s", mode_hl, mode)
  -- else
  --   return " "
  -- end
end

local function get_icon(hl)
  local buf = vim.api.nvim_buf_get_name(0)
  local extension = vim.fn.fnamemodify(buf, ":e")
  local icon, hl = require("mini.icons").get("extension", extension)

  if hl then
    return " %#" .. hl .. "#" .. icon .. "%* "
  else
    return " " .. icon .. " "
  end
end

local function filename(buf, hl)
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

  local bufdir
  local max_len = 30
  if #fname > max_len then
    bufdir = "…" .. fname:sub(#fname - max_len, #fname)
  else
    bufdir = fname
  end

  local parent = bufdir:match "^(.*/)"
  local tail = vim.fn.fnamemodify(name, ":t")

  local parent_hl, tail_hl
  if vim.bo.modified then
    parent_hl = "%2*"
    tail_hl = "%3*"
  elseif hl then
    if vim.fn.mode() == "n" then
      parent_hl = "%2*"
      tail_hl = "%3*"
    else
      parent_hl = "%2*"
      tail_hl = "%3*"
    end
  else
    parent_hl = ""
    tail_hl = ""
  end

  return string.format("%s%s%s%s %%*", parent_hl, parent or "", tail_hl, tail)
end

-- local function filename(buf)
--   local name = vim.api.nvim_buf_get_name(buf)
--   if name == "" then
--     name = "[No name]"
--   else
--     name = name:gsub("%%", "%%%%")
--   end
--
--   local fname
--   if vim.bo.filetype == "help" then
--     fname = vim.fn.fnamemodify(name, ":p:t")
--   else
--     fname = vim.fn.fnamemodify(name, ":~:.")
--   end
--
--   local bufdir
--   local max_len = 30
--   if #fname > max_len then
--     bufdir = "…" .. fname:sub(#fname - max_len, #fname)
--   else
--     bufdir = fname
--   end
--
--   local parent = bufdir:match "^(.*/)"
--   local tail = vim.fn.fnamemodify(name, ":t")
--
--   return string.format("%s%s", parent or "", tail)
-- end

local function git_info()
  local gitsigns = vim.b.gitsigns_status_dict
  if not gitsigns then
    return ""
  end

  local added = gitsigns.added or 0
  local changed = gitsigns.changed or 0
  local removed = gitsigns.removed or 0

  local signs = {}

  if gitsigns and gitsigns.head and gitsigns.head ~= "" then
    local branch_info = " Git:" .. gitsigns.head
    table.insert(signs, branch_info)
  end

  if added > 0 then
    table.insert(signs, "+" .. added)
  end
  if changed > 0 then
    table.insert(signs, "~" .. changed)
  end
  if removed > 0 then
    table.insert(signs, "-" .. removed)
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
  local hl = tonumber(vim.g.actual_curwin) == win

  local components = {}

  -- if hl then
  --   table.insert(components, show_mode())
  --   table.insert(components, "%*")
  -- else
  --   table.insert(components, "       ")
  -- end

  -- table.insert(components, get_icon(hl))
  table.insert(components, filename(buf, hl))
  table.insert(components, "%*")

  table.insert(components, "%h%w%m%r  ")
  -- table.insert(components, "%h%w%r  ")

  if vim.opt.showmode:get() == false then
    if hl then
      table.insert(components, "  " .. show_mode() .. "    ")
      table.insert(components, "%*")
    else
      table.insert(components, "         ")
    end
  end

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

  table.insert(components, "%S  ")

  if hl then
    table.insert(components, "%4*")
  end
  table.insert(components, lsp_status())
  table.insert(components, "%*")

  table.insert(components, "  ")

  table.insert(components, diagnostics())

  table.insert(components, "%-14.(%l,%c%V%) %P")
  table.insert(components, "%*")

  return table.concat(components)
end

return {
  statusline = statusline,
  tabline = tabline
}
