_G.statusline = {}

local modes = {
  n = "NO",
  no = "OP",
  nov = "OC",
  noV = "OL",
  ["no\x16"] = "OB",
  ["\x16"] = "VB",
  niI = "IN",
  niR = "RE",
  niV = "RV",
  nt = "NT",
  ntT = "TM",
  v = "VI",
  vs = "VI",
  V = "VL",
  Vs = "VL",
  ["\x16s"] = "VB",
  s = "SE",
  S = "SL",
  ["\x13"] = "SB",
  i = "IN",
  ic = "IC",
  ix = "IX",
  R = "RE",
  Rc = "RC",
  Rx = "RX",
  Rv = "RV",
  Rvc = "RC",
  Rvx = "RX",
  c = "CO",
  cv = "CV",
  r = "PR",
  rm = "PM",
  ["r?"] = "P?",
  ["!"] = "SH",
  t = "TE",
}

function statusline.mode()
  local mode = modes[vim.fn.mode()] or "  "
  return " " .. mode
end

function statusline.git_branch()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns and gitsigns.head and gitsigns.head ~= "" then
    return "#" .. gitsigns.head
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
  return vim.diagnostic.status(0)
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

function statusline.buffer()
  local buf = vim.api.nvim_buf_get_name(0)
  local icon = buf ~= "" and get_buffer_icon(buf, vim.bo.filetype) or ""

  return icon .. "%f" .. "%m"
end

function statusline.open_buffers()
  local buffer_list = {}
  local current_buffer = vim.api.nvim_get_current_buf()

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current_buffer and vim.api.nvim_get_option_value("buflisted", { buf = buf }) then
      local buf_path = vim.api.nvim_buf_get_name(buf)
      local buf_name = vim.fn.fnamemodify(buf_path, ":t")

      if buf_name ~= "" then
        local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
        local icon = get_buffer_icon(buf_path, ft)
        table.insert(buffer_list, icon .. buf_name)
      end
    end
  end

  return #buffer_list > 0 and table.concat(buffer_list, "  ") or ""
end

-- optional, shows in ruler with cmdheight=1
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
  mode = " %{%v:lua.statusline.mode()%}",
  open_bufs = "%#NonText#%{%v:lua.statusline.open_buffers()%}%*",
  pos = "%{%&ru?'  %l:%c  %P ':''%} ",
  -- pos = "%{%&ru?'  %l:%c  %P ':''%}",
  truncate = "%<",
  buffer = "%{%v:lua.statusline.buffer()%}",
  lsp_status = "%{%v:lua.statusline.lsp_status()%}",
  search_count = "%{%v:lua.statusline.search_count()%}",
}

local status = table.concat {
  -- components.mode,
  "  ",
  components.buffer,
  " ",
  components.info,
  components.align,
  -- components.open_bufs,
  components.align,
  components.truncate,
  components.diag,
  "   ",
  components.lsp_status,
  " ",
  components.pos,
}

local status_nc = table.concat {
  components.align,
  components.truncate,
  components.pos,
}

function statusline.get()
  return vim.g.statusline_winid == vim.api.nvim_get_current_win() and status or status_nc
end

vim.go.statusline = "%!v:lua.statusline.get()"
