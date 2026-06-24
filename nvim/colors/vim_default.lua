local mod = require("utils").modify_colour

local function apply()
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  vim.o.termguicolors     = true
  vim.g.colors_name       = "vim_default"

  -- local bg                = "#14161b"
  -- local bg                = mod("#131517", 0)
  -- local bg                = "#1D1D20"
  -- local bg                = "#0e0f13"
  -- local bg                = mod("#1c1e1f", -30)
  local bg                = "#141618"
  local bg_dark           = mod(bg, -20)
  local fg                = "#bbbbbb"
  local fg_light          = "#eeeeee"
  local subtle_fg         = "#a9aaac"
  local accent            = mod(bg, 40)
  local subtle            = mod(bg, 100)
  local blue              = "#72c7c5"
  local cyan              = "#1abc9c"
  local magenta           = "#B48EAD"
  local green             = "#1cdc9a"
  local yellow            = "#EBCB8B"
  -- local yellow            = "#fdbc4b"
  local red               = "NvimLightRed"
  local orange            = "#CF8E6D"
  local muted             = "#8A8A8A"
  local muted_fg          = "NvimLightGrey4"
  local pmenu             = vim.o.winborder == "rounded" and { bg = bg } or { bg = mod(bg, 50) }
  local float             = vim.o.winborder == "rounded" and { bg = bg } or { bg = mod(bg, -40) }
  local border            = vim.o.winborder == "none" and { fg = mod(subtle_fg, -30), bg = mod(accent, 20) } or
      { fg = mod(subtle_fg, -20) }
  local bg_red_subtle     = "#312426"
  local bg_yellow_intense = "#2f2a22"
  local bg_blue_subtle    = "#252b35"
  local bg_cyan_subtle    = "#232e31"
  local bg_green_subtle   = "#212e27"
  local warning_red       = "#ff6c6b"
  local warning_yellow    = "#ecbe7b"
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
    -- Pmenu                          = pmenu,
    -- Pmenu                       = { bg = bg },
    PmenuSel                       = { fg = bg, bg = fg },
    PmenuMatch                     = { fg = fg_light, bold = true },
    PmenuMatchSel                  = { fg = "Black", bg = fg, bold = true },
    PmenuBorder                    = border,
    PmenuSBar                      = { bg = accent },
    NormalFloat                    = vim.o.winborder == "rounded" and { bg = bg } or { bg = mod(bg_dark, -10) },
    Visual                         = { bg = "NvimDarkGrey4" },
    VisualNonText                  = { fg = "#777777", bg = "NvimDarkGrey4" },
    -- String                         = { fg = green },
    String                         = { fg = magenta },
    -- String                         = { fg = orange },
    -- SidebarNormal                  = { bg = bg_dark },
    LineNr                         = { fg = mod(fg, -40), bg = bg },
    CursorlineNr                   = { fg = fg, bg = mod(bg, 30), bold = true },
    CursorlineFold                 = { fg = fg, bg = mod(bg, 30), bold = true },
    CursorlineSign                 = { bg = mod(bg, 30), bold = true },
    Cursorline                     = { bg = mod(bg, 30) },
    TermCursor                     = { bg = fg, reverse = false },
    FloatBorder                    = border,
    -- WinSeparator                   = { fg = mod(subtle, -10), bg = mod(bg, 30) },
    WinSeparator                   = { fg = "NvimDarkGrey4" },
    EndOfBuffer                    = { fg = bg },
    Comment                        = { fg = muted_fg, italic = true },
    Todo                           = { fg = "Cyan", bg = bg_blue_subtle, bold = true },
    -- Statusline                     = { fg = fg, bg = mod(bg, 150) },
    -- StatuslineNC                   = { fg = fg, bg = mod(bg, 70) },
    -- Statusline                     = { fg = fg, bg = mod(subtle, 20) },
    -- StatuslineNC                   = { fg = subtle_fg, bg = mod(subtle, 20) },
    -- Statusline                     = { fg = subtle_fg, bg = bg_dark },
    -- StatuslineNC                   = { fg = mod(subtle_fg, -30), bg = bg_dark },
    -- StatuslineNC                   = { fg = mod(fg, -10), bg = "NvimDarkGrey4" },
    -- Statusline                     = { fg = bg, bg = mod(muted, 30) },
    -- StatuslineNC                   = { fg = mod(bg, 50), bg = mod(muted, 30) },
    -- SignColumn                     = { bg = accent },
    Folded                         = { bg = mod(subtle, 0) },
    ColorColumn                    = { bg = accent },
    TablineFill                    = { bg = mod(bg, 30) },
    -- TablineFill                    = { bg = bg },
    TablineSel                     = { fg = fg, bold = true, italic = false },
    Tabline                        = { fg = muted_fg, bg = mod(bg, 30) },
    -- Number                         = { fg = "LightSeaGreen" },
    Number                         = { fg = orange },
    -- Number                         = { fg = green },
    Boolean                        = { fg = magenta },
    Function                       = { fg = blue },
    -- Special                        = { fg = "NvimLightCyan" },
    Special                        = { fg = cyan },
    -- Identifier                     = { fg = green },
    Include                        = { fg = magenta },
    PreProc                        = { fg = "White" },
    Constructor                    = { fg = blue },
    TreesitterContext              = { fg = fg, bg = bg, bold = true, underline = false, sp = "NvimDarkGrey4" },
    TreesitterContextLineNumber    = { fg = fg, bg = bg, bold = true, underline = false, sp = "NvimDarkGrey4" },
    TreesitterContextSeparator     = { fg = "NvimDarkGrey4" },
    ModeMsg                        = { link = "Normal" },
    Cursearch                      = { reverse = true },
    -- Keyword                        = { fg = magenta },
    Keyword                        = { fg = yellow },
    Constant                       = { fg = orange },
    Conceal                        = { fg = "LemonChiffon" },
    Directory                      = { fg = blue },
    SpellBad                       = { undercurl = true, sp = red },
    SpellCap                       = { undercurl = true, sp = yellow },
    SpellLocal                     = { undercurl = true, sp = yellow },
    SpellRare                      = { undercurl = true, sp = yellow },
    -- Operator                       = { fg = magenta },
    Type                           = { fg = green },
    -- Type                           = { fg = "LemonChiffon" },
    -- Type                           = { fg = "White", bold = true },

    User5                          = { fg = fg, bold = true },
    User6                          = { fg = fg },
    User9                          = { fg = green },

    FzfLuaNormal                   = { bg = bg },
    FzfLuaLivePrompt               = { fg = "fg" },
    FzfLuaFzfPrompt                = { fg = "fg" },
    FzfLuaFzfPointer               = { fg = blue },
    FzfLuaBorder                   = { link = "FloatBorder" },
    FzfLuaHeaderText               = { fg = fg },
    FzfLuaBufNr                    = { fg = fg },
    FzfLuaHeaderBind               = { fg = fg },
    fzf1                           = { fg = fg },
    fzf2                           = { link = "fzf1" },
    fzf3                           = { link = "fzf1" },
    -- FzfLuaTitle                    = { link = "fzf1" },
    -- FzfLuaTitleFlags               = { link = "fzf1" },
    FzfLuaFzfSeparator             = { fg = bg },
    FzfLuaFzfMatch                 = { fg = fg_light, bold = true },
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
    SnacksIndentScope              = { fg = mod(fg, -60) },

    BufferLineOffsetHelp           = { bg = bg_dark },
    BufferLineOffset               = { bg = bg },
    BufferLineOffsetSeparator      = { fg = "NvimDarkGrey4", bg = bg },
    BufferLineOffsetExplorer       = { bg = bg_dark },
    BufferLineIndicatorSelected    = { fg = cyan, bg = bg },
    BufferLineIndicatorVisible     = { fg = bg, bg = bg },
    -- BufferLineBuffer               = { fg = muted, bg = bg },
    -- BufferLineBufferVisible        = { fg = muted, bg = bg },
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

    MinibufferSelection            = { link = "PmenuSel" },

    RenderMarkdownDash             = { fg = subtle },

    DiagnosticUnderlineOk          = { sp = green, undercurl = true },
    DiagnosticUnderlineWarn        = { sp = yellow, undercurl = true },
    DiagnosticUnderlineError       = { sp = red, undercurl = true },
    DiagnosticUnderlineInfo        = { sp = blue, undercurl = true },
    DiagnosticUnderlineHint        = { sp = blue, undercurl = true },
    DiagnosticDeprecated           = { sp = red, strikethrough = true },

    DiagnosticVirtualTextError     = { fg = warning_red, bg = bg_red_subtle },
    DiagnosticVirtualTextWarn      = { fg = warning_yellow, bg = bg_yellow_intense },
    DiagnosticVirtualTextInfo      = { fg = "Cyan", bg = bg_blue_subtle },
    DiagnosticVirtualTextHint      = { fg = type_blue, bg = bg_cyan_subtle },
    DiagnosticVirtualTextOk        = { fg = green, bg = bg_green_subtle },

    -- Scrollbar                      = { fg = accent, bg = mod(accent, -15) },
    Scrollbar                      = { fg = mod(bg, 70), bg = mod(bg, 70) },
    ScrollbarThumb                 = { fg = subtle, bg = subtle },
    -- ScrollbarBorder                = { fg = accent, bg = bg },
    -- Delimiter                      = { fg = "LightYellow" },

    DiffAdd                        = { bg = diff_add_bg },
    DiffChange                     = { bg = diff_change_bg },
    DiffDelete                     = { fg = diff_delete_bg, bg = diff_delete_bg },
    DiffText                       = { bg = diff_text_bg },

    NeogitActiveItem               = { bg = diff_add_bg },
    NeogitCommitViewHeader         = { bg = diff_text_bg },
    NeogitHunkHeaderCursor         = { bg = "NvimLightGrey3" },
    NeogitHunkHeaderHighlight      = { bg = "NvimLightGrey3" },
    NeogitGraphPurple              = { fg = cyan },
    NeogitDiffAddInline            = { reverse = true },

    GitSignsCurrentLineBlame       = { fg = muted_fg },

    DiffviewNormal                 = { bg = bg_dark },

    ["@punctuation.delimiter"]     = { link = "Delimiter" },
    -- ["@punctuation.bracket"]       = { fg = "#FFD700" },
    ["@punctuation.special"]       = { fg = "LemonChiffon" },


    ["@function"]                   = { fg = cyan, bold = true },
    ["@function.builtin"]           = { fg = blue },
    ["@function.call"]              = { fg = blue },
    ["@function.method.call"]       = { fg = blue },
    -- ["@keyword.function"]           = { fg = blue, bold = true },
    ["@keyword.type"]               = { fg = yellow, bold = true },
    ["@keyword.import"]             = { fg = yellow, bold = true },
    -- ["@keyword.return"]             = { fg = yellow, bold = false },
    ["@keyword.directive.markdown"] = { fg = blue },
    -- ["@module.builtin"]             = { fg = yellow },
    ["@module"]                     = { fg = "NvimLightCyan" },
    ["@variable"]                   = { fg = fg_light },
    ["@variable.builtin.python"]    = { fg = "White", bold = true },
    ["@variable.member"]            = { fg = "NvimLightCyan" },
    ["@variable.member.lua"]        = { fg = fg },
    ["@variable.parameter"]         = { fg = "NvimLightBlue" },
    -- ["@variable.parameter"]         = { fg = "LemonChiffon" },
    ["@constructor"]                = { fg = green },
    ["@type.builtin"]               = { fg = blue },
    ["@property"]                   = {},
    ["@property.css"]               = { fg = green },

    ["@markup.link"]                = { fg = blue, underline = true },
    ["@markup.heading.1"]           = { fg = blue, bold = true },
    ["@markup.heading.2"]           = { fg = blue, bold = true },
    ["@markup.heading.3"]           = { fg = "LemonChiffon", bold = true },
    ["@markup.heading.4"]           = { fg = "#EBCB8B", bold = true },
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
    if vim.g.colors_name == "vim_default" then
      refresh_bufferline_highlights()
    end
  end,
})

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    if vim.g.colors_name == "vim_default" then
      apply()
      refresh_bufferline_highlights()
    end
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "vim_default",
  callback = function()
    vim.schedule(refresh_bufferline_highlights)
  end,
})
