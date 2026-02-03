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


local function show_mode(hl)
  local mode = modes[vim.fn.mode()] or " "
  local mode_hl
  if hl then
    if vim.fn.mode() == "n" then
      mode_hl = "%6*"
    else
      mode_hl = "%7*"
    end
  else
    mode_hl = ""
  end

  if vim.opt.showmode:get() == false then
    return string.format("%s %s ", mode_hl, mode)
  else
    return ""
  end
end

local function get_icon(buf)
  local present, MiniIcons = pcall(require, "mini.icons")
  if not present then
    return ""
  end

  if buf == "" then
    return " "
  end

  local icon, hl, is_default = MiniIcons.get("extension", buf)
  return icon ~= "" and " " .. icon or ""
end

local function diagnostics()
  local diags = vim.diagnostic.get(0, { severity = { min = vim.diagnostic.severity.WARN } })

  local num_errors = 0
  for _, v in ipairs(diags) do
    if v.severity == vim.diagnostic.severity.ERROR then
      num_errors = num_errors + 1
    end
  end

  local num_warnings = #diags - num_errors

  if num_errors == 0 and num_warnings == 0 then
    return ""
  elseif num_errors > 0 and num_warnings == 0 then
    return string.format(" : %d ", num_errors)
  elseif num_errors == 0 and num_warnings > 0 then
    return string.format(" : %d ", num_warnings)
  else
    return string.format(" : %d  : %d ", num_errors, num_warnings)
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
  local parts = vim.split(fname, "/")
  if #parts > 4 then
    bufdir = vim.fn.pathshorten(fname, 1)
  else
    bufdir = fname
  end

  local dir = bufdir:match "^(.*/)"
  local file = vim.fn.fnamemodify(name, ":t")

  local dir_hl, file_hl
  if vim.bo.modified then
    dir_hl = "%1*"
    file_hl = "%1*"
  elseif hl then
    dir_hl = "%2*"
    file_hl = "%3*"
  else
    dir_hl = ""
    file_hl = ""
  end

  return string.format("%s %%<%s%s%s %%*", dir_hl, dir or "", file_hl, file)
end

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
    local branch_info = "#" .. gitsigns.head
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
  local ft = vim.bo.filetype
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

local function statusline()
  local buf = vim.api.nvim_get_current_buf()
  local ft = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":e")
  local win = vim.api.nvim_get_current_win()
  local term = vim.bo[buf].buftype == "terminal"
  local icon = buf ~= "" and get_icon(ft)
  local curwin = tonumber(vim.g.actual_curwin) == win
  local hl = curwin

  local components = {}

  table.insert(components, show_mode(hl))

  table.insert(components, filename(buf, hl))

  if vim.bo.readonly then
    table.insert(components, "%r ")
  else
    table.insert(components, "")
  end

  if vim.wo.previewwindow then
    table.insert(components, "%w ")
  else
    table.insert(components, "")
  end

  table.insert(components, " " .. git_info() .. "  ")

  local writing_ft = { tex = true, markdown = true, text = true }
  if writing_ft[vim.bo.filetype] then
    local wc = word_count()
    if wc ~= "" then
      table.insert(components, wc)
    end
  end

  table.insert(components, "%=")

  table.insert(components, diagnostics())

  -- highlight
  if hl then
    table.insert(components, "%4*")
  else
    table.insert(components, "")
  end

  -- Highlight
  if hl then
    table.insert(components, "%8*")
    table.insert(components, icon)
  else
    table.insert(components, "")
    table.insert(components, icon)
  end

  table.insert(components, lsp_status())

  -- Highlight
  if hl then
    table.insert(components, "%9*")
  else
    table.insert(components, "")
  end

  -- Position info
  local line = vim.fn.getpos(".")[2]
  local col = vim.fn.getpos(".")[3]
  table.insert(components, string.format(" %3d:%3d ", line, col) .. " %P ")

  return table.concat(components)
end

return {
  statusline = statusline,
}
