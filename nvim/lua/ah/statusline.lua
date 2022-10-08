vim.cmd("hi StatusLineAccent guifg=#1a1b26 guibg=#7aa2f7")
vim.cmd("hi StatusLineInsertAccent guifg=#7aa2f7 guibg=bg")
vim.cmd("hi StatusLineVisualAccent guifg=bg guibg=#9d7cd8")
vim.cmd("hi StatusLineReplaceAccent guifg=bg guibg=#db4b4b")
vim.cmd("hi StatusLineCmdLineAccent guifg=bg guibg=#e0af68")
vim.cmd("hi StatuslineTerminalAccent guifg=bg guibg=#ff9e64")
vim.cmd("hi StatusLineExtra guifg=#565f89")
vim.cmd("hi StatusLineNC guibg=NONE")
vim.cmd("hi LspError guifg=#db4b4b")
vim.cmd("hi LspWarning guifg=#ffc777")
vim.cmd("hi LspHint guifg=#1abc9c")
vim.cmd("hi LspInfo guifg=#0db9d7")
vim.cmd("hi ProgressBar guifg=#ffc777")

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
  local current_mode = vim.api.nvim_get_mode().mode
  return string.format(" %s ", modes[current_mode])
end

local function update_mode_colors()
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_color = "%#StatusLineAccent#"
  if current_mode == "n" then
      mode_color = "%#StatuslineAccent#"
  elseif current_mode == "i" or current_mode == "ic" then
      mode_color = "%#StatuslineInsertAccent#"
  elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
      mode_color = "%#StatuslineVisualAccent#"
  elseif current_mode == "R" then
      mode_color = "%#StatuslineReplaceAccent#"
  elseif current_mode == "c" then
      mode_color = "%#StatuslineCmdLineAccent#"
  elseif current_mode == "t" then
      mode_color = "%#StatuslineTerminalAccent#"
  end
  return mode_color
end

local function filename()
  local fname = vim.fn.expand "%:t"
  if fname == "" then
      return ""
  end

  local file_name, file_ext = vim.fn.expand("%:t"), vim.fn.expand("%:e")
  local icon = require'nvim-web-devicons'.get_icon(file_name, file_ext, { default = true })
  local filetype = vim.bo.filetype

  if filetype == '' then return '' end
  return string.format(' %s %s  ', icon, fname)
end

local function lsp()
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
    errors = "%#LspError# " .. count["errors"] .. " "
  end
  if count["warnings"] ~= 0 then
    warnings = "%#LspWarning# " .. count["warnings"] .. " "
  end
  if count["hints"] ~= 0 then
    hints = "%#LspHint# " .. count["hints"] .. " "
  end
  if count["info"] ~= 0 then
    info = "%#LspInfo# " .. count["info"] .. " "
  end

  return errors .. warnings .. hints .. info .. "%#Normal#"
end

local function lineinfo()
  if vim.bo.filetype == "alpha" then
    return ""
  end
  return "  %l:%c  %P "
end

local function progress_bar()
  local current_line = vim.fn.line "."
  local total_lines = vim.fn.line "$"
  local chars = { "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

local vcs = function()
  local git_info = vim.b.gitsigns_status_dict
  if not git_info or git_info.head == "" then
    return ""
  end
  local added = git_info.added and (" %#GitSignsAdd# " .. git_info.added .. " ") or ""
  local changed = git_info.changed and ("%#GitSignsChange# " .. git_info.changed .. " ") or ""
  local removed = git_info.removed and ("%#GitSignsDelete# " .. git_info.removed .. " ") or ""
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
     "  %#GitSignsAdd# ",
     git_info.head,
     " ",
     added,
     changed,
     removed,
     "%#Normal# ",
  }
end

Statusline = {}

Statusline.active = function()
  return table.concat {
    "%#Statusline#",
    update_mode_colors(),
    mode(),
    "%#Normal#",
    vcs(),
    " ",
    lsp(),
    "%#Statusline#",
    "%=%#StatusLine#",
    filename(),
    "%=%#StatusLine#",
    lineinfo(),
    "%#ProgressBar#",
    progress_bar(),
  }
end

function Statusline.inactive()
  return " %F"
end

function Statusline.short()
  return "%#StatusLineNC#   NvimTree"
end

vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
  augroup END
]], false)
