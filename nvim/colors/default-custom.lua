local mod = require("utils").modify_colour

local function apply_colourscheme()
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = "default-custom"

  local is_light = vim.o.background == "light"

  local dark_bg = "#14161b"
  local dark_fg = "NvimLightGrey2"
  local dark_slbg = "#4f5258"
  local dark_class_color = "#c2d2e3"
  local dark_func = "#88c0d0"
  local dark_cyan = "#82b0ec"
  -- local dark_magenta = "#b6a0ff"
  local dark_magenta = "#B189F5"
  local dark_string = "NvimLightGreen"
  local dark_rust = "#CF8E6D"

  local light_bg = "#ffffff"
  local light_fg = "NvimDarkGrey2"
  local light_slbg = "NvimLightGrey4"
  local light_class_color = "NvimDarkBlue"
  local light_func = "NvimDarkCyan"
  local light_cyan = "NvimDarkCyan"
  local light_magenta = "NvimDarkMagenta"
  local light_string = "#7f0000"
  local light_rust = "#8a290f"

  local bg = is_light and light_bg or dark_bg
  local fg = is_light and light_fg or dark_fg
  local cline = is_light and "#f2f2f4" or mod(bg, 20)
  local class_color = is_light and light_class_color or dark_class_color
  local yellow = is_light and "NvimDarkYellow" or "NvimLightYellow"
  local func = is_light and light_func or dark_func
  local rust = is_light and light_magenta or dark_magenta
  local cyan = is_light and light_cyan or dark_cyan
  local string_fg = is_light and light_string or dark_string
  local border = is_light and "NvimLightGrey3" or "NvimDarkGrey3"
  local comment = is_light and "NvimDarkGrey4" or "NvimLightGrey4"
  local selection = is_light and "NvimLightGrey4" or "NvimDarkGrey4"
  local red = is_light and "NvimDarkRed" or "NvimLightRed"
  local blue = is_light and "Blue" or "NvimLightBlue"
  local line = is_light and "NvimLightGrey3" or "NvimDarkGrey4"
  local altbg = is_light and "White" or "Black"
  local altfg = is_light and "Black" or "White"
  local green = is_light and "NvimDarkGreen" or "NvimLightGreen"
  local keyword = is_light and light_rust or dark_rust

  vim.g.terminal_color_5 = is_light and "#000000" or "#ffffff"
  vim.g.terminal_color_13 = is_light and "#000000" or "#ffffff"

  local highlights = {
    Normal                      = { bg = bg, fg = fg },
    CursorLine                  = { bg = cline },
    NormalFloat                 = { bg = bg },
    FloatBorder                 = { fg = selection },
    Pmenu                       = { bg = bg },
    PmenuMatch                  = { fg = yellow, bold = true },
    PmenuBorder                 = { link = "FloatBorder" },
    BlinkCmpMenuBorder          = { link = "PmenuBorder" },
    BlinkCmpDocBorder           = { link = "PmenuBorder" },
    WinSeparator                = { fg = border },
    SpellBad                    = { undercurl = true },
    Comment                     = { fg = comment, italic = true },
    PmenuThumb                  = is_light and { bg = "NvimLightGrey4" } or { bg = "NvimLightGrey1" },
    QuickFixLine                = { fg = "None", bg = "NvimDarkCyan" },
    Statusline                  = { bg = line, fg = fg },
    TablineSel                  = { bg = fg, fg = bg },
    Number                      = { fg = altfg, bold = true },
    Boolean                     = { fg = rust },
    FzfLuaBorder                = { link = "FloatBorder" },
    FzfLuaBackdrop              = { bg = bg },
    Function                    = { fg = blue },
    String                      = { fg = string_fg },
    Statement                   = { fg = blue },
    Include                     = is_light and { fg = light_magenta } or { fg = dark_magenta },
    TreesitterContext           = { bg = bg, blend = 0 },
    TreesitterContextLineNumber = { fg = fg },
    TreesitterContextSeparator  = { link = "WinSeparator" },
    AltBg                       = { bg = altbg },
    ModeMsg                     = { fg = fg },
    Constant                    = { fg = yellow },

    DiagnosticUnderlineOk       = { sp = green, undercurl = true },
    DiagnosticUnderlineWarn     = { sp = yellow, undercurl = true },
    DiagnosticUnderlineError    = { sp = red, undercurl = true },
    DiagnosticUnderlineInfo     = { sp = blue, undercurl = true },
    DiagnosticUnderlineHint     = { sp = blue, undercurl = true },
    DiagnosticDeprecated        = { sp = red, strikethrough = true },
    Scrollbar                   = { fg = border },
    ScrollbarThumb              = { fg = selection },

    ["@variable.member"]        = { fg = class_color },
    ["@variable.member.python"] = { fg = blue },
    ["@variable.parameter"]     = { fg = altfg, bold = true },
    ["@keyword"]                = { fg = keyword },
    -- ["@keyword.function"]       = { fg = blue, bold = true },
    -- ["@keyword.return"]         = { fg = blue, bold = true },
    -- ["@module.builtin"]         = { bold = true },
    -- ["@function.builtin"]       = { bold = true },

    ["@markup.link"]            = { fg = blue, underline = true },
    ["@markup.heading.1"]       = { fg = blue, bold = true },
    ["@markup.heading.2"]       = { fg = blue, bold = true },
    ["@markup.heading.3"]       = { fg = blue, bold = true },
    ["@markup.heading.4"]       = { fg = blue, bold = true },
    ["@markup.heading.5"]       = { fg = blue, bold = true },
    ["@markup.heading.6"]       = { fg = blue, bold = true },

    User1                       = { fg = red, bold = true },
    User2                       = { fg = blue, bold = true },
    User3                       = is_light and { fg = "NvimDarkGrey2", bold = true } or { fg = "White", bold = true },
    User5                       = { fg = altfg, bold = true },
    User6                       = { fg = fg, bg = altbg },
    User7                       = { fg = class_color, bold = true },
    -- User8                       = is_light and { fg = fg, bg = "NvimLightGrey4" } or
    --     { fg = fg, bg = mod(dark_slbg, 40) },
    User9                       = is_light and { fg = "NvimDarkGrey2" } or { fg = "NvimLightGrey2" },

    TabPages                    = { bg = line },

    Bold                        = { bold = true },
    Italic                      = { italic = true },
    Underlined                  = { underline = true },

    ArtioNormal                 = { bg = bg },
    ArtioSel                    = { link = "PmenuSel" },
    ArtioPrompt                 = { bg = bg },
    ArtioPointer                = { bg = fg },
  }


  for hl_group, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, hl_group, opts)
  end
end

apply_colourscheme()

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    if vim.g.colors_name == "default-custom" then
      apply_colourscheme()
    end
  end,
})
