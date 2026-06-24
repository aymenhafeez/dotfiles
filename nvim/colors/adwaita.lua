local mod = require("utils").modify_colour

local function apply()
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = "adwaita"

  local variant = vim.g.adwaita_variant or "default"
  local is_light = variant == "light" or vim.o.background == "light"

  local c
  if is_light then
    c = {
      bg = "#FFFFFF",
      bg_panel = "#EBEBED",
      bg_elevated = "#F6F5F4",
      bg_line = "#F1EFED",
      fg = "#3D3846",
      fg_dim = "#77767B",
      fg_gutter = "#B0AFAC",
      border = "#C0BFBC",

      red = "#E01B24",
      orange = "#E66100",
      yellow = "#D38B09",
      green = "#2EC27E",
      teal = "#218787",
      blue = "#1C71D8",
      purple = "#813D9C",
      violet = "#4E57BA",
    }
  else
    c = {
      bg = "#1D1D20",
      bg_panel = "#28282C",
      bg_elevated = "#2E2E32",
      bg_line = mod("#1D1D20", 20),
      fg = "#DEDDDA",
      fg_dim = "#9A9996",
      fg_gutter = "#5E5E5E",
      border = "#36363A",

      red = "#ED333B",
      orange = "#FFA348",
      yellow = "#D38B09",
      green = "#57E389",
      teal = "#5BC8AF",
      blue = "#62A0EA",
      purple = "#C061CB",
      violet = "#7D8AC7",

      visual = "#243C5A"
    }
  end

  if variant == "darker" then
    c.bg = "#000000"
    c.bg_panel = "#121212"
    c.bg_elevated = "#1C1C1C"
    c.bg_line = "#222222"
    c.border = "#2A2A2A"
  end

  vim.o.background = is_light and "light" or "dark"

  vim.g.terminal_color_0 = c.bg_panel
  vim.g.terminal_color_1 = c.red
  vim.g.terminal_color_2 = c.green
  vim.g.terminal_color_3 = c.orange
  vim.g.terminal_color_4 = c.blue
  vim.g.terminal_color_5 = c.purple
  vim.g.terminal_color_6 = c.teal
  vim.g.terminal_color_7 = c.fg
  vim.g.terminal_color_8 = c.fg_dim
  vim.g.terminal_color_9 = c.red
  vim.g.terminal_color_10 = c.green
  vim.g.terminal_color_11 = c.yellow
  vim.g.terminal_color_12 = c.blue
  vim.g.terminal_color_13 = c.purple
  vim.g.terminal_color_14 = c.teal
  vim.g.terminal_color_15 = is_light and "#241F31" or "#FFFFFF"

  local highlights = {
    Normal                         = { fg = c.fg, bg = c.bg },
    NormalNC                       = { fg = c.fg, bg = c.bg },
    NormalFloat                    = { fg = c.fg, bg = c.bg_panel },
    TerminalNormal                 = { bg = c.bg_panel },
    SidebarNormal                  = { bg = c.bg_panel },
    FloatBorder                    = { fg = c.border, bg = c.bg_elevated },
    FloatTitle                     = { fg = c.blue, bg = c.bg_elevated, bold = true },

    CursorLine                     = { bg = c.bg_line },
    CursorLineFold                 = { bg = c.bg_line },
    CursorLineSign                 = { bg = c.bg_line },
    CursorLineNr                   = { fg = c.fg_dim, bg = c.bg_line, bold = true },
    CursorColumn                   = { link = "CursorLine" },
    ColorColumn                    = { link = "CursorLine" },
    LineNr                         = { fg = c.fg_gutter },
    SignColumn                     = { fg = c.fg_gutter, bg = c.bg },
    FoldColumn                     = { fg = c.fg_dim, bg = c.bg },

    WinSeparator                   = { fg = c.bg_panel, bg = c.bg },
    StatusLine                     = { fg = c.fg_dim, bg = c.bg_panel },
    StatusLineNC                   = { fg = c.fg_gutter, bg = c.bg_panel },
    TabLine                        = { fg = c.fg_dim, bg = c.bg },
    TabLineFill                    = { bg = c.bg },
    TabLineSel                     = { fg = c.fg, bg = c.bg, bold = true },

    Pmenu                          = { fg = c.fg, bg = c.bg_elevated },
    PmenuSel                       = { fg = c.fg, bg = c.bg_line, bold = true },
    PmenuSbar                      = { bg = c.bg_panel },
    PmenuThumb                     = { bg = c.fg_gutter },

    Search                         = { fg = c.fg, bg = c.visual },
    IncSearch                      = { fg = c.bg, bg = c.yellow, bold = true },
    CurSearch                      = { link = "IncSearch" },
    Visual                         = { bg = c.visual },
    VisualNOS                      = { link = "Visual" },
    VisualNonText                  = { fg = c.fg_gutter, bg = c.visual },
    MatchParen                     = { fg = c.yellow, bold = true },

    NonText                        = { fg = c.fg_gutter },
    EndOfBuffer                    = { fg = c.bg },
    Whitespace                     = { fg = c.border },
    SpecialKey                     = { fg = c.fg_dim },
    Directory                      = { fg = c.blue },
    Title                          = { fg = c.blue, bold = true },

    Error                          = { fg = c.red },
    ErrorMsg                       = { fg = c.red, bold = true },
    WarningMsg                     = { fg = c.yellow, bold = true },
    MoreMsg                        = { fg = c.teal },
    Question                       = { fg = c.teal },

    Comment                        = { fg = c.fg_dim, italic = true },
    Constant                       = { fg = c.violet },
    String                         = { fg = c.teal },
    Character                      = { fg = c.teal },
    Number                         = { fg = c.violet },
    Boolean                        = { fg = c.purple, bold = true },
    Float                          = { fg = c.violet },
    Identifier                     = { fg = c.orange },
    Function                       = { fg = c.blue },
    Statement                      = { fg = c.orange, bold = true },
    Conditional                    = { fg = c.orange, bold = true },
    Repeat                         = { fg = c.orange, bold = true },
    Keyword                        = { fg = c.orange, bold = true },
    Operator                       = { fg = c.purple },
    Type                           = { fg = c.teal, bold = true },
    Special                        = { fg = c.blue },
    Delimiter                      = { fg = c.fg_dim },
    Underlined                     = { fg = c.blue, underline = true },
    Todo                           = { fg = c.yellow, bold = true },

    DiffAdd                        = { fg = c.green, bg = c.bg },
    DiffChange                     = { fg = c.orange, bg = c.bg },
    DiffDelete                     = { fg = c.red, bg = c.bg },
    DiffText                       = { fg = c.blue, bg = c.bg_line },

    DiagnosticError                = { fg = c.red },
    DiagnosticWarn                 = { fg = c.yellow },
    DiagnosticInfo                 = { fg = c.blue },
    DiagnosticHint                 = { fg = c.teal },
    DiagnosticUnderlineError       = { sp = c.red, undercurl = true },
    DiagnosticUnderlineWarn        = { sp = c.yellow, undercurl = true },
    DiagnosticUnderlineInfo        = { sp = c.blue, undercurl = true },
    DiagnosticUnderlineHint        = { sp = c.teal, undercurl = true },
    LspReferenceText               = { bg = c.bg_line },
    LspReferenceRead               = { bg = c.bg_line },
    LspReferenceWrite              = { bg = c.bg_line },

    Scrollbar                      = { fg = c.fg_gutter },
    ScrollbarThumb                 = { fg = c.fg_dim },

    TreeSitterContext              = { bg = c.bg, underline = true, sp = c.border },
    TreeSitterContextLineNumber    = { bg = c.bg, underline = true, sp = c.border },

    FzfLuaFzfSeparator             = { fg = c.bg },

    MiniIndentScopeSymbol          = { fg = c.bg_panel },

    -- SnacksPicker                = { bg = c.bg_panel },
    SnacksWinSeparator             = { fg = c.bg_panel, bg = c.bg_panel },
    -- SnacksWinSeparator             = { fg = mod(c.fg_dim, -60), bg = c.bg },
    -- SnacksWinSeparator             = { link = "WinSeparator" },
    SnacksPickerInputBorder        = { fg = mod(c.fg_dim, -40), bg = c.bg_panel },
    SnacksPickerBorder             = { fg = c.bg_panel, bg = c.bg_panel },
    SnacksPickerInputTitle         = { fg = c.blue, bg = c.bg_panel },
    SnacksPickerTree               = { fg = c.fg_gutter, bg = c.bg_panel },
    SnacksPickerPrompt             = { bg = c.bg_panel },
    SnacksPickerGitStatusUntracked = { fg = c.fg_dim },
    SnacksBackdrop                 = { bg = c.bg },
    -- SnacksBackdrop_0a0b0c          = { bg = c.bg },
    SnacksPickerMatch              = { link = "CurSearch" },

    SnacksIndentScope              = { fg = mod(c.fg_dim, -20) },
    SnacksIndent                   = { fg = mod(c.fg_dim, -50) },

    -- BufferLineOffsetSeparator      = { fg = c.border, bg = c.bg },
    -- BufferLineOffsetSeparator      = { link = "WinSeparator" },
    BufferLineOffsetSeparator      = { fg = c.bg_panel, bg = c.bg_panel },
    BufferLineOffsetHelp           = { link = "TerminalNormal" },
    BufferLineOffset               = { link = "SidebarNormal" },
    BufferLineOffsetExplorer       = { fg = c.fg, bg = c.bg_panel },
    BufferLineFill                 = { bg = c.bg_panel },
    BufferLineModified             = { fg = mod(c.blue, -50), bg = "#151518" },
    BufferLineModifiedVisible      = { fg = mod(c.blue, -30), bg = "#1a1a1d" },
    BufferLineModifiedSelected     = { fg = c.blue, bg = "#1d1d20" },

    ["@comment"]                   = { link = "Comment" },
    ["@string"]                    = { link = "String" },
    ["@number"]                    = { link = "Number" },
    ["@boolean"]                   = { link = "Boolean" },
    ["@constant"]                  = { link = "Constant" },
    ["@variable"]                  = { fg = c.fg },
    ["@variable.builtin"]          = { fg = c.purple, bold = true },
    ["@function"]                  = { link = "Function" },
    ["@function.builtin"]          = { link = "Function" },
    ["@keyword"]                   = { link = "Keyword" },
    ["@type"]                      = { link = "Type" },
    ["@operator"]                  = { link = "Operator" },
    ["@tag"]                       = { fg = c.teal },
    ["@tag.attribute"]             = { fg = c.orange },
    ["@tag.delimiter"]             = { link = "Delimiter" },
  }

  for group, spec in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, spec)
  end
end

apply()

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    if vim.g.colors_name == "adwaita" then
      apply()
    end
  end,
})
