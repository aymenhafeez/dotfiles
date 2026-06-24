local mod = require("utils").modify_colour

local function hex_to_rgb(hex)
  return {
    tonumber(hex:sub(2, 3), 16),
    tonumber(hex:sub(4, 5), 16),
    tonumber(hex:sub(6, 7), 16),
  }
end

local function blend(foreground, background, alpha)
  local fg = hex_to_rgb(foreground)
  local bg = hex_to_rgb(background)
  local function ch(i)
    local v = (alpha * fg[i]) + ((1 - alpha) * bg[i])
    return math.floor(math.min(math.max(v, 0), 255) + 0.5)
  end
  return string.format("#%02x%02x%02x", ch(1), ch(2), ch(3))
end

local function hex8_to_hex6(hex, bg)
  if #hex ~= 9 then
    return hex
  end
  local rgb = hex:sub(1, 7)
  local alpha = tonumber(hex:sub(8, 9), 16) / 255
  return blend(rgb, bg, alpha)
end

local function apply()
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  vim.o.termguicolors = true
  vim.o.background = "dark"
  vim.g.colors_name = "2026-dark"

  local c = {
    bg = "#121314",
    bg_panel = "#191A1B",
    bg_elevated = "#191A1B",
    bg_line = "#242526",
    fg = "#BBBEBF",
    fg_ui = "#bfbfbf",
    fg_muted = "#8C8C8C",
    fg_gutter = "#858889",
    border = "#2A2B2C",
    accent = "#3994BC",
    link = "#48A0C7",
    error = "#f48771",
    warn = "#e5ba7d",
    info = "#3a94bc",
    cyan = "#4EC9B0",
    lime = "#B5CEA8",
    hint = "#8C8C8C",
    ok = "#73c991",
    add = "#72C892",
    delete = "#F28772",

    comment = "#8b949e",
    keyword = "#ff7b72",
    constant = "#79c0ff",
    ident = "#ffa657",
    variable = "#c9d1d9",
    func = "#d2a8ff",
    rep = "#C586C0",
    tag = "#7ee787",
    string = "#a5d6ff",
  }

  local sel = hex8_to_hex6("#276782dd", c.bg)
  local sel_inactive = hex8_to_hex6("#27678260", c.bg)
  local accent_bg = hex8_to_hex6("#3994BC26", c.bg)
  local accent_bg_soft = hex8_to_hex6("#3994BC33", c.bg)
  local scrollbar = hex8_to_hex6("#83848566", c.bg_panel)
  local whitespace = hex8_to_hex6("#8C8C8C4D", c.bg)
  local indent = hex8_to_hex6("#8384854D", c.bg)

  vim.g.terminal_color_0 = c.bg_panel
  vim.g.terminal_color_1 = c.error
  vim.g.terminal_color_2 = c.ok
  vim.g.terminal_color_3 = c.warn
  vim.g.terminal_color_4 = c.constant
  vim.g.terminal_color_5 = c.func
  vim.g.terminal_color_6 = c.info
  vim.g.terminal_color_7 = c.fg_ui
  vim.g.terminal_color_8 = c.fg_muted
  vim.g.terminal_color_9 = c.delete
  vim.g.terminal_color_10 = c.add
  vim.g.terminal_color_11 = c.warn
  vim.g.terminal_color_12 = c.link
  vim.g.terminal_color_13 = c.func
  vim.g.terminal_color_14 = c.info
  vim.g.terminal_color_15 = "#FFFFFF"

  local highlights = {
    Normal                         = { fg = c.fg, bg = c.bg },
    NormalNC                       = { fg = c.fg, bg = c.bg },
    NormalFloat                    = { fg = c.fg_ui, bg = c.bg_elevated },
    TerminalNormal                 = { bg = c.bg_elevated },
    SidebarNormal                  = { bg = c.bg_elevated },
    FloatBorder                    = { fg = mod(c.border, 80), bg = c.bg },
    FloatTitle                     = { fg = c.fg_ui, bg = c.bg_elevated, bold = true },

    Cursor                         = { fg = c.bg, bg = c.fg },
    CursorLine                     = { bg = c.bg_line },
    CursorColumn                   = { link = "CursorLine" },
    ColorColumn                    = { bg = c.bg_line },
    CursorLineNr                   = { fg = c.fg, bg = c.bg_line, bold = true },
    CursorLineSign                 = { bg = c.bg_line },
    CursorLineFold                 = { bg = c.bg_line },
    LineNr                         = { fg = c.fg_gutter },
    SignColumn                     = { fg = c.fg_muted, bg = c.bg },
    FoldColumn                     = { fg = c.fg_muted, bg = c.bg },

    Visual                         = { bg = sel },
    VisualNOS                      = { bg = sel_inactive },
    Search                         = { bg = hex8_to_hex6("#27678290", c.bg) },
    CurSearch                      = { fg = "#ededed", bg = c.accent },
    IncSearch                      = { link = "CurSearch" },
    MatchParen                     = { bg = hex8_to_hex6("#3994BC55", c.bg) },

    Pmenu                          = { fg = c.fg_ui, bg = c.bg_elevated },
    PmenuSel                       = { fg = "#ededed", bg = accent_bg },
    PmenuSbar                      = { bg = c.bg_panel },
    PmenuThumb                     = { bg = scrollbar },
    WildMenu                       = { link = "PmenuSel" },

    StatusLine                     = { fg = c.fg_muted, bg = c.bg_panel },
    StatusLineNC                   = { fg = c.fg_muted, bg = c.bg_panel },
    User1                          = { link = "DiagnosticError" },
    WinSeparator                   = { fg = c.border },
    TabLine                        = { fg = c.fg_muted, bg = c.bg_panel },
    TabLineSel                     = { fg = c.fg_ui, bg = c.bg, bold = true },
    TabLineFill                    = { bg = c.bg_panel },

    NonText                        = { fg = c.fg_muted },
    EndOfBuffer                    = { fg = c.bg },
    Whitespace                     = { fg = whitespace },
    Conceal                        = { fg = c.fg_muted },
    SpecialKey                     = { fg = c.fg_muted },
    Directory                      = { fg = c.link },
    Title                          = { fg = c.fg_ui, bold = true },

    Error                          = { fg = c.error },
    ErrorMsg                       = { fg = c.error, bold = true },
    WarningMsg                     = { fg = c.warn, bold = true },
    MoreMsg                        = { fg = c.info },
    Question                       = { fg = c.info },

    Comment                        = { fg = c.comment, italic = true },
    Constant                       = { fg = c.constant },
    String                         = { fg = c.string },
    Character                      = { fg = c.keyword },
    Number                         = { fg = c.lime },
    Boolean                        = { fg = c.constant },
    Float                          = { fg = c.lime },
    Identifier                     = { fg = c.ident },
    Function                       = { fg = c.func },
    Statement                      = { fg = c.keyword },
    Conditional                    = { fg = c.keyword },
    Repeat                         = { fg = c.keyword },
    Label                          = { fg = c.ident },
    Operator                       = { fg = c.fg },
    Keyword                        = { fg = c.keyword },
    Exception                      = { fg = c.keyword },
    PreProc                        = { fg = c.keyword },
    Include                        = { fg = c.fg },
    Define                         = { fg = c.keyword },
    Macro                          = { fg = c.ident },
    PreCondit                      = { fg = c.fg },
    Type                           = { fg = c.constant },
    StorageClass                   = { fg = c.keyword },
    Structure                      = { fg = c.constant },
    Typedef                        = { fg = c.constant },
    Special                        = { fg = c.keyword, bold = true },
    SpecialChar                    = { fg = c.ok, bold = true },
    Tag                            = { fg = c.tag },
    Delimiter                      = { fg = c.fg_muted },
    SpecialComment                 = { fg = c.comment, italic = true },
    Debug                          = { fg = c.func },
    Underlined                     = { fg = c.link, underline = true },
    Bold                           = { bold = true },
    Italic                         = { italic = true },
    Ignore                         = { fg = c.fg_muted },
    Todo                           = { fg = c.warn, bold = true },

    DiffAdd                        = { bg = "#17231a" },
    DiffChange                     = { bg = c.bg_line },
    DiffDelete                     = { fg = "#2d1919", bg = "#2d1919" },
    DiffText                       = { bg = accent_bg_soft },
    Added                          = { fg = c.add },
    Changed                        = { fg = c.warn },
    Removed                        = { fg = c.delete },

    DiffViewNormal                 = { link = "SidebarNormal" },

    DiagnosticError                = { fg = c.error },
    DiagnosticWarn                 = { fg = c.warn },
    DiagnosticInfo                 = { fg = c.info },
    DiagnosticHint                 = { fg = c.hint },
    DiagnosticOk                   = { fg = c.ok },
    DiagnosticUnderlineError       = { sp = c.error, undercurl = true },
    DiagnosticUnderlineWarn        = { sp = c.warn, undercurl = true },
    DiagnosticUnderlineInfo        = { sp = c.info, undercurl = true },
    DiagnosticUnderlineHint        = { sp = c.hint, undercurl = true },
    DiagnosticUnderlineOk          = { sp = c.ok, undercurl = true },
    DiagnosticVirtualTextError     = { fg = c.error, bg = "#3A1D1D" },
    DiagnosticVirtualTextWarn      = { fg = c.warn, bg = "#352A05" },
    DiagnosticVirtualTextInfo      = { fg = c.fg_ui, bg = "#1E3A47" },
    DiagnosticVirtualTextHint      = { fg = c.fg_muted, bg = c.bg_panel },
    DiagnosticVirtualTextOk        = { fg = c.ok, bg = c.bg_panel },

    LspReferenceText               = { bg = mod(sel, -30) },
    LspReferenceRead               = { bg = mod(accent_bg, 50) },
    LspReferenceWrite              = { bg = mod(sel, -30) },
    LspCodeLens                    = { fg = c.fg_muted },
    LspCodeLensSeparator           = { fg = c.fg_muted },
    LspSignatureActiveParameter    = { underline = true, bold = true },
    LspInlayHint                   = { fg = c.fg_muted },

    GitSignsAdd                    = { fg = c.add },
    GitSignsChange                 = { fg = c.warn },
    GitSignsDelete                 = { fg = c.delete },
    GitSignsCurrentLineBlame       = { fg = c.comment },

    Scrollbar                      = { fg = indent },
    ScrollbarThumb                 = { fg = scrollbar },

    ["@comment"]                   = { fg = c.comment, italic = true },
    ["@constant"]                  = { fg = c.constant },
    ["@constant.builtin"]          = { fg = c.constant },
    ["@constant.macro"]            = { fg = c.ident },
    ["@string"]                    = { fg = c.string },
    ["@string.regexp"]             = { fg = c.string },
    ["@string.escape"]             = { fg = c.ok, bold = true },
    ["@character"]                 = { fg = c.keyword },
    ["@number"]                    = { link = "Number" },
    ["@boolean"]                   = { fg = c.constant },
    ["@variable"]                  = { fg = c.variable },
    ["@variable.builtin"]          = { fg = c.constant },
    ["@variable.parameter"]        = { fg = c.ident },
    -- ["@variable.member"]           = { fg = c.variable },
    ["@variable.member"]           = { fg = c.ident },
    ["@property"]                  = { fg = c.constant },
    ["@module"]                    = { fg = c.cyan },
    ["@function"]                  = { fg = c.func },
    ["@function.builtin"]          = { fg = c.cyan },
    ["@function.macro"]            = { fg = c.ident },
    ["@constructor"]               = { fg = c.cyan },
    ["@keyword"]                   = { fg = c.keyword },
    ["@keyword.function"]          = { fg = c.keyword },
    ["@keyword.exception"]         = { fg = c.keyword },
    ["@keyword.import"]            = { fg = c.func },
    ["@keyword.return"]            = { fg = c.func },
    ["@keyword.repeat"]            = { fg = c.rep },
    ["@keyword.conditional"]       = { fg = c.rep },
    ["@keyword.operator"]          = { fg = c.rep },
    ["@type"]                      = { fg = c.cyan },
    ["@type.builtin"]              = { fg = c.cyan },
    ["@operator"]                  = { fg = c.fg },
    ["@punctuation.bracket"]       = { fg = c.ident },
    ["@punctuation.delimiter"]     = { fg = c.fg_muted },
    ["@punctuation.special"]       = { fg = c.warn },
    ["@tag"]                       = { fg = c.tag },
    ["@tag.attribute"]             = { fg = c.ident },
    ["@tag.delimiter"]             = { fg = c.fg_muted },

    ["@markup.heading"]            = { fg = c.constant, bold = true },
    ["@markup.strong"]             = { fg = c.variable, bold = true },
    ["@markup.italic"]             = { fg = c.variable, italic = true },
    ["@markup.underline"]          = { underline = true },
    ["@markup.strikethrough"]      = { strikethrough = true },
    ["@markup.quote"]              = { fg = c.tag },
    ["@markup.math"]               = { fg = c.constant },
    ["@markup.raw"]                = { fg = c.constant },
    ["@markup.link"]               = { fg = c.string, underline = true },
    ["@markup.list"]               = { fg = c.ident },

    ["@diff.plus"]                 = { fg = c.add, bg = "#04260f" },
    ["@diff.minus"]                = { fg = "#ffa198", bg = "#490202" },
    ["@diff.delta"]                = { fg = c.ident, bg = "#5a1e02" },

    SnacksPickerGitStatusUntracked = { fg = c.comment },
    SnacksPicker                   = { bg = c.bg_elevated },
    -- SnacksWinSeparator             = { fg = c.bg_elevated, bg = c.bg_elevated },
    SnacksPickerInputBorder        = { fg = c.border, bg = c.bg_elevated },
    SnacksPickerInputTitle         = { fg = c.consant, bg = c.bg_elevated },
    SnacksPickerTree               = { fg = mod(c.comment, -50), bg = c.bg_elevated },
    SnacksIndentScope              = { fg = mod(c.comment, -25) },
    SnacksIndent                   = { fg = mod(c.comment, -50) },

    TreeSitterContext              = { bg = c.bg, underline = true, sp = c.border },
    TreeSitterContextLineNumber    = { fg = c.fg, bg = c.bg, bold = true, underline = true, sp = c.border },

    BufferLineOffsetSeparator      = { fg = c.border, bg = c.bg },
    BufferLineFill                 = { bg = c.bg_elevated },

    FzfLuaBorder                   = { link = "FloatBorder" },
    FzfLuaLivePrompt               = { fg = c.fg },
    FzfLuaFzfHeader                = { fg = c.constant },
    FzfLuaFzfPrompt                = { fg = c.fg },
    FzfLuaFzfPointer               = { fg = sel },
    FzfLuaCursorline               = { link = "Visual" },
    -- fzf1                                       = { link = "Statusline" },
    fzf1                           = { fg = "bg", bg = "bg" },
    fzf2                           = { link = "fzf1" },
    fzf3                           = { link = "fzf1" },
    FzfLuaTitle                    = { link = "fzf1" },
    FzfLuaTitleFlags               = { link = "fzf1" },
    FzfLuaFzfSeparator             = { fg = c.bg },

    MiniIconsAzure                 = { fg = c.constant },
  }

  for group, spec in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, spec)
  end
end

apply()

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    if vim.g.colors_name == "2026-dark" then
      apply()
    end
  end,
})
