local api = vim.api
local fn = vim.fn
local bo = vim.bo

local modes = {
  ["n"] = "",
  ["no"] = "",
  ["v"] = "",
  ["V"] = "",
  [""] = "",
  ["s"] = "",
  ["S"] = "",
  [""] = "",
  ["i"] = "",
  ["ic"] = "",
  ["R"] = "",
  ["Rv"] = "",
  ["c"] = "",
  ["cv"] = "",
  ["ce"] = "",
  ["r"] = "",
  ["rm"] = "",
  ["r?"] = "",
  ["!"] = "",
  ["t"] = "",
}

local function mode()
  local current_mode = api.nvim_get_mode().mode
  return string.format(" %s ", modes[current_mode])
end

local function update_mode_colors()
  local current_mode = api.nvim_get_mode().mode
  local mode_color = "%#StatusLineAccent#"
  if current_mode == "n" then
    mode_color = "%#StatuslineAccent#"
  elseif current_mode == "i" or current_mode == "ic" then
    mode_color = "%#StatuslineInsert#"
  elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
    mode_color = "%#StatuslineVisual#"
  elseif current_mode == "R" then
    mode_color = "%#StatuslineReplace#"
  elseif current_mode == "c" then
    mode_color = "%#StatuslineCmdLine#"
  elseif current_mode == "t" then
    mode_color = "%#StatuslineTerminal#"
  end
  return mode_color
end

local function filename()
  local fname
  local modified = " "
  local readonly = " "

  if bo.modified then
    fname = fn.expand "%:t" .. modified
  elseif bo.readonly then
    fname = fn.expand "%:t" .. readonly
  else
    fname = fn.expand "%:t"
  end

  if fname == "" then
    return ""
  end

  local file_name, file_ext = fn.expand("%:t"), vim.fn.expand("%:e")
  local icon = require"nvim-web-devicons".get_icon(file_name, file_ext, { default = true })
  -- local icon_str, icon_color = require("nvim-web-devicons").get_icon_color(fn.expand("%:t"), nil, { default = true })
  local filetype = bo.filetype

  -- local icon = { str = icon_str }
  -- icon.hl = { fg = icon_color }

  if filetype == "" then return "" end
  return string.format("  %s %s", icon, fname)
end

local function lsp_diagnostics()
  local count = {}
  local levels = {
    errors = "Error",
    warnings = "Warn",
    info = "Info",
    hints = "Hint",
  }

  for k, level in pairs(levels) do
    count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end

  local errors = ""
  local warnings = ""
  local hints = ""
  local info = ""

  if count["errors"] ~= 0 then
    errors = "%#StatusLineLspError# " .. count["errors"] .. " "
  end
  if count["warnings"] ~= 0 then
    warnings = "%#StatusLineLspWarning# " .. count["warnings"] .. " "
  end
  if count["hints"] ~= 0 then
    hints = "%#StatusLineLspHint# " .. count["hints"] .. " "
  end
  if count["info"] ~= 0 then
    info = "%#StatusLineLspInfo# " .. count["info"] .. " "
  end

  return errors .. warnings .. hints .. info .. "%#Normal#"
end

local function lsp_client()
  local msg = " LS Inactive"
  local buf_ft = api.nvim_buf_get_option(0, "filetype")
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return msg
  end
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and fn.index(filetypes, buf_ft) ~= -1 then
      return " " .. client.name
    end
  end
  return msg
end

local function lineinfo()
  if bo.filetype == "alpha" then
    return ""
  end
  return "  %l:%c  "
end

local function progress_bar()
  local current_line = fn.line "."
  local total_lines = fn.line "$"
  local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

local function treesitter_tree()
  local bufnr = api.nvim_get_current_buf()
  if bo.filetype == "TelescopePrompt" then
    return ""
  elseif bo.filetype == "packer" then
    return ""
  elseif bo.filetype == "" then
    return ""
  elseif next(vim.treesitter.highlighter.active[bufnr]) then
    return "%#StatusLineTreesitterTree#      "
  end
  return ""
end

local function git_signs()
  local git_info = vim.b.gitsigns_status_dict
  if not git_info or git_info.head == "" then
    return ""
  end
  local added = git_info.added and ("%#StatusLineGitSignsAdd#  " .. git_info.added .. " ") or ""
  local changed = git_info.changed and ("%#StatusLineGitSignsChange# " .. git_info.changed .. " ") or ""
  local removed = git_info.removed and ("%#StatusLineGitSignsDelete# " .. git_info.removed .. " ") or ""
  if git_info.added == 0 then
    added = ""
  end
  if git_info.changed == 0 then
    changed = ""
  end
  if git_info.removed == 0 then
    removed = ""
  end
  return table.concat {
    "%#StatusLineGitSignsAdd#  ",
    git_info.head,
    " ",
    added,
    changed,
    removed,
  }
end

Statusline = {}

function Statusline.active()
  return table.concat {
    "%#Statusline#",
    update_mode_colors(),
    mode(),
    "%#Statusline#",
    filename(),
    treesitter_tree(),
    git_signs(),
    "  ",
    lsp_diagnostics(),
    "%#Statusline#",
    "%=%#StatusLine#",
    lsp_client(),
    " ",
    "%#StatusLineLineInfo#",
    lineinfo(),
    "%#StatusLineProgressBar#",
    progress_bar(),
  }
end

function Statusline.inactive()
  return " %F"
end

function Statusline.short()
  return "%#StatusLineNC#   NvimTree"
end

api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
  augroup END
]], false)
