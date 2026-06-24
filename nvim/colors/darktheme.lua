local mod = require("utils").modify_colour

local function mod_custom(hex, pcnt)
  local is_light = vim.o.background == "light"
  return is_light and mod(hex, pcnt) or mod(hex, -pcnt)
end

local palettes = {
  dark = {
    bg = "#151515",
    fg = "#c5c8c6",
    purple = "#b294bb",
    green = "#b5bd68",
    orange = "#de935f",
    blue = "#81a2be",
    yellow = "#f0c674",
    cyan = "#7eada7",
    red = "#cc6666",
    comment = "#a89984",
    none = "none",
    light_orange = "#e78c45",
    light_purple = "#c397d8",
    bg_light = "#1d1f21",
    bg_light2 = "#282828",
    bg_light3 = "#3b3f4c",
    fg_dark = "#afb2b0",
    fg_dark2 = "#969896",
    fg_dark3 = "#696969",
    bg_dark = mod("#151515", -20),
  },
  dimmed = {
    bg = "#1a1c1f",
    fg = "#c5c8c6",
    purple = "#b19db8",
    green = "#b3ba7e",
    orange = "#d99667",
    blue = "#93a8b8",
    yellow = "#d9bf89",
    cyan = "#9bb0ac",
    red = "#c37d7c",
    peach = "#D2A57A",
    comment = "#696969",
    operator = "#c5c8c6",
    none = "none",
    bg_light = mod("#1a1c1f", 30),
    bg_light2 = mod("#1a1c1f", 40),
    -- bg_light2 = "#323436",
    bg_light3 = mod("#1a1c1f", 80),
    fg_dark = "#959896",
    fg_dark2 = "#858886",
    fg_dark3 = "#858886",
    bg_dark = mod("#1a1c1f", -25)
  },
  light = {
    bg = "#ffffff",
    fg = "#001070",
    purple = "#7929c8",
    green = "#008000",
    orange = "#df5926",
    blue = "#0070c1",
    yellow = "#7c5c20",
    cyan = "#1e797f",
    red = "#a31515",
    comment = mod("#595959", 30),
    none = "none",
    light_orange = "#c72e0f",
    light_purple = "#693988",
    bg_light = "#f0f0f8",
    bg_light2 = "#e8e8e0",
    bg_light3 = "#d8d8d0",
    fg_dark = "#698989",
    fg_dark2 = "#797979",
    fg_dark3 = "#595959",
    bg_dark = "#f0f0f8"
  },
}

local opts = {
  end_of_buffer = false,
  visual_bold = false,
  diagnostics = {
    darker = false,
    background = true,
    undercurl = true,
  },
}

local function rgb(hex)
  hex = string.lower(hex)
  return {
    tonumber(hex:sub(2, 3), 16),
    tonumber(hex:sub(4, 5), 16),
    tonumber(hex:sub(6, 7), 16),
  }
end

local function h2rgb(p, q, t)
  if t < 0 then
    t = t + 1
  end
  if t > 1 then
    t = t - 1
  end
  if t < 1 / 6 then
    return p + (q - p) * 6 * t
  end
  if t < 1 / 2 then
    return q
  end
  if t < 2 / 3 then
    return p + (q - p) * (2 / 3 - t) * 6
  end
  return p
end

local function hsl_from_rgb(c)
  local r = c[1] / 255
  local g = c[2] / 255
  local b = c[3] / 255
  local max = math.max(r, g, b)
  local min = math.min(r, g, b)

  local h = 0
  local s = 0
  local l = (max + min) / 2
  if max ~= min then
    local delta = max - min
    s = l > 0.5 and delta / (2 - max - min) or delta / (max + min)
    if max == r then
      h = (g - b) / delta + (g > b and 6 or 0)
    elseif max == g then
      h = (b - r) / delta + 2
    else
      h = (r - g) / delta + 4
    end
    h = h / 6
  end

  return { h, s, l }
end

local function rgb_from_hsl(hsl)
  local h = hsl[1]
  local s = hsl[2]
  local l = hsl[3]
  local r
  local g
  local b
  if s == 0 then
    r = l
    g = l
    b = l
  else
    local q = l < 0.5 and l * (1 + s) or l + s - l * s
    local p = 2 * l - q
    r = h2rgb(p, q, h + 1 / 3)
    g = h2rgb(p, q, h)
    b = h2rgb(p, q, h - 1 / 3)
  end
  return { r * 255, g * 255, b * 255 }
end

local function blend(foreground, background, alpha)
  local bg = rgb(background)
  local fg = rgb(foreground)
  local function blend_channel(i)
    local value = alpha * fg[i] + (1 - alpha) * bg[i]
    return math.floor(math.min(math.max(0, value), 255) + 0.5)
  end
  return string.format("#%02x%02x%02x", blend_channel(1), blend_channel(2), blend_channel(3))
end

local function darken(color, amount, bg)
  return blend(color, bg or "#000000", math.abs(amount))
end

local function lighten(color, amount, fg)
  return blend(color, fg or "#ffffff", math.abs(amount))
end

local function saturate(color, amount)
  local hsl = hsl_from_rgb(rgb(color))
  hsl[2] = hsl[2] + (amount or 0.1)
  if hsl[2] > 1 then
    hsl[2] = 1
  elseif hsl[2] < 0 then
    hsl[2] = 0
  end
  local c = rgb_from_hsl(hsl)
  return string.format("#%02x%02x%02x", c[1], c[2], c[3])
end

local function with_subgroups(palette_key)
  local p = vim.deepcopy(palettes[palette_key])

  if palette_key == "dimmed" then
    p.diag = {
      error = p.red,
      info = p.cyan,
      warn = p.orange,
      hint = p.cyan,
      ok = p.green,
    }
    p.syn = {
      ident = p.fg,
      constant = p.orange,
      literal = p.orange,
      func = p.blue,
      string = p.green,
      type = p.yellow,
      keyword = p.purple,
      keyword_mod = p.red,
      special = p.red,
      delim = p.fg_dark3,
      exception = p.red,
      operator = p.operator,
    }
  else
    p.diag = {
      error = p.red,
      info = p.cyan,
      warn = p.yellow,
      hint = p.purple,
      ok = p.green,
    }
    p.syn = {
      ident = p.fg,
      constant = p.orange,
      literal = p.light_orange,
      func = p.blue,
      string = p.green,
      type = p.yellow,
      keyword = p.purple,
      keyword_mod = p.light_purple,
      special = p.red,
      delim = p.fg_dark3,
      exception = p.red,
      operator = p.fg,
    }
  end

  p.diff = {
    add = blend(p.green, p.bg, palette_key == "light" and 0.15 or 0.3),
    remove = blend(p.red, p.bg, 0.2),
    change = palette_key == "light" and p.bg_light2 or blend(p.fg_dark3, p.bg, 0.3),
    text = blend(p.blue, p.bg, palette_key == "dark" and 0.4 or 0.35),
  }

  p.terminal = {
    black = lighten(p.bg_light3, 0.95),
    bright_black = p.fg_dark3,
    red = darken(p.red, 0.85),
    bright_red = p.red,
    green = darken(p.green, 0.85),
    bright_green = p.green,
    yellow = darken(p.yellow, 0.85),
    bright_yellow = p.yellow,
    blue = darken(p.blue, 0.85),
    bright_blue = p.blue,
    purple = darken(p.purple, 0.85),
    bright_purple = p.purple,
    cyan = darken(p.cyan, 0.85),
    bright_cyan = p.cyan,
    white = p.fg,
    bright_white = lighten(p.fg, 0.85),
  }

  local palette_highlights = {
    dark = {
      ["@attribute.builtin"] = { fg = p.red },
      ["@attribute.typescript"] = { fg = p.blue },
      ["@constructor"] = { fg = p.yellow },
      ["@function.macro"] = "Macro",
      ["@keyword.coroutine"] = { fg = p.syn.keyword_mod },
      ["@keyword.exception"] = { fg = p.syn.exception },
      ["@keyword.function"] = { fg = p.syn.keyword_mod },
      ["@keyword.operator"] = { fg = p.syn.keyword_mod },
      ["@markup.italic"] = { fg = p.light_orange, italic = true },
      ["@markup.strong"] = { fg = p.light_orange, bold = true },
      ["@markup.link.url"] = { fg = p.blue },
      ["@markup.list"] = "Special",
      ["@markup.math"] = { fg = p.blue },
      ["@markup.quote"] = { fg = p.fg_dark2 },
      ["@markup.raw.block"] = { fg = p.fg_dark2 },
      ["@module"] = { fg = lighten(p.fg, 0.7, p.blue) },
      ["@string.escape"] = { fg = p.red },
      ["@string.regexp"] = { fg = p.orange },
      ["@string.special.url"] = { fg = p.blue, underline = true },
      ["@string.special.vimdoc"] = { fg = p.light_orange },
      ["@tag"] = { fg = p.red },
      ["@tag.attribute"] = { fg = p.orange },
      ["@tag.builtin"] = "Special",
      ["@tag.delimiter"] = { fg = p.fg_dark2 },
      ["@type.builtin"] = { fg = p.light_orange },
      ["@type.tag.css"] = { fg = p.orange },
      ["@label.markdown"] = "Tag",
      ["@label.vimdoc"] = { fg = p.light_purple },
      ["@keyword.gitcommit"] = { fg = p.blue },
      ["@namespace.vim"] = { fg = p.orange },
      ["@punctuation.bracket.css"] = { fg = p.fg_dark2 },
      FloatBorder = { fg = p.fg_dark3, bg = p.bg },
      FloatTitle = "Title",
      FoldColumn = { fg = p.fg_dark, bg = p.bg_light },
      Identifier = { fg = p.red },
      Ignore = "Normal",
      Include = { fg = p.purple },
      Label = { fg = p.light_orange },
      SpecialKey = { fg = p.fg_dark3 },
      -- StatusLine = { fg = p.fg_dark2, bg = p.bg_light },
      -- StatusLineNC = { fg = p.fg_dark3, bg = p.bg_light },
      StatusLine = { fg = p.fg_dark2, bg = p.bg_dark },
      StatusLineNC = { fg = p.fg_dark3, bg = p.bg_dark },
      StorageClass = { fg = p.red },
      SnacksIndentScope = { fg = mod(p.comment, -50) },
      SnacksIndent = { fg = mod(p.comment, -70) },
    },
    light = {
      ["@attribute.builtin"]         = { fg = p.red },
      ["@attribute.typescript"]      = { fg = p.blue },
      ["@constructor"]               = { fg = p.yellow },
      ["@function.macro"]            = "Macro",
      ["@keyword.coroutine"]         = { fg = p.syn.keyword_mod },
      ["@keyword.exception"]         = { fg = p.syn.exception },
      ["@keyword.function"]          = { fg = p.syn.keyword_mod },
      ["@keyword.operator"]          = { fg = p.syn.keyword_mod },
      ["@markup.italic"]             = { fg = p.light_orange, italic = true },
      ["@markup.strong"]             = { fg = p.light_orange, bold = true },
      ["@markup.link.url"]           = { fg = p.blue },
      ["@markup.list"]               = "Special",
      ["@markup.math"]               = { fg = p.blue },
      ["@markup.quote"]              = { fg = p.fg_dark2 },
      ["@markup.raw.block"]          = { fg = p.fg_dark2 },
      ["@string.escape"]             = { fg = p.red },
      ["@string.regexp"]             = { fg = p.orange },
      ["@string.special.url"]        = { fg = p.blue, underline = true },
      ["@string.special.vimdoc"]     = { fg = p.light_orange },
      ["@tag"]                       = { fg = p.red },
      ["@tag.attribute"]             = { fg = p.orange },
      ["@tag.builtin"]               = "Special",
      ["@tag.delimiter"]             = { fg = p.fg_dark2 },
      ["@type.builtin"]              = { fg = p.light_orange },
      ["@type.tag.css"]              = { fg = p.orange },
      ["@label.markdown"]            = "Tag",
      ["@label.vimdoc"]              = { fg = p.light_purple },
      ["@keyword.gitcommit"]         = { fg = p.blue },
      ["@namespace.vim"]             = { fg = p.orange },
      ["@punctuation.bracket.css"]   = { fg = p.fg_dark2 },
      FloatBorder                    = { fg = p.fg_dark3, bg = p.bg },
      FloatTitle                     = "Title",
      FoldColumn                     = { fg = p.fg_dark, bg = p.bg_light },
      Identifier                     = { fg = p.red },
      Ignore                         = "Normal",
      Include                        = { fg = p.purple },
      Label                          = { fg = p.light_orange },
      PmenuSel                       = { fg = p.blue, bg = p.bg_light2, bold = true },
      PmenuThumb                     = { bg = p.fg_dark2 },
      SpecialKey                     = { fg = p.fg_dark3 },
      StatusLine                     = { fg = p.fg_dark2, bg = p.bg_light },
      StatusLineNC                   = { fg = p.fg_dark3, bg = p.bg_light },
      StorageClass                   = { fg = p.red },

      WinSeparator                   = { fg = mod(p.fg_dark2, 80) },
      MatchParen                     = { bg = mod(p.bg_light3, -20), bold = true },

      -- SnacksPicker                = { bg = p.bg_dark },
      -- SnacksWinSeparator          = { fg = p.bg_dark, bg = p.bg_dark },
      SnacksWinSeparator             = "WinSeparator",
      SnacksPickerInputBorder        = { fg = mod_custom(p.fg_dark3, 40), bg = p.bg_dark },
      SnacksPickerBorder             = { fg = p.bg_dark, bg = p.bg_dark },
      SnacksPickerInputTitle         = { fg = p.blue, bg = p.bg_dark },
      SnacksPickerTree               = { fg = p.comment, bg = p.bg_dark },
      SnacksPickerPrompt             = { bg = p.bg_dark },
      SnacksImageMath                = { fg = p.orange },
      SnacksPickerGitStatusUntracked = { fg = p.fg_dark },
      SnacksBackdrop                 = { bg = p.bg },
      -- SnacksBackdrop_0a0b0c          = { bg = p.bg },
      SnacksPickerMatch              = { link = "CurSearch" },
      SnacksIndentScope              = { fg = mod(p.fg_dark2, 40) },
      SnacksIndent                   = { fg = mod(p.fg_dark2, 80) },

      FzfLuaFzfSeparator             = { fg = p.bg_light },

      BufferLineOffsetSeparator      = "WinSeparator",
    },
  }
  p.highlights = palette_highlights[palette_key] or {}

  return p
end

local function neovim_groups(c)
  return {
    ColorColumn                    = { bg = c.bg_light },
    Conceal                        = { fg = c.comment },
    CurSearch                      = { fg = c.bg, bg = c.orange },
    Cursor                         = { fg = c.bg, bg = c.fg, blink = true },
    CursorColumn                   = { bg = c.bg_light },
    CursorIM                       = { fg = c.bg, bg = c.fg },
    CursorLine                     = { bg = mod(c.bg_light, 0) },
    CursorLineFold                 = { bg = c.bg },
    CursorLineNr                   = { fg = c.fg, bg = c.bg },
    CursorLineSign                 = { bg = c.bg },
    DiffAdd                        = { bg = c.diff.add },
    DiffChange                     = { bg = c.diff.change },
    DiffDelete                     = { fg = c.diff.remove, bg = c.diff.remove },
    DiffText                       = { bg = c.diff.text },
    GitSignsCurrentLineBlame       = { fg = c.comment },
    -- GitSignsAdd                    = { fg = c.green, bg = c.bg_light },
    -- GitSignsDelete                 = { fg = c.red, bg = c.bg_light },
    -- GitSignsChange                 = { fg = c.yellow, bg = c.bg_light },
    NeogitActiveItem               = { bg = opts.diagnostics.background and darken(c.cyan, 0.25, c.bg) or c.none },
    NeogitGraphPurple              = { fg = c.cyan },
    NeogitHunkHeaderCursor         = { bg = c.fg },
    NeogitHunkHeaderHighlight      = { bg = c.fg },
    Directory                      = { fg = c.blue },
    EndOfBuffer                    = { fg = opts.end_of_buffer and c.fg_dark or c.bg },
    ErrorMsg                       = { fg = c.diag.error, bold = true },
    -- FloatBorder                    = { fg = mod_custom(c.fg_dark3, 40), bg = c.bg },
    FloatBorder                    = { fg = mod_custom(c.fg_dark3, 40), bg = c.bg_dark },
    FloatFooter                    = "FloatTitle",
    FloatTitle                     = { fg = c.fg, bg = c.bg_light, bold = true },
    FoldColumn                     = { fg = c.fg_dark },
    Folded                         = { fg = c.fg_dark, bg = c.bg_light },
    IncSearch                      = { fg = c.bg, bg = c.orange },
    LineNr                         = { fg = c.comment, bg = c.bg },
    LineNrAbove                    = "LineNr",
    LineNrBelow                    = "LineNr",
    MatchParen                     = { fg = c.orange, bg = c.comment, bold = true },
    ModeMsg                        = { fg = c.fg_dark },
    MoreMsg                        = { fg = c.purple },
    MsgArea                        = { fg = c.none, bg = c.none },
    MsgSeparator                   = "StatusLine",
    NonText                        = { fg = c.fg_dark },
    Normal                         = { fg = c.fg, bg = c.bg },
    NormalFloat                    = { fg = c.fg, bg = c.bg_dark },
    NormalNC                       = { fg = c.none, bg = c.none },
    Pmenu                          = { fg = c.fg_dark, bg = mod_custom(c.bg_light, -20) },
    PmenuExtra                     = "Pmenu",
    PmenuExtraSel                  = "PmenuSel",
    PmenuKind                      = "Pmenu",
    PmenuKindSel                   = "PmenuSel",
    PmenuMatch                     = { fg = c.cyan, bold = true, underline = true },
    PmenuMatchSel                  = { fg = c.cyan, bold = true, underline = true },
    PmenuSbar                      = { fg = c.none, bg = c.bg_light3 },
    PmenuSel                       = { fg = c.cyan, bg = c.bg_light3 },
    PmenuThumb                     = { fg = c.fg_dark3, bg = c.fg_dark3 },
    Question                       = { fg = c.yellow },
    QuickFixLine                   = "TerminalNormal",
    Search                         = { fg = c.bg, bg = c.yellow },
    -- SignColumn                     = { bg = mod(c.bg_light, -10) },
    SignColumn                     = { bg = c.bg },
    SnippetTabstop                 = "Visual",
    SpecialKey                     = { fg = c.fg_dark },
    SpellBad                       = { sp = c.red, underline = not opts.diagnostics.undercurl, undercurl = opts.diagnostics.undercurl },
    SpellCap                       = { sp = c.fg_dark, underline = not opts.diagnostics.undercurl, undercurl = opts.diagnostics.undercurl },
    SpellLocal                     = { sp = c.fg_dark, underline = not opts.diagnostics.undercurl, undercurl = opts.diagnostics.undercurl },
    SpellRare                      = { sp = c.purple, underline = not opts.diagnostics.undercurl, undercurl = opts.diagnostics.undercurl },
    StatusLine                     = { fg = mod(c.fg_dark, 20), bg = mod(c.bg_dark, 0) },
    StatusLineNC                   = { fg = c.fg_dark2, bg = mod(c.bg_dark, 0) },
    -- StatusLine                     = { fg = c.fg_dark, bg = mod(c.bg_light, 30) },
    -- StatusLineNC                   = { fg = c.fg_dark2, bg = mod(c.bg_light, 30) },
    User1                          = { fg = c.diag.error, bold = true },
    User3                          = { fg = c.cyan, bold = true },
    User4                          = { fg = c.fg_dark, bold = true },
    User5                          = { fg = c.fg_dark, bold = true },
    User6                          = { fg = c.fg_dark, bold = false },
    User9                          = { fg = c.cyan, bold = true },
    Substitute                     = "CurSearch",
    TabLine                        = { fg = c.comment, bg = c.bg_dark },
    TabLineFill                    = { bg = c.bg_dark },
    TabLineSel                     = { fg = c.fg, bg = c.bg_dark, bold = true },
    TerminalNormal                 = { bg = c.bg_dark },
    SidebarNormal                  = "NormalFloat",
    DBUINormal                     = "TerminalNormal",
    DBUIOutNormal                  = "TerminalNormal",
    TermCursor                     = "Cursor",
    TermCursorNC                   = {},
    Title                          = { fg = c.fg, bold = true },
    Visual                         = { fg = c.none, bg = c.bg_light3, bold = opts.visual_bold },
    VisualNOS                      = "Visual",
    VisualNonText                  = { bg = c.bg_light3, fg = c.comment },
    WarningMsg                     = { fg = c.diag.warn, bold = true },
    Whitespace                     = { fg = c.fg_dark3 },
    WildMenu                       = "CurSearch",
    WinBar                         = "StatusLine",
    WinBarNC                       = "StatusLineNC",
    -- WinSeparator                   = { fg = mod_custom(c.bg, 50), bg = mod_custom(c.bg, 25) },
    WinSeparator                   = { fg = mod_custom(c.fg_dark3, 60), bg = c.bg },
    lCursor                        = { fg = c.bg, bg = c.fg, blink = true },

    Added                          = { fg = c.green },
    Bold                           = { bold = true },
    Boolean                        = { fg = c.syn.literal },
    Changed                        = { fg = c.blue },
    Character                      = { fg = c.syn.string },
    Comment                        = { fg = c.comment, italic = true },
    Conditional                    = { fg = c.syn.keyword },
    Constant                       = { fg = c.syn.constant },
    Debug                          = { fg = c.diag.warn },
    Define                         = { fg = c.syn.keyword },
    Delimiter                      = { fg = c.syn.delim },
    Error                          = { fg = c.diag.error },
    Exception                      = { fg = c.syn.exception },
    Float                          = { fg = c.syn.literal },
    Function                       = { fg = c.syn.func },
    Identifier                     = { fg = c.syn.ident },
    Ignore                         = { fg = c.fg_dark },
    Include                        = { fg = c.syn.keyword },
    Italic                         = { italic = true },
    Keyword                        = { fg = c.syn.keyword },
    Label                          = { fg = c.blue },
    Macro                          = { fg = c.syn.literal },
    Number                         = { fg = c.syn.literal },
    Operator                       = { fg = c.syn.operator },
    PreCondit                      = { fg = c.peach },
    PreProc                        = { fg = c.syn.keyword },
    Removed                        = { fg = c.red },
    Repeat                         = { fg = c.syn.keyword },
    Special                        = { fg = c.syn.special, bold = true },
    SpecialChar                    = { fg = c.syn.special },
    SpecialComment                 = "Comment",
    Statement                      = { fg = c.syn.keyword },
    StorageClass                   = { fg = c.syn.keyword_mod },
    String                         = { fg = c.syn.string },
    Structure                      = { fg = c.syn.type },
    Tag                            = { fg = c.syn.special },
    Todo                           = { fg = c.diag.warn, bold = true },
    Type                           = { fg = c.syn.type },
    Typedef                        = { fg = c.syn.type },
    Underlined                     = { underline = true },

    LspCodeLens                    = { fg = c.fg_dark2, italic = true },
    LspCodeLensSeparator           = { fg = c.fg_dark, italic = true },
    LspInfoBorder                  = { fg = c.fg_dark, bg = c.bg_light },
    LspInlayHint                   = "NonText",
    LspReferenceRead               = { bg = c.bg_light3 },
    LspReferenceTarget             = { bg = c.bg_light3 },
    LspReferenceText               = { bg = c.bg_light3 },
    LspReferenceWrite              = { bg = c.bg_light3 },
    LspSignatureActiveParameter    = { underline = true, bold = true },

    DiagnosticOk                   = { fg = c.diag.ok },
    DiagnosticHint                 = { fg = c.diag.hint },
    DiagnosticInfo                 = { fg = c.diag.info },
    DiagnosticWarn                 = { fg = c.diag.warn },
    DiagnosticError                = { fg = c.diag.error },
    DiagnosticUnnecessary          = { italic = false, undercurl = false },
    DiagnosticUnderlineOk          = { sp = c.diag.ok, underline = not opts.diagnostics.undercurl, undercurl = opts.diagnostics.undercurl },
    DiagnosticUnderlineHint        = { sp = c.diag.hint, underline = not opts.diagnostics.undercurl, undercurl = opts.diagnostics.undercurl },
    DiagnosticUnderlineInfo        = { sp = c.diag.info, underline = not opts.diagnostics.undercurl, undercurl = opts.diagnostics.undercurl },
    DiagnosticUnderlineWarn        = { sp = c.diag.warn, underline = not opts.diagnostics.undercurl, undercurl = opts.diagnostics.undercurl },
    DiagnosticUnderlineError       = { sp = c.diag.error, underline = not opts.diagnostics.undercurl, undercurl = opts.diagnostics.undercurl },

    DiagnosticVirtualTextOk        = {
      fg = opts.diagnostics.darker and darken(c.diag.ok, 0.85, c.bg) or c.diag.ok,
      bg = opts.diagnostics.background and darken(c.diag.ok, 0.1, c.bg) or c.none,
    },
    DiagnosticVirtualTextHint      = {
      fg = opts.diagnostics.darker and darken(c.diag.hint, 0.85, c.bg) or c.diag.hint,
      bg = opts.diagnostics.background and darken(c.diag.hint, 0.1, c.bg) or c.none,
    },
    DiagnosticVirtualTextInfo      = {
      fg = opts.diagnostics.darker and darken(c.diag.info, 0.85, c.bg) or c.diag.info,
      bg = opts.diagnostics.background and darken(c.diag.info, 0.1, c.bg) or c.none,
    },
    DiagnosticVirtualTextWarn      = {
      fg = opts.diagnostics.darker and darken(c.diag.warn, 0.85, c.bg) or c.diag.warn,
      bg = opts.diagnostics.background and darken(c.diag.warn, 0.1, c.bg) or c.none,
    },
    DiagnosticVirtualTextError     = {
      fg = opts.diagnostics.darker and darken(c.diag.error, 0.85, c.bg) or c.diag.error,
      bg = opts.diagnostics.background and darken(c.diag.error, 0.1, c.bg) or c.none,
    },

    diffAdded                      = "Added",
    diffRemoved                    = "Removed",
    diffChanged                    = "Changed",
    diffFile                       = { fg = c.blue },
    diffLine                       = { fg = c.cyan },
    DiffViewNormal                 = { bg = c.bg_dark },
    DiffviewSignColumn             = { bg = c.bg_dark },
    DiffviewWinSeparator           = { link = "SnacksWinSeparator" },

    Scrollbar                      = { fg = mod(c.bg, 80) },
    ScrollbarThumb                 = { fg = mod(c.bg, 230) },

    -- SnacksPicker                = { bg = c.bg_dark },
    -- SnacksWinSeparator          = { fg = c.bg_dark, bg = c.bg_dark },
    SnacksWinSeparator             = { fg = mod_custom(c.fg_dark3, 60), bg = c.bg },
    -- SnacksWinSeparator             = { fg = mod_custom(c.bg_dark, 40), bg = mod_custom(c.bg_dark, 5) },
    SnacksPickerInputBorder        = { fg = mod_custom(c.fg_dark3, 40), bg = c.bg_dark },
    SnacksPickerBorder             = { fg = c.bg_dark, bg = c.bg_dark },
    SnacksPickerInputTitle         = { fg = c.blue, bg = c.bg_dark },
    SnacksPickerTree               = { fg = mod(c.comment, -50), bg = c.bg_dark },
    SnacksPickerPrompt             = { bg = c.bg_dark },
    SnacksImageMath                = { fg = c.cyan },
    SnacksPickerGitStatusUntracked = { fg = c.fg_dark },
    SnacksBackdrop                 = { bg = c.bg },
    -- SnacksBackdrop_0a0b0c          = { bg = c.bg },
    SnacksPickerMatch              = { link = "CurSearch" },
    SnacksIndentScope              = { fg = mod(c.comment, -20) },
    SnacksIndent                   = { fg = mod(c.comment, -50) },

    RenderMarkdownDash             = { fg = mod(c.fg_dark3, -40), bg = c.bg },
    RenderMarkdownBullet           = { fg = c.peach },
    RenderMarkdownMath             = { fg = c.cyan, bg = c.bg_light },
    RenderMarkdownH1Bg             = { link = "DiagnosticVirtualTextInfo" },
    RenderMarkdownH2Bg             = { link = "DiagnosticVirtualTextWarn" },
    RenderMarkdownH3Bg             = { link = "DiagnosticVirtualTextOk" },
    RenderMarkdownH4Bg             = { link = "DiagnosticVirtualTextError" },
    RenderMarkdownH5Bg             = { link = "DiagnosticVirtualTextHint" },

    BufferLineOffsetSeparator      = { fg = mod_custom(c.fg_dark3, 60), bg = c.bg },
    BufferLineOffsetHelp           = "TerminalNormal",
    BufferLineOffset               = "SidebarNormal",
    BufferLineOffsetExplorer       = { fg = c.fg, bg = c.bg_dark, underline = false, sp = mod_custom(c.fg_dark3, 60) },
    BufferLineFill                 = { bg = mod(c.bg_dark, 0) },
    BufferLineModified             = { fg = mod(c.green, -50), bg = "#131517" },
    BufferLineModifiedVisible      = { fg = mod(c.green, -30), bg = "#17191c", },
    BufferLineModifiedSelected     = { fg = c.green, bg = c.bg },

    FzfLuaNormal                   = "Normal",
    FzfLuaLivePrompt               = { fg = c.fg },
    FzfLuaFzfPrompt                = { fg = c.fg },
    FzfLuaFzfPointer               = { fg = c.blue },
    fzf1                           = { fg = "bg", bg = "bg" },
    fzf2                           = { link = "fzf1" },
    fzf3                           = { link = "fzf1" },
    FzfLuaTitle                    = { link = "fzf1" },
    FzfLuaTitleFlags               = { link = "fzf1" },
    FzfLuaFzfSeparator             = { fg = c.bg },
    FzfLuaBorder                   = { fg = c.comment, bg = c.bg },
    FzfLuaFzfBorder                = { fg = c.comment, bg = c.bg },
    FzfLuaHeaderText               = { fg = c.yellow },
    FzfLuaHeaderBind               = { fg = c.cyan },
    FzfLuaBufFlagCur               = { fg = c.cyan },
    FzfLuaPathLineNr               = { fg = c.fg },
    FzfLuaPathColNr                = { fg = c.fg },
    FzfLuaFzfMatch                 = "PmenuMatch",
    -- FzfLuaFzfScrollbar             = { link = "ScrollbarThumb" },

    TreeSitterContext              = { bg = c.bg, underline = true, sp = c.bg_light3 },
    TreeSitterContextLineNumber    = { bg = c.bg, underline = true, sp = c.bg_light3 },
    -- TreeSitterContext              = { bg = c.bg, underline = true, sp = mod(c.bg_dark, -30) },
    -- TreeSitterContextLineNumber    = { bg = c.bg, underline = true, sp = mod(c.bg_dark, -30) },

    MiniClueDescGroup              = { bg = mod_custom(c.bg_light, -20) },
    MiniClueDescSingle             = { bg = mod_custom(c.bg_light, -20) },
    MiniClueNextKey                = { bg = mod_custom(c.bg_light, -20) },
    MiniClueNextKeyWithPostkeys    = { bg = mod_custom(c.bg_light, -20) },
    MiniClueSeparator              = { fg = c.syn.constant, bg = mod_custom(c.bg_light, -20) },
    MiniFilesBorder                = { fg = c.bg_dark, bg = c.bg_dark },
    MiniFilesTitle                 = { fg = c.comment, bg = c.bg_dark },
    MiniFilesTitleFocused          = { fg = c.cyan, bg = c.bg_dark },
    MiniIndentscopeSymbol          = { fg = mod_custom(c.fg_dark3, 30) },

    ["@variable"]                  = { fg = c.syn.ident },
  }
end

local function treesitter_groups(c)
  return {
    ["@variable"]                   = { fg = c.syn.ident },
    ["@variable.builtin"]           = { fg = c.syn.special },
    ["@variable.parameter"]         = { fg = c.fg },
    ["@variable.parameter.builtin"] = { fg = c.syn.special },
    ["@variable.member"]            = { fg = c.syn.constant },
    ["@variable.member.lua"]        = { fg = c.syn.ident },
    ["@constant"]                   = "Constant",
    ["@constant.builtin"]           = "@constant",
    ["@constant.macro"]             = "Macro",
    ["@module"]                     = { fg = lighten(c.fg, 0.7, c.blue) },
    ["@module.latex"]               = { fg = lighten(c.fg, 0.3, c.cyan) },
    ["@module.builtin"]             = { fg = c.syn.special },
    ["@label"]                      = { fg = c.blue },
    ["@string"]                     = "String",
    ["@string.special.url"]         = { fg = c.cyan, underline = true },
    ["@character"]                  = "String",
    ["@character.special"]          = "SpecialChar",
    ["@boolean"]                    = "Boolean",
    ["@number"]                     = "Number",
    ["@number.float"]               = "Float",
    ["@type"]                       = { fg = c.syn.type },
    ["@type.builtin"]               = { fg = c.syn.literal },
    ["@attribute"]                  = "PreProc",
    ["@property"]                   = { fg = c.syn.ident },
    ["@function"]                   = "Function",
    ["@function.builtin"]           = { fg = c.syn.special },
    ["@function.macro"]             = "Macro",
    ["@constructor"]                = { fg = c.yellow },
    ["@operator"]                   = "Operator",
    ["@keyword"]                    = { fg = c.syn.keyword },
    ["@keyword.coroutine"]          = { fg = c.syn.keyword_mod },
    ["@keyword.function"]           = { fg = c.syn.keyword },
    ["@keyword.modifier"]           = { fg = c.syn.keyword_mod },
    ["@keyword.conditional"]        = "Conditional",
    ["@keyword.directive"]          = { fg = c.syn.keyword_mod },
    ["@keyword.directive.markdown"] = { fg = c.syn.string },
    ["@punctuation.delimiter"]      = { fg = c.syn.delim },
    ["@punctuation.bracket"]        = { fg = c.syn.delim },
    ["@punctuation.special"]        = { fg = c.syn.special },
    ["@punctuation.special.latex"]  = { fg = c.syn.constant },
    ["@comment"]                    = "Comment",
    ["@comment.documentation"]      = { fg = c.comment, italic = true },
    ["@comment.error"]              = { link = "DiagnosticVirtualTextError" },
    ["@comment.warning"]            = { link = "DiagnosticVirtualTextWarn" },
    ["@comment.todo"]               = { link = "DiagnosticVirtualTextHint" },
    ["@comment.note"]               = { link = "DiagnosticVirtualTextHint" },
    ["@markup.strong"]              = { bold = true },
    ["@markup.italic"]              = { italic = true },
    ["@markup.strikethrough"]       = { strikethrough = true },
    ["@markup.underline"]           = { underline = true },
    ["@markup.heading"]             = "Title",
    ["@markup.quote"]               = { fg = c.fg },
    ["@markup.math"]                = { fg = c.cyan },
    ["@markup.link"]                = { fg = c.blue },
    ["@markup.link.label"]          = { fg = c.orange },
    ["@markup.link.url"]            = { underline = true },
    ["@markup.raw"]                 = "String",
    ["@markup.list"]                = "Special",
    ["@markup.list.checked"]        = { fg = saturate(c.yellow, 0.25), bold = true },
    ["@markup.list.unchecked"]      = { fg = c.fg_dark, bold = true },
    ["@diff.plus"]                  = "DiffAdd",
    ["@diff.minus"]                 = "DiffDelete",
    ["@diff.delta"]                 = "DiffChange",
    ["@tag"]                        = "Label",
    ["@tag.builtin"]                = { fg = c.syn.special },
    ["@tag.attribute"]              = "@property",
    ["@tag.delimiter"]              = "Delimiter",
    ["@comment.markdown"]           = { fg = c.comment },
    ["@string.special.url.comment"] = "Comment",
  }
end

local function vim_syntax_groups(c)
  return {
    goPackage = "Keyword",
    goImport = "Keyword",
    goStatement = "Keyword",
    goBuiltins = { fg = c.syn.special },
    goSpecialString = "SpecialChar",
    goVarArgs = { fg = c.syn.special },
    goPackageComment = { fg = c.comment, italic = true },
    goFunctionCall = "Function",

    zigBuiltinFn = "Special",
    zigCommentLineDoc = { fg = c.comment, italic = true },
    zigOperator = "Function",
    zigMacro = "Keyword",
    zigExecution = "Keyword",
    zigVarDecl = "Keyword",

    pythonStatement = "Keyword",
    pythonBuiltin = "Special",
    pythonDecoratorName = { fg = c.syn.special },
    pythonException = "Keyword",
    pythonAsync = "Keyword",
    pythonExceptions = "Type",
    pythonOperator = "Keyword",
    pythonEscape = "Number",

    javascriptBraces = "Normal",
    javascriptStatement = "Keyword",
    javascriptOperator = "Keyword",
    javascriptSpecial = "Number",
    javascriptNull = "Boolean",
    javascriptMessage = "Special",
    javascriptMember = "Special",
    javascriptGlobal = "Special",

    jsonKeyword = "Keyword",
    jsonBoolean = "Boolean",
    jsonEscape = "Number",
    jsonQuote = "Delimiter",
  }
end

local function apply()
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = "darktheme"

  local variant = vim.g.darktheme_variant or "dimmed"

  if variant == "light" then
    if vim.o.background ~= "light" then
      vim.o.background = "light"
    end
  elseif variant == "dark" or variant == "dimmed" then
    if vim.o.background ~= "dark" then
      vim.o.background = "dark"
    end
  end

  local key
  if vim.o.background == "light" then
    key = "light"
  elseif variant == "dimmed" then
    key = "dimmed"
  else
    key = "dark"
  end
  local c = with_subgroups(key)

  local groups = vim.tbl_extend(
    "force",
    neovim_groups(c),
    treesitter_groups(c),
    vim_syntax_groups(c),
    c.highlights
  )

  for name, hl in pairs(groups) do
    if type(hl) == "string" then
      vim.api.nvim_set_hl(0, name, { link = hl })
    else
      vim.api.nvim_set_hl(0, name, hl)
    end
  end

  vim.g.terminal_color_0 = c.terminal.black
  vim.g.terminal_color_8 = c.terminal.bright_black
  vim.g.terminal_color_1 = c.terminal.bright_red
  vim.g.terminal_color_9 = c.terminal.yellow
  vim.g.terminal_color_2 = c.terminal.green
  vim.g.terminal_color_10 = c.terminal.bright_green
  vim.g.terminal_color_3 = c.terminal.yellow
  vim.g.terminal_color_11 = c.terminal.bright_red
  vim.g.terminal_color_4 = c.terminal.blue
  vim.g.terminal_color_12 = c.terminal.bright_blue
  vim.g.terminal_color_5 = c.fg
  vim.g.terminal_color_13 = c.terminal.bright_purple
  vim.g.terminal_color_6 = c.terminal.cyan
  vim.g.terminal_color_14 = c.terminal.bright_cyan
  vim.g.terminal_color_7 = c.terminal.white
  vim.g.terminal_color_15 = c.terminal.bright_white
end

local function refresh_bufferline_highlights()
  local ok_config, config = pcall(require, "bufferline.config")
  local ok_highlights, highlights = pcall(require, "bufferline.highlights")
  if not ok_config or not ok_highlights then
    return
  end

  highlights.reset_icon_hl_cache()
  highlights.set_all(config.update_highlights())
end

apply()

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    if vim.g.colors_name == "darktheme" then
      refresh_bufferline_highlights()
    end
  end,
})

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    if vim.g.colors_name == "darktheme" then
      apply()
      refresh_bufferline_highlights()
    end
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "darktheme",
  callback = function()
    vim.schedule(refresh_bufferline_highlights)
  end,
})

-- vim.opt.number = true
-- vim.opt.statuscolumn = "%s%=%{%v:lua.statuscolumn()%}"
