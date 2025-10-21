local M = {}

local langs_mt = {}
langs_mt.__index = langs_mt

---@param field string
---@return string[]
function langs_mt:list(field)
  local deduplist = {}
  local result = {}
  -- deduplication
  for _, info in pairs(self) do
    if type(info[field]) == 'string' then
      deduplist[info[field]] = true
    elseif type(info[field]) == 'table' then
      for _, name in pairs(info[field]) do
        deduplist[name] = true
      end
    end
  end
  for name, _ in pairs(deduplist) do
    table.insert(result, name)
  end
  return result
end

---@param field string
---@return table<string, string|string[]>
function langs_mt:map(field)
  local result = {}
  for lang, info in pairs(self) do
    result[lang] = info[field]
  end
  return result
end

M.langs = setmetatable({
  sh = {
    ft = 'sh',
    lsp_server = { 'bashls', 'efm' },
    dap = 'bashdb',
  },
  c = {
    ts = 'c',
    ft = 'c',
    lsp_server = 'clangd',
    dap = 'codelldb',
  },
  cpp = {
    ts = 'cpp',
    ft = 'cpp',
    lsp_server = 'clangd',
    dap = 'codelldb',
  },
  cuda = {
    ts = 'cuda',
    ft = 'cuda',
    lsp_server = 'clangd',
  },
  fish = {
    ts = 'fish',
    ft = 'fish',
    lsp_server = 'efm',
  },
  help = {
    ts = 'vimdoc',
    ft = 'help',
  },
  lua = {
    ts = 'lua',
    ft = 'lua',
    lsp_server = { 'lua_ls', 'efm' },
  },
  rust = {
    ts = 'rust',
    ft = 'rust',
    lsp_server = 'rust_analyzer',
  },
  make = {
    ts = 'make',
    ft = 'make',
  },
  markdown = {
    ts = {
      'markdown_inline',
      'markdown',
    },
    lsp_server = 'marksman',
  },
  python = {
    ts = 'python',
    ft = 'python',
    lsp_server = { 'jedi_language_server', 'efm' },
    dap = 'debugpy',
  },
  vim = {
    ts = 'vim',
    ft = 'vim',
    lsp_server = 'vimls',
  },
  tex = {
    ft = 'tex',
    ts = 'latex',
    lsp_server = 'texlab',
  },
  query = { -- Fix error `no parser for 'query' language` on `:InspectTree`
    ts = 'query',
  },
}, langs_mt)

-- Box drawing characters
M.box = {
  single = {
    tl = '┌',
    tr = '┐',
    bl = '└',
    br = '┘',
    hr = '─',
    vt = '│',
  },
  double = {
    tl = '╔',
    tr = '╗',
    bl = '╚',
    br = '╝',
    hr = '═',
    vt = '║',
  },
  rounded = {
    tl = '╭',
    tr = '╮',
    bl = '╰',
    br = '╯',
    hr = '─',
    vt = '│',
  },
  bold = {
    tl = '┏',
    tr = '┓',
    bl = '┗',
    br = '┛',
    hr = '━',
    vt = '┃',
  },
  vintage = {
    tl = '+',
    tr = '+',
    bl = '+',
    br = '+',
    hr = '-',
    vt = '|',
  },
}

-- stylua: ignore start
M.borders = {
  rounded               = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
  single                = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
  double                = { '═', '║', '═', '║', '╔', '╗', '╝', '╚' },
  double_header         = { '═', '│', '─', '│', '╒', '╕', '┘', '└' },
  double_bottom         = { '─', '│', '═', '│', '┌', '┐', '╛', '╘' },
  double_horizontal     = { '═', '│', '═', '│', '╒', '╕', '╛', '╘' },
  double_left           = { '─', '│', '─', '│', '╓', '┐', '┘', '╙' },
  double_right          = { '─', '│', '─', '│', '┌', '╖', '╜', '└' },
  double_vertical       = { '─', '│', '─', '│', '╓', '╖', '╜', '╙' },
  vintage               = { '-', '|', '-', '|', '+', '+', '+', '+' },
  rounded_clc           = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
  single_clc            = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
  double_clc            = { '╔', '═', '╗', '║', '╝', '═', '╚', '║' },
  double_header_clc     = { '╒', '═', '╕', '│', '┘', '─', '└', '│' },
  double_bottom_clc     = { '┌', '─', '┐', '│', '╛', '═', '╘', '│' },
  double_horizontal_clc = { '╒', '═', '╕', '│', '╛', '═', '╘', '│' },
  double_left_clc       = { '╓', '─', '┐', '│', '┘', '─', '╙', '│' },
  double_right_clc      = { '┌', '─', '╖', '│', '╜', '─', '└', '│' },
  double_vertical_clc   = { '╓', '─', '╖', '│', '╜', '─', '╙', '│' },
  vintage_clc           = { '+', '-', '+', '|', '+', '-', '+', '|' },
  solid                 = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
  none                  = { '', '', '', '', '', '', '', '' },
}
-- stylua: ignore end

local icons_mt = {}

function icons_mt:__index(key)
  for _, icons in pairs(self) do
    if icons[key] then
      return icons[key]
    end
  end
  return icons_mt[key]
end

---Flatten the layered icons table into a single type-icon table.
---@return table<string, string>
function icons_mt:flatten()
  local result = {}
  for _, icons in pairs(self) do
    for type, icon in pairs(icons) do
      result[type] = icon
    end
  end
  return result
end

-- stylua: ignore start
M.icons = setmetatable({
  debug = {
    StackFrame          = ' ',
    StackFrameCurrent   = ' ',
  },
  diagnostics = {
    DiagnosticSignError = '󰅚 ',
    DiagnosticSignHint  = '󰌶 ',
    DiagnosticSignInfo  = '󰋽 ',
    DiagnosticSignOk    = '󰄬 ',
    DiagnosticSignWarn  = '󰀪 ',
  },
  kinds = {
    Array               = '󰅪 ',
    Boolean             = ' ',
    BreakStatement      = '󰙧 ',
    Calculator          = '󰃬 ',
    Call                = '󰃷 ',
    CaseStatement       = '󱃙 ',
    Class               = ' ',
    Color               = '󰏘 ',
    Constant            = '󰏿 ',
    Constructor         = ' ',
    ContinueStatement   = '→ ',
    Copilot             = ' ',
    Declaration         = '󰙠 ',
    Delete              = '󰩺 ',
    DoStatement         = '󰑖 ',
    Enum                = ' ',
    EnumMember          = ' ',
    Event               = ' ',
    Field               = ' ',
    File                = '󰈔 ',
    Folder              = '󰉋 ',
    ForStatement        = '󰑖 ',
    Format              = '󰗈 ',
    Function            = '󰊕 ',
    GitBranch           = ' ',
    H1Marker            = '󰉫 ',
    H2Marker            = '󰉬 ',
    H3Marker            = '󰉭 ',
    H4Marker            = '󰉮 ',
    H5Marker            = '󰉯 ',
    H6Marker            = '󰉰 ',
    Identifier          = '󰀫 ',
    IfStatement         = '󰇉 ',
    Interface           = ' ',
    Keyword             = '󰌋 ',
    List                = '󰅪 ',
    Log                 = '󰦪 ',
    Lsp                 = ' ',
    Macro               = '󰁌 ',
    MarkdownH1          = '󰉫 ',
    MarkdownH2          = '󰉬 ',
    MarkdownH3          = '󰉭 ',
    MarkdownH4          = '󰉮 ',
    MarkdownH5          = '󰉯 ',
    MarkdownH6          = '󰉰 ',
    Method              = '󰆧 ',
    Module              = '󰏗 ',
    Namespace           = '󰅩 ',
    Null                = '󰢤 ',
    Number              = '󰎠 ',
    Object              = '󰅩 ',
    Operator            = '󰆕 ',
    Package             = '󰆦 ',
    Pair                = '󰅪 ',
    Property            = ' ',
    Reference           = '󰦾 ',
    Regex               = ' ',
    Repeat              = '󰑖 ',
    Scope               = '󰅩 ',
    Snippet             = '󰩫 ',
    Specifier           = '󰦪 ',
    Statement           = '󰅩 ',
    String              = '󰉾 ',
    Struct              = ' ',
    SwitchStatement     = '󰺟 ',
    Terminal            = ' ',
    Text                = ' ',
    Type                = ' ',
    TypeParameter       = '󰆩 ',
    Unit                = ' ',
    Value               = '󰎠 ',
    Variable            = '󰀫 ',
    WhileStatement      = '󰑖 ',
  },
  ft = {
    Assembly            = ' ',
    Bak                 = '󰁯 ',
    Config              = ' ',
    Cuda                = '󱗼 ',
    Data                = '󰆼 ',
    Desktop             = '󰟀 ',
    Elisp               = ' ',
    Git                 = '󰊢 ',
    Ipynb               = '󰠮 ',
    Java                = ' ',
    Lock                = '󰌾 ',
    Markdown            = ' ',
    Object              = ' ',
    Pdf                 = ' ',
    Raw                 = '󱨏 ',
    Sh                  = ' ',
    Theme               = '󰏘 ',
    Video               = '󰈰 ',
    Zip                 = '󰗄 ',
  },
  ui = {
    AngleDown           = ' ',
    AngleLeft           = ' ',
    AngleRight          = ' ',
    AngleUp             = ' ',
    ArrowDown           = '↓ ',
    ArrowLeft           = '← ',
    ArrowRight          = '→ ',
    ArrowUp             = '↑ ',
    Cross               = '󰅖 ',
    Ok                  = '󰄬 ',
    Diamond             = '◆ ',
    Dot                 = '• ',
    DotLarge            = ' ',
    Ellipsis            = '… ',
    Pin                 = '󰐃 ',
    TriangleDown        = '▼ ',
    TriangleLeft        = '◀ ',
    TriangleRight       = '▶ ',
    TriangleUp          = '▲ ',
  },
}, icons_mt)
-- stylua: ignore end

return M
