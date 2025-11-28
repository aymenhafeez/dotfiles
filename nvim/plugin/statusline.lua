_G.statusline = {}

local function hl(group, str)
  return string.format("%%#%s#%s%%*", group or "", str or "")
end

local modes = {
  ["n"] = "Normal",
  ["no"] = "N·op",
  ["v"] = "Visual",
  ["V"] = "V·line",
  [""] = "V·block",
  ["s"] = "Select",
  ["S"] = "S·line",
  [""] = "S·block",
  ["i"] = "Insert",
  ["ic"] = "I·comp",
  ["ix"] = "I·comp",
  ["R"] = "Replace",
  ["Rv"] = "V·replace",
  ["c"] = "Command",
  ["cv"] = "Vim·ex",
  ["ce"] = "Ex",
  ["r"] = "Prompt",
  ["rm"] = "More",
  ["r?"] = "Confirm",
  ["!"] = "Shell",
  ["t"] = "Terminal",
}

function statusline.mode()
  local mode = modes[vim.fn.mode()] or " "
  if mode == "Normal" then
    return hl("StatusLineHeaderNorm", " " .. mode .. " ")
  elseif mode == "Command" then
    return hl("StatusLineHeaderCmd", " " .. mode .. " ")
  elseif mode == "Terminal" then
    return hl("StatusLineHeaderTerm", " " .. mode .. " ")
  else
    return hl("StatusLineHeader", " " .. mode .. " ")
  end
end

function statusline.mode_nc()
  local mode = modes[vim.fn.mode()] or " "
  return hl("StatusLineNc", " " .. mode .. " ")
end

function statusline.git_branch()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns and gitsigns.head and gitsigns.head ~= "" then
    return " " .. gitsigns.head
  end
  return ""
end

function statusline.git_diff()
  local gitsigns = vim.b.gitsigns_status_dict
  if not gitsigns then
    return ""
  end

  local added = gitsigns.added or 0
  local changed = gitsigns.changed or 0
  local removed = gitsigns.removed or 0

  local signs = {}
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

function statusline.word_count()
  local wc = vim.fn.wordcount()
  if wc.words == 0 then
    return ""
  end
  if wc.visual_words and wc.visual_words > 0 then
    return "Word count: " .. wc.visual_words .. "/" .. wc.words
  end
  return "Word count: " .. wc.words
end

local writing_ft = { tex = true, markdown = true, text = true }

function statusline.info()
  local info = {}
  local filetype = vim.bo.filetype:gsub("^%l", string.upper)
  if filetype ~= "" then
    table.insert(info, filetype)
  end

  local buf = vim.api.nvim_get_current_buf()
  local readonly = vim.api.nvim_get_option_value("readonly", { buf = buf })
  if readonly then
    table.insert(info, "%r")
  end

  if writing_ft[vim.bo.filetype] then
    local wc = statusline.word_count()
    if wc ~= "" then
      table.insert(info, wc)
    end
  end

  local branch = statusline.git_branch()
  if branch ~= "" then
    table.insert(info, branch)
  end

  local diff = statusline.git_diff()
  if diff ~= "" then
    table.insert(info, diff)
  end

  return #info > 0 and "(" .. table.concat(info, ", ") .. ")" or ""
end

function statusline.diag()
  return vim.diagnostic.status(0) .. "  "
end

function statusline.lsp_status()
  local clients = vim.lsp.get_clients { bufnr = 0 }
  if #clients == 0 then
    return ""
  end

  local client_names = {}
  for _, client in ipairs(clients) do
    table.insert(client_names, client.name)
  end

  local attached_client = " LSP[" .. table.concat(client_names, ",") .. "] "

  return attached_client
end

local function get_buffer_icon(buf, filetype)
  local present, devicons = pcall(require, "nvim-web-devicons")
  if not present then
    return ""
  end

  local icon = devicons.get_icon(buf, filetype, { default = true }) or ""
  return icon ~= "" and icon .. " " or ""
end

function statusline.centered_buffer()
  local buf = vim.api.nvim_buf_get_name(0)
  local bufname = buf ~= "" and vim.fn.fnamemodify(buf, ":~:.") or "[No Name]"
  local icon = buf ~= "" and get_buffer_icon(vim.fn.fnamemodify(buf, ":e"), vim.bo.filetype) or ""
  local modified = vim.bo.modified and "[+]" or ""
  local buffer_text = icon .. bufname .. modified

  local mode = modes[vim.fn.mode()] or "  "
  local info = statusline.info()
  local left_len = vim.fn.strdisplaywidth(" " .. mode .. " " .. info)

  local win_width = vim.api.nvim_win_get_width(0)
  local buffer_len = vim.fn.strdisplaywidth(buffer_text)
  local padding = math.max(1, math.floor((win_width - buffer_len) / 2) - left_len)

  return string.rep(" ", padding) .. buffer_text
end

-- useful for cmdheight=0, shows in ruler with cmdheight=1
function statusline.search_count()
  if vim.v.hlsearch == 0 then
    return ""
  end

  local sc = vim.fn.searchcount()
  local total = sc.total
  local current = sc.current
  if total == 0 then
    return ""
  else
    return current .. "/" .. total
  end
end

local components = {
  align = "%=",
  diag = "%{%v:lua.statusline.diag()%}",
  info = "%{%v:lua.statusline.info()%}",
  mode = "%{%v:lua.statusline.mode()%}",
  mode_nc = "%{%v:lua.statusline.mode_nc()%}",
  pos = "%#StatusLinePos#%{%&ru?'  %l:%c  %P ':''%}",
  pos_nc = "%{%&ru?'  %l:%c  %P ':''%}",
  truncate = "%<",
  centered_buffer = "%{%v:lua.statusline.centered_buffer()%}",
  lsp_status = "%{%v:lua.statusline.lsp_status()%}",
  search_count = "%{%v:lua.statusline.search_count()%}",
}

local status = table.concat {
  components.mode,
  " ",
  components.info,
  components.truncate,
  components.centered_buffer,
  components.align,
  components.diag,
  components.lsp_status,
  " ",
  components.pos,
}

local status_nc = table.concat {
  components.mode_nc,
  " ",
  components.info,
  components.centered_buffer,
  components.align,
  components.truncate,
  components.diag,
  components.lsp_status,
  " ",
  components.pos_nc,
}

function statusline.get()
  return vim.g.statusline_winid == vim.api.nvim_get_current_win() and status or status_nc
end

vim.go.statusline = "%!v:lua.statusline.get()"
