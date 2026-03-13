local mod      = require("utils").modify_colour

local is_light = vim.o.background == "light"

local function mod_custom(hex, pcnt)
  return is_light and mod(hex, pcnt) or mod(hex, -pcnt)
end

local function apply()
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  vim.o.termguicolors     = true
  vim.g.colors_name       = "default-custom"

  local dark_bg           = "#14161b"
  local dark_fg           = "#dddddd"
  local dark_subtle_fg    = "#a9aaac"
  local dark_accent       = "#1c1f26"
  local dark_subtle       = mod(dark_bg, 90)
  -- local dark_blue         = "#A6DBFF" -- NvimLightBlue
  local dark_blue         = "#71ade7"
  local dark_magenta      = "#c3c3d5"
  local dark_green        = "#96C186"
  local dark_yellow       = "#dfdf8e"
  -- local dark_yellow       = "NvimLightYellow"
  local dark_red          = "#FFC0B9" -- NvimLightRed
  local dark_pale_blue    = mod(dark_blue, 30)
  local dark_rust         = "#CF8E6D"

  local light_bg          = "#ffffff"
  local light_fg          = "#14161B"
  local light_subtle_fg   = mod(light_fg, 50)
  local light_accent      = mod(light_bg, -10)
  local light_subtle      = mod(light_bg, -10)
  local light_blue        = "#0000FF" -- blue
  local light_magenta     = "NvimDarkMagenta"
  local light_green       = "#005523"
  local light_yellow      = "#6B5300"
  local light_red         = "#590008" -- NvimDarkRed
  local light_pale_blue   = mod(light_blue, -30)
  local light_rust        = "#8a290f"

  local bg                = is_light and light_bg or dark_bg
  local fg                = is_light and light_fg or dark_fg
  local accent            = is_light and light_accent or dark_accent
  local subtle            = is_light and light_subtle or dark_subtle
  local subtle_fg         = is_light and light_subtle_fg or dark_subtle_fg
  local muted             = is_light and mod_custom(subtle_fg, 20) or "#aaaaaa"
  local yellow            = is_light and light_yellow or dark_yellow
  local magenta           = is_light and light_magenta or dark_magenta
  local red               = is_light and light_red or dark_red
  local blue              = is_light and light_blue or dark_blue
  local altbg             = is_light and "White" or "Black"
  local altfg             = is_light and "Black" or "White"
  local green             = is_light and light_green or dark_green
  local pale_blue         = is_light and light_pale_blue or dark_pale_blue
  local rust              = is_light and light_rust or dark_rust
  local diffadd_bg        = is_light and "#c1f2d1" or "#00381f"
  local diffdelete_bg     = is_light and "#ffd8d5" or "#4f1119"
  local diffchange_bg     = is_light and "#ffdfa9" or "#363300"
  local diffadd_fg        = is_light and "#005000" or "#a0e0a0"
  local diffdelete_fg     = is_light and "#8f1313" or "#ffbfbf"
  local diffchange_fg     = is_light and "#553d00" or "#efef80"

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
    Normal                      = { fg = fg, bg = bg },
    -- Pmenu                       = { bg = accent },
    Pmenu                       = { bg = bg },
    PmenuSel                    = { fg = bg, bg = fg },
    PmenuMatch                  = { fg = yellow, bg = accent, bold = true },
    PmenuMatchSel               = { fg = bg, bg = fg, bold = true, underline = true },
    PmenuBorder                 = { link = "FloatBorder" },
    NormalFloat                 = { bg = bg },
    -- NormalFloat                     = { bg = mod_custom(bg, -5) },
    FloatBorder                 = { fg = mod_custom(subtle_fg, 30), bg = bg },
    WinSeparator                = { fg = subtle },
    Special                     = { fg = yellow },
    Comment                     = { fg = muted, italic = true },
    Identifier                  = is_light and { fg = "NvimDarkCyan" } or {},
    Todo                        = { fg = altbg, bg = altfg, bold = true },
    QuickFixLine                = { link = "PmenuSel" },
    Statusline                  = { fg = fg, bg = subtle },
    StatuslineNC                = is_light and { fg = muted, bg = mod(subtle, -20) } or { fg = muted, bg = subtle },
    TablineSel                  = { fg = fg, bold = true },
    Number                      = { fg = magenta, bold = true },
    Boolean                     = { fg = magenta, bold = true },
    FzfLuaBorder                = { link = "FloatBorder" },
    -- FzfLuaBackDrop                  = { bg = is_light and "White" or "Black" },
    FzfLuaBackDrop              = { link = "Normal" },
    FzfLuaLivePrompt            = { fg = fg },
    FzfLuaTitle                 = { link = "Statusline" },
    fzf1                        = { link = "Statusline" },
    fzf2                        = { link = "Statusline" },
    fzf3                        = { link = "Statusline" },
    Function                    = { fg = blue },
    String                      = { fg = green },
    Statement                   = { link = "Keyword" },
    Keyword                     = is_light and { fg = rust } or { fg = subtle_fg },
    Include                     = is_light and { fg = light_magenta } or { fg = dark_magenta },
    TreesitterContext           = { bg = bg, underline = true, sp = subtle },
    TreesitterContextLineNumber = { fg = fg, bg = bg, bold = true, underline = true, sp = subtle },
    ModeMsg                     = { link = "Normal" },
    Constant                    = { fg = magenta, bold = true },
    Conceal                     = { link = "Keyword" },
    MiniPickMatchCurrent        = { link = "PmenuSel" },
    Variable                    = { fg = fg },
    Directory                   = { fg = blue },
    SpellBad                    = { undercurl = true, sp = red },
    SpellCap                    = { undercurl = true, sp = yellow },
    SpellLocal                  = { undercurl = true, sp = yellow },
    SpellRare                   = { undercurl = true, sp = yellow },
    EndOfBuffer                 = { fg = bg },
    Operator                    = { fg = magenta },

    DiagnosticUnderlineOk       = { sp = green, undercurl = true },
    DiagnosticUnderlineWarn     = { sp = yellow, undercurl = true },
    DiagnosticUnderlineError    = { sp = red, undercurl = true },
    DiagnosticUnderlineInfo     = { sp = blue, undercurl = true },
    DiagnosticUnderlineHint     = { sp = blue, undercurl = true },
    DiagnosticDeprecated        = { sp = red, strikethrough = true },
    Scrollbar                   = { fg = accent, bg = accent },
    ScrollbarThumb              = { fg = subtle, bg = subtle },
    Delimiter                   = { fg = muted },

    ["@punctuation.delimiter"]  = { link = "Delimiter" },
    ["@punctuation.bracket"]    = { link = "Delimiter" },
    ["@punctuation.special"]    = { link = "Delimiter" },


    ["@keyword.return"]             = { fg = yellow, bold = false },
    ["@variable"]                   = { link = "Variable" },
    ["@constructor"]                = { fg = magenta },
    ["@constructor.python"]         = { fg = blue },
    ["@variable.builtin.python"]    = { fg = subtle_fg },

    ["@markup.link"]                = { fg = blue, underline = true },
    ["@markup.heading.1"]           = { fg = blue, bold = true },
    ["@markup.heading.2"]           = { fg = blue, bold = true },
    ["@markup.heading.3"]           = { fg = blue, bold = true },
    ["@markup.heading.4"]           = { fg = blue, bold = true },
    ["@markup.heading.5"]           = { fg = blue, bold = true },
    ["@markup.heading.6"]           = { fg = blue, bold = true },
    ["@markup.raw.markdown_inline"] = is_light and { bg = "NvimLightGrey2" } or { bg = "NvimDarkGrey3" },
    ["@markup.math.latex"]          = { fg = subtle_fg },

    Bold                            = { bold = true },
    Italic                          = { italic = true },
    Underlined                      = { underline = true },

    DiffAdd                         = { fg = diffadd_fg, bg = diffadd_bg },
    DiffDelete                      = { fg = diffdelete_fg, bg = diffdelete_bg },
    DiffChange                      = { fg = diffchange_fg, bg = diffchange_bg },
    DiffText                        = { link = "DiffChange" },
    DiffTextAdd                     = { link = "DiffText" },
    Added                           = { fg = green },
    Changed                         = { fg = blue },
    Removed                         = { fg = red },

    -- DiffAdd                         = { bg = diff_add },
    -- DiffDelete                      = { bg = diff_remove },
    -- DiffText                        = { bg = diff_text },
    -- DiffChange                      = { bg = diffchange },


    texCmdEnv                      = { fg = blue },
    texcmdPackage                  = { fg = magenta },
    texCmdPart                     = { link = "Keyword" },
    texPartArgTitle                = { fg = yellow },
    texTCBZone                     = { fg = green },
    texFileOpt                     = { fg = magenta },
    texMathGroup                   = { fg = pale_blue },
    texMathArg                     = { fg = pale_blue },
    texMathZoneLD                  = { fg = pale_blue },
    texMathZoneLI                  = { fg = pale_blue },
    texMathSuper                   = { fg = pale_blue },
    texMathSub                     = { fg = pale_blue },
    texDocZone                     = { fg = fg },
    -- texSectionZone  = { fg = subtle_fg }
    texBeginEndName                = { fg = fg },
    ["@module.latex"]              = { fg = subtle_fg },
    ["@label.latex"]               = { fg = fg },
    ["@punctuation.special.latex"] = { fg = magenta },
    BlinkCmpGhostText              = { fg = subtle_fg },
    BlinkCmpMenuBorder             = { link = "FloatBorder" },
    BlinkCmpDocBorder              = { link = "FloatBorder" },
    BlinkCmpSignatureHelpBorder    = { link = "BlinkCmpDocBorder" },
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
