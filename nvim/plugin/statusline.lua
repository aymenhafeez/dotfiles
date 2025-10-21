_G.statusline = {}

local function hl(str, group)
  return string.format('%%#%s#%s%%*', group or '', str or '')
end

local signs_cache = setmetatable({}, {
  __index = function(self, key)
    local sign_def = vim.fn.sign_getdefined(key)[1]
    self[key] = sign_def and sign_def.text or ''
    return self[key]
  end,
})
local icon_cache = {}

local modes = {
  n = 'NO', no = 'OP', nov = 'OC', noV = 'OL', ['no\x16'] = 'OB', ['\x16'] = 'VB',
  niI = 'IN', niR = 'RE', niV = 'RV', nt = 'NT', ntT = 'TM',
  v = 'VI', vs = 'VI', V = 'VL', Vs = 'VL', ['\x16s'] = 'VB',
  s = 'SE', S = 'SL', ['\x13'] = 'SB',
  i = 'IN', ic = 'IC', ix = 'IX',
  R = 'RE', Rc = 'RC', Rx = 'RX', Rv = 'RV', Rvc = 'RC', Rvx = 'RX',
  c = 'CO', cv = 'CV', r = 'PR', rm = 'PM', ['r?'] = 'P?',
  ['!'] = 'SH', t = 'TE',
}

function statusline.mode()
  local mode = modes[vim.fn.mode()] or 'UN'
  -- local group = vim.bo.mod and 'StatusLineHeaderModified' or 'StatusLineHeader'
  return hl(' ' .. mode .. '')
end

function statusline.git_branch()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns and gitsigns.head and gitsigns.head ~= '' then
    return '#' .. gitsigns.head
  end
  local result = vim.fn.system('git rev-parse --abbrev-ref HEAD 2>/dev/null')
  if vim.v.shell_error == 0 then
    local branch = result:gsub('\n', '')
    return branch ~= 'HEAD' and '#' .. branch or ''
  end
  return ''
end

function statusline.git_diff()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    local added, changed, removed = gitsigns.added or 0, gitsigns.changed or 0, gitsigns.removed or 0
    if added + changed + removed > 0 then
      return string.format('+%s~%s-%s', added, changed, removed)
    end
  end
  return ''
end

function statusline.ft()
  local ft = vim.bo.ft
  return ft ~= '' and ft:gsub('^%l', string.upper) or ''
end

function statusline.word_count()
  local wc = vim.fn.wordcount()
  local words, vis_words = wc.words, wc.visual_words
  if words == 0 then return '' end
  local prefix = vis_words and vis_words .. '/' or ''
  local suffix = words == 1 and ' word' or ' words'
  return prefix .. words .. suffix
end

local ft_text = { [''] = true, tex = true, markdown = true, text = true }

function statusline.info()
  if vim.bo.bt ~= '' then return '' end
  local parts = {}
  local ft = statusline.ft()
  if ft ~= '' then table.insert(parts, ft) end
  if ft_text[vim.bo.ft] and not vim.b.large_file then
    local wc = statusline.word_count()
    if wc ~= '' then table.insert(parts, wc) end
  end
  local branch = statusline.git_branch()
  if branch ~= '' then table.insert(parts, branch) end
  local diff = statusline.git_diff()
  if diff ~= '' then table.insert(parts, diff) end
  return #parts > 0 and '(' .. table.concat(parts, ', ') .. ') ' or ''
end

local diag_cache = {}

vim.api.nvim_create_autocmd('DiagnosticChanged', {
  callback = function(args)
    local counts = { 0, 0, 0, 0 }
    for _, diag in ipairs(args.data.diagnostics) do
      counts[diag.severity] = counts[diag.severity] + 1
    end
    diag_cache[args.buf] = counts
  end,
})

function statusline.diag()
  local parts = {}
  local counts = diag_cache[vim.api.nvim_get_current_buf()] or {}
  local severities = { 'Error', 'Warn', 'Info', 'Hint' }
  for i, severity in ipairs(severities) do
    local count = counts[i] or 0
    if count > 0 then
      local icon = signs_cache['DiagnosticSign' .. severity]
      table.insert(parts, icon .. count)
    end
  end
  return #parts > 0 and table.concat(parts, ' ') .. ' ' or ''
end

function statusline.ft_icon()
  local ft = vim.bo.filetype
  if icon_cache[ft] ~= nil then return icon_cache[ft] end
  local ok, devicons = pcall(require, "nvim-web-devicons")
  if not ok then icon_cache[ft] = ''; return '' end
  local name = vim.api.nvim_buf_get_name(0)
  local icon = devicons.get_icon(name, ft, { default = true })
  icon_cache[ft] = icon or ''
  return icon_cache[ft]
end

local lsp_progress = { msg = "", active = false }

vim.lsp.handlers['$/progress'] = function(_, msg)
  lsp_progress.active = msg.value.kind ~= "end"
  lsp_progress.msg = lsp_progress.active and (msg.value.title or "") or ""
  vim.cmd.redrawstatus()
end

function statusline.lsp_status()
  local clients = vim.lsp.get_clients({bufnr = 0})
  if #clients == 0 then return "" end
  local names = {}
  for _, client in ipairs(clients) do
    table.insert(names, client.name)
  end
  local status = "LSP[" .. table.concat(names, ",") .. "]"
  if lsp_progress.active then
    status = status .. "⚡" .. lsp_progress.msg
  end
  return status
end

function statusline.buffers()
  local parts = {}
  local current = vim.api.nvim_get_current_buf()
  local ok, devicons = pcall(require, "nvim-web-devicons")
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buflisted and vim.api.nvim_buf_is_loaded(buf) then
      local name = vim.api.nvim_buf_get_name(buf)
      local display_name = name == '' and '[No Name]' or vim.fn.fnamemodify(name, ':t')
      local icon = ''
      if ok then
        local ft = vim.bo[buf].filetype
        icon = devicons.get_icon(name, ft, { default = true }) or ''
        if icon ~= '' then icon = icon .. ' ' end
      end
      local modified = ''
      if vim.bo[buf].modified then
        if buf == current then
          modified = hl(' ●', 'ModifiedIcon')
        else
          modified = hl(' ●', 'StatusLine')
        end
      end
      if buf == current then
        table.insert(parts, hl(' ' .. icon .. display_name .. modified .. ' ', 'StatusLineCurrentBuffer'))
      else
        table.insert(parts, ' ' .. icon .. display_name .. modified .. ' ')
      end
    end
  end
  return #parts > 0 and table.concat(parts, '|') or ''
end

local components = {
  align = '%=',
  diag = '%{%v:lua.statusline.diag()%}',
  info = '%{%v:lua.statusline.info()%}',
  mode = ' %{%v:lua.statusline.mode()%}',
  pos = '%{%&ru?" %l:%c  %P  ":""%}',
  -- pos = '%{%&ru?" %l:%c   %#StatusLinePosition#  %P  ":""%}',
  truncate = '%<',
  buffers = '%{%v:lua.statusline.buffers()%}',
  lsp_status = '%{%v:lua.statusline.lsp_status()%}',
}

local stl = table.concat({
  components.mode, ' ', components.buffers, '󰇙 ', components.info,
  components.align, components.truncate, components.diag, '  ', components.lsp_status, '  ',
  components.pos,
})

local stl_nc = table.concat({
  components.align, components.truncate, components.pos,
})

function statusline.get()
  return vim.g.statusline_winid == vim.api.nvim_get_current_win() and stl or stl_nc
end

local function setup_highlights()
  icon_cache = {}
  local statusline_bg = vim.api.nvim_get_hl(0, { name = 'StatusLine' }).bg
  local function sethl(name, opts)
    if opts.link then
      local linked = vim.api.nvim_get_hl(0, { name = opts.link })
      opts.fg = opts.fg or linked.fg
      opts.bg = opts.bg or statusline_bg
      opts.link = nil
    end
    opts.bg = opts.bg or statusline_bg
    vim.api.nvim_set_hl(0, name, opts)
  end
  if vim.env.COLORTERM or vim.fn.has('gui_running') == 1 then
    local modified_icon = vim.api.nvim_get_hl(0, { name = 'Orange' }).fg
    local header = vim.api.nvim_get_hl(0, { name = 'Popblue' }).fg
    local header_modified = vim.api.nvim_get_hl(0, { name = 'Popyellow' }).fg
    local current_buf_normal = vim.api.nvim_get_hl(0, { name = 'Popblue'}).fg
    local statusline = vim.api.nvim_get_hl(0, { name = 'StatusLine'}).bg
    local position = vim.api.nvim_get_hl(0, { name = "Popyellow" }).fg
    sethl('ModifiedIcon', { fg = modified_icon })

    sethl('StatusLineHeader', { bg = header })
    sethl('StatusLineHeaderModified', { bg = header_modified })
    sethl('StatusLineCurrentBuffer', { bg = statusline, fg = current_buf_normal })
    sethl('StatusLinePosition', { fg = statusline, bg = position })
  end
end

vim.api.nvim_create_autocmd({ 'UIEnter', 'ColorScheme' }, {
  callback = setup_highlights
})

vim.go.statusline = '%!v:lua.statusline.get()'
