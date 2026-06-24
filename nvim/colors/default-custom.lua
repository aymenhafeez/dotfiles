local mod = require("utils").modify_colour

local function apply()
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  vim.o.termguicolors     = true
  vim.g.colors_name       = "default-custom"

  -- local bg                = "#14161b"
  -- local bg                = "#131517"
  local bg                = "#141618"
  -- local bg                = "#1a1c1f"
  -- local bg                = "#0e0f13"
  local bg_dark           = mod(bg, -20)
  local fg                = "#dddddd"
  local subtle_fg         = "#a9aaac"
  -- local accent            = "#1c1f26"
  local accent            = mod(bg, 40)
  local subtle            = mod(bg, 100)
  local blue              = "NvimLightBlue"
  -- local cyan              = "LightSeaGreen"
  -- local cyan              = "NvimLightCyan"
  local cyan              = "#70d8c7"
  -- local magenta           = "#ab99ba"
  local magenta           = "#D4A3CE"
  -- local magenta           = "#b19db8"
  -- local magenta           = "NvimLightMagenta"
  -- local green             = "#96C186"
  -- local green             = "NvimLightGreen"
  -- local green             = "#B5CEA9"
  local green             = "#b3f6c0"
  -- local yellow            = "#dfdf8e"
  local yellow            = "NvimLightYellow"
  local red               = "NvimLightRed"
  local orange            = "#CF8E6D"
  -- local orange            = "#D1835A"
  -- local orange            = "Coral"
  -- local muted             = "#aaaaaa"
  local muted             = "#8A8A8A"
  local muted_fg          = "NvimLightGrey4"
  -- local pmenu             = vim.o.winborder == "rounded" and { bg = bg } or { bg = mod("#282c36", 20) }
  local pmenu             = vim.o.winborder == "rounded" and { bg = bg } or { bg = "NvimDarkGrey3" }
  local float             = vim.o.winborder == "rounded" and { bg = bg } or { bg = mod(bg, -40) }
  local border            = vim.o.winborder == "none" and { fg = mod(subtle_fg, -30), bg = mod(accent, 20) } or
      { fg = mod(subtle_fg, -20) }
  -- TODO:
  local bg_red_subtle     = "#753943"
  local bg_yellow_intense = "#6C5340"
  local bg_blue_subtle    = "#80aaff"
  local bg_cyan_subtle    = "#2E5D6B"
  local bg_green_subtle   = "#00422a"
  local warning_red       = "#ff4242"
  local keyword_orange    = "#ffad29"
  local function_cyan     = "Cyan"
  local type_blue         = "#34cae2"
  local diff_add_bg       = "#41525a"
  local diff_change_bg    = "#585249"
  local diff_delete_bg    = "#4f434a"
  local diff_text_bg      = "#373f48"

  vim.g.terminal_color_0  = bg
  vim.g.terminal_color_1  = yellow
  vim.g.terminal_color_2  = yellow
  vim.g.terminal_color_3  = yellow
  vim.g.terminal_color_4  = blue
  vim.g.terminal_color_5  = fg
  vim.g.terminal_color_6  = green
  vim.g.terminal_color_7  = fg
  vim.g.terminal_color_8  = subtle_fg
  vim.g.terminal_color_9  = green
  vim.g.terminal_color_10 = subtle_fg
  vim.g.terminal_color_11 = yellow
  vim.g.terminal_color_12 = blue
  vim.g.terminal_color_13 = fg
  vim.g.terminal_color_14 = blue
  vim.g.terminal_color_15 = blue

  local highlights        = {
    Normal                         = { fg = fg, bg = bg },
    -- TerminalNormal                 = { bg = bg_dark },
    Pmenu                          = pmenu,
    -- Pmenu                       = { bg = bg },
    PmenuSel                       = { fg = bg, bg = fg },
    PmenuMatch                     = { fg = "White", bold = true },
    PmenuMatchSel                  = { fg = "Black", bg = fg, bold = true },
    PmenuBorder                    = border,
    PmenuSBar                      = { bg = accent },
    NormalFloat                    = vim.o.winborder == "rounded" and { bg = bg } or { bg = bg_dark },
    Visual                         = { bg = "NvimDarkGrey4" },
    VisualNonText                  = { fg = muted_fg, bg = "NvimDarkGrey4" },
    String                         = { fg = green },
    -- String                         = { fg = orange },
    -- SidebarNormal                  = { bg = bg_dark },
    -- NormalFloat                 = { bg = bg },
    LineNr                         = { fg = fg, bg = accent },
    CursorlineNr                   = { fg = fg, bg = accent, bold = true },
    CursorlineFold                 = { fg = fg, bg = bg, bold = true },
    Cursorline                     = { bg = mod(bg, 20) },
    FloatBorder                    = border,
    WinSeparator                   = { fg = subtle, bg = accent },
    -- WinSeparator                   = { fg = "NvimDarkGrey4" },
    EndOfBuffer                    = { fg = bg },
    Comment                        = { fg = muted_fg, italic = true },
    Todo                           = { fg = "Cyan", bg = bg_blue_subtle, bold = true },
    -- Statusline                     = { fg = fg, bg = mod(subtle, 20) },
    -- StatuslineNC                   = { fg = subtle_fg, bg = mod(subtle, 20) },
    -- Statusline                     = { fg = subtle_fg, bg = bg_dark },
    -- StatuslineNC                   = { fg = mod(subtle_fg, -30), bg = bg_dark },
    -- StatuslineNC                   = { fg = mod(fg, -10), bg = "NvimDarkGrey4" },
    -- Statusline                     = { fg = bg, bg = muted, bold = true },
    -- StatuslineNC                   = { fg = mod(bg, 50), bg = muted },
    -- SignColumn                     = { bg = accent },
    Folded                         = { bg = mod(subtle, 0) },
    ColorColumn                    = { bg = accent },
    -- TablineFill                    = { bg = bg_dark },
    -- TablineSel                     = { fg = fg, bg = bg, bold = true, italic = false },
    -- Tabline                        = { fg = muted_fg, bg = bg_dark },
    -- Number                         = { fg = "LightSeaGreen" },
    Number                         = { fg = orange },
    -- Number                         = { fg = green },
    Boolean                        = { fg = magenta },
    Function                       = { fg = blue },
    Special                        = { fg = "NvimLightCyan" },
    Include                        = { fg = magenta },
    -- PreProc                        = { fg = "LemonChiffon" },
    Constructor                    = { fg = blue },
    TreesitterContext              = { bg = bg, underline = true, sp = mod(subtle, 20) },
    TreesitterContextLineNumber    = { fg = fg, bg = bg, bold = true, underline = true, sp = mod(subtle, 20) },
    ModeMsg                        = { link = "Normal" },
    Keyword                        = { fg = magenta },
    -- Keyword                        = { fg = "NvimLightMagenta" },
    Constant                       = { fg = orange },
    Conceal                        = { fg = "LemonChiffon" },
    Directory                      = { fg = blue },
    SpellBad                       = { undercurl = true, sp = red },
    SpellCap                       = { undercurl = true, sp = yellow },
    SpellLocal                     = { undercurl = true, sp = yellow },
    SpellRare                      = { undercurl = true, sp = yellow },
    -- Operator                       = { fg = magenta },
    Type                           = { fg = cyan },
    -- Type                           = { fg = "LemonChiffon" },
    -- Type                           = { fg = "White", bold = true },

    User5                          = { fg = fg, bold = true },
    User6                          = { fg = fg },
    User9                          = { fg = green },

    FzfLuaNormal                   = { bg = bg },
    FzfLuaLivePrompt               = { fg = "fg" },
    FzfLuaFzfPrompt                = { fg = "fg" },
    FzfLuaFzfPointer               = { fg = "fg" },
    FzfLuaBorder                   = { link = "FloatBorder" },
    fzf1                           = { fg = fg },
    fzf2                           = { link = "fzf1" },
    fzf3                           = { link = "fzf1" },
    -- FzfLuaTitle                    = { link = "fzf1" },
    -- FzfLuaTitleFlags               = { link = "fzf1" },
    FzfLuaFzfSeparator             = { fg = bg },
    FzfLuaFzfMatch                 = { fg = "White", bold = true },
    FzfLuaBufLineNr                = { bg = bg },

    SnacksPicker                   = { bg = bg_dark },
    -- SnacksWinSeparator          = { fg = "NvimDarkGrey1", bg = mod(bg,-40)},
    SnacksPickerInputBorder        = { fg = muted_fg, bg = bg_dark },
    SnacksPickerBorder             = { fg = bg_dark, bg = bg_dark },
    SnacksPickerInputTitle         = { fg = blue, bg = bg_dark },
    SnacksPickerGitStatusUntracked = { fg = muted_fg },
    SnacksPickerTree               = { fg = mod(fg, -70), bg = bg_dark },
    SnacksPickerPrompt             = { link = "SnacksPicker" },
    SnacksImageMath                = { fg = "#ffffff" },
    SnacksIndent                   = { fg = mod(fg, -70) },
    SnacksIndentScope              = { fg = mod(fg, -50) },

    BufferLineOffsetHelp           = { bg = bg_dark },
    BufferLineOffset               = { bg = bg },
    BufferLineIndicatorSelected    = { fg = cyan, bg = bg },
    BufferLineIndicatorVisible     = { fg = bg, bg = bg },
    BufferLineOffsetSeparator      = { fg = subtle, bg = accent },
    BufferLineFill                 = { link = "TablineFill" },
    BufferLineTabSelected          = { link = "TablineSel" },
    BufferLineModified             = { fg = mod(fg, -50), bg = "#0f1014" },
    BufferLineModifiedVisible      = { fg = mod(fg, -30), bg = "#121418", },
    BufferLineModifiedSelected     = { fg = fg, bg = bg },

    MiniFilesNormal                = { bg = bg },
    MiniFilesBorder                = { fg = subtle_fg, bg = bg },
    MiniIndentscopeSymbol          = { fg = "NvimDarkGrey4" },
    MiniClueDescGroup              = vim.o.winborder == "rounded" and { bg = bg } or { bg = bg_dark },
    MiniClueDescSingle             = vim.o.winborder == "rounded" and { bg = bg } or { bg = bg_dark },
    MiniClueNextKey                = vim.o.winborder == "rounded" and { bg = bg } or { bg = bg_dark },
    MiniClueNextKeyWithPostkeys    = vim.o.winborder == "rounded" and { bg = bg } or { bg = bg_dark },
    MiniClueSeparator              = vim.o.winborder == "rounded" and { fg = blue, bg = bg } or
        { fg = blue, bg = bg_dark },
    MiniClueBorder                 = vim.o.winborder == "rounded" and { bg = bg } or { bg = bg_dark },

    RenderMarkdownDash             = { fg = subtle },

    DiagnosticUnderlineOk          = { sp = green, undercurl = true },
    DiagnosticUnderlineWarn        = { sp = yellow, undercurl = true },
    DiagnosticUnderlineError       = { sp = red, undercurl = true },
    DiagnosticUnderlineInfo        = { sp = blue, undercurl = true },
    DiagnosticUnderlineHint        = { sp = blue, undercurl = true },
    DiagnosticDeprecated           = { sp = red, strikethrough = true },

    -- DiagnosticVirtualTextError     = { fg = red, bg = bg_red_subtle, italic = true },
    -- DiagnosticVirtualTextWarn      = { fg = keyword_orange, bg = bg_yellow_intense, italic = true },
    -- DiagnosticVirtualTextInfo      = { fg = "Cyan", bg = bg_blue_subtle, italic = true },
    -- DiagnosticVirtualTextHint      = { fg = type_blue, bg = bg_cyan_subtle, italic = true },
    -- DiagnosticVirtualTextOk        = { fg = green, bg = bg_green_subtle, italic = true },

    -- Scrollbar                      = { fg = accent, bg = mod(accent, -15) },
    Scrollbar                      = { fg = bg, bg = bg },
    ScrollbarThumb                 = { fg = subtle, bg = subtle },
    -- ScrollbarBorder                = { fg = accent, bg = bg },
    Delimiter                      = { fg = "LightYellow" },

    DiffAdd                        = { bg = diff_add_bg },
    DiffChange                     = { bg = diff_change_bg },
    DiffDelete                     = { fg = diff_delete_bg, bg = diff_delete_bg },
    DiffText                       = { bg = diff_text_bg },

    NeogitActiveItem               = { bg = diff_add_bg },
    NeogitCommitViewHeader         = { bg = diff_text_bg },
    NeogitHunkHeaderCursor         = { bg = "NvimLightGrey3" },
    NeogitHunkHeaderHighlight      = { bg = "NvimLightGrey3" },
    NeogitGraphPurple              = { fg = cyan },

    GitSignsCurrentLineBlame       = { fg = muted_fg },

    DiffviewNormal                 = { link = "NormalFloat" },

    ["@punctuation.delimiter"]     = { link = "Delimiter" },
    -- ["@punctuation.bracket"]       = { fg = "#FFD700" },
    ["@punctuation.special"]       = { fg = "LemonChiffon" },


    ["@function"]                   = { fg = "LemonChiffon" },
    ["@function.builtin"]           = { fg = "LemonChiffon" },
    ["@keyword.function"]           = { fg = blue, bold = true },
    ["@keyword.type"]               = { fg = blue, bold = true },
    -- ["@keyword.return"]             = { fg = yellow, bold = false },
    ["@keyword.directive.markdown"] = { fg = blue },
    -- ["@module.builtin"]             = { fg = yellow },
    ["@variable.builtin.python"]    = { fg = blue },
    ["@variable.member"]            = { fg = blue },
    -- ["@variable.member.lua"]        = { fg = fg },
    ["@variable.parameter"]         = { fg = "NvimLightBlue" },
    -- ["@variable.parameter"]         = { fg = "LemonChiffon" },
    ["@constructor"]                = { fg = blue },

    ["@markup.link"]                = { fg = blue, underline = true },
    ["@markup.heading.1"]           = { fg = blue, bold = true },
    ["@markup.heading.2"]           = { fg = blue, bold = true },
    ["@markup.heading.3"]           = { fg = "LemonChiffon", bold = true },
    ["@markup.heading.4"]           = { fg = keyword_orange, bold = true },
    ["@markup.heading.5"]           = { fg = cyan, bold = true },
    ["@markup.heading.6"]           = { fg = blue, bold = true },
    ["@markup.raw.markdown_inline"] = { fg = blue, bg = "NvimDarkGrey3" },
    ["@markup.math.latex"]          = { fg = subtle_fg },

    ["@comment.todo"]               = { link = "Todo" },
    ["@comment.warning"]            = { fg = keyword_orange, bg = bg_yellow_intense, bold = true },
    ["@comment.error"]              = { fg = red, bg = bg_red_subtle, bold = true },
    ["@comment.note"]               = { fg = green, bg = bg_green_subtle, bold = true },

    -- ["@comment.todo"]               = { link = "Todo" },
    -- ["@comment.warning"]            = { link = "DiagnosticVirtualTextWarn" },
    -- ["@comment.error"]              = { link = "DiagnosticVirtualTextError" },
    -- ["@comment.note"]               = { link = "DiagnosticVirtualTextOk" },

    Bold                            = { bold = true },
    Italic                          = { italic = true },
    Underlined                      = { underline = true },

    texCmdEnv                       = { fg = blue },
    texcmdPackage                   = { fg = magenta },
    texCmdPart                      = { link = "Keyword" },
    texPartArgTitle                 = { fg = yellow },
    texTCBZone                      = { fg = green },
    texFileOpt                      = { fg = magenta },
    texMathGroup                    = { fg = blue },
    texMathArg                      = { fg = blue },
    texMathZoneLD                   = { fg = blue },
    texMathZoneLI                   = { fg = blue },
    texMathSuper                    = { fg = blue },
    texMathSub                      = { fg = blue },
    texDocZone                      = { fg = fg },
    texBeginEndName                 = { fg = fg },
    texSection                      = { fg = orange },
    texOnlyMath                     = { fg = fg, bg = bg },
    ["@label.latex"]                = { fg = blue },
    -- ["@punctuation.special.latex"]  = { fg = mod("#dfdf8e", 30) },
  }

  for hl_group, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, hl_group, opts)
  end
end

apply()

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    if vim.g.colors_name == "default-custom" then
      apply()
    end
  end,
})
