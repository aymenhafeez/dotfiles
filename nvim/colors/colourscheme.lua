-- A hybrid colorscheme combining modus_operandi, vague and darcula palettes

local mod = require("utils").modify_colour

local palettes = {
  light = {
    bg_main = "#ffffff",
    bg_dim = "#f2f2f4",
    bg_alt = "#e8e8ea",
    border = "#929298",
    border_highlight = "#2e2e32",
    bg_hl_line = "#cdd8e2",
    fg_main = "#000000",
    fg_dim = "#595959",
    fg_alt = "#193668",
    red = "#a60000",
    red_warmer = "#972500",
    red_cooler = "#a0132f",
    red_faint = "#7f0000",
    green = "#006800",
    green_warmer = "#316500",
    green_cooler = "#00663f",
    green_faint = "#2a5045",
    yellow = "#6f5500",
    yellow_warmer = "#884900",
    yellow_cooler = "#7a4f2f",
    yellow_faint = "#624416",
    blue = "#0031a9",
    blue_warmer = "#3548cf",
    blue_cooler = "#0000b0",
    blue_faint = "#003497",
    magenta = "#721045",
    magenta_warmer = "#8f0075",
    magenta_cooler = "#531ab6",
    magenta_faint = "#7c318f",
    cyan = "#005e8b",
    cyan_warmer = "#3f578f",
    cyan_cooler = "#005f5f",
    cyan_faint = "#005077",
    rust = "#8a290f",
    gold = "#80601f",
    olive = "#56692d",
    slate = "#2f3f83",
    indigo = "#4a3a8a",
    maroon = "#731c52",
    pink = "#7b435c",
    red_intense = "#d00000",
    green_intense = "#008900",
    yellow_intense = "#808000",
    blue_intense = "#0000ff",
    magenta_intense = "#dd22dd",
    cyan_intense = "#008899",
    bg_red_intense = "#ff8f88",
    bg_green_intense = "#8adf80",
    bg_yellow_intense = "#f3d000",
    bg_blue_intense = "#bfc9ff",
    bg_magenta_intense = "#dfa0f0",
    bg_cyan_intense = "#a4d5f9",
    bg_red_subtle = "#ffcfbf",
    bg_green_subtle = "#b3fabf",
    bg_yellow_subtle = "#fff576",
    bg_blue_subtle = "#ccdfff",
    bg_magenta_subtle = "#ffddff",
    bg_cyan_subtle = "#bfefff",
    bg_red_nuanced = "#fff5f5",
    bg_green_nuanced = "#f0faf0",
    bg_yellow_nuanced = "#fff8e0",
    bg_blue_nuanced = "#f5f5ff",
    bg_magenta_nuanced = "#fdf5ff",
    bg_cyan_nuanced = "#f0f8fc",
    bg_completion = "#c0deff",
    bg_paren_match = "#5fcfff",
    bg_paren_expression = "#efd3f5",
    bg_char_0 = "#7feaff",
    bg_char_1 = "#ffaaff",
    bg_char_2 = "#dff000",
    bg_active = "#e0e0e2",
    fg_active = "#0a0a0a",
    bg_inactive = "#eaeaea",
    fg_inactive = "#3c3d44",
    bg_status_line_active = "#e0e0e2",
    fg_status_line_active = "#0a0a0a",
    bg_status_line_inactive = "#e8e8ea",
    fg_status_line_inactive = "#545458",
    bg_tab_bar = "#e0e0e2",
    bg_tab_current = "#f2f2f4",
    bg_tab_other = "#c8c8cc",
    fg_tab_other = "#2f2f33",
    bg_tab_alternate = "#d0d0e8",
    bg_added = "#c1f2d1",
    bg_added_faint = "#d8f8e1",
    bg_added_refine = "#aee5be",
    bg_added_fringe = "#6cc06c",
    fg_added = "#005000",
    fg_added_intense = "#006700",
    bg_changed = "#ffdfa9",
    bg_changed_faint = "#ffefbf",
    bg_changed_refine = "#fac090",
    bg_changed_fringe = "#d7c20a",
    fg_changed = "#553d00",
    fg_changed_intense = "#655000",
    bg_removed = "#ffd8d5",
    bg_removed_faint = "#ffe9e9",
    bg_removed_refine = "#f3b5af",
    bg_removed_fringe = "#d84a4f",
    fg_removed = "#8f1313",
    fg_removed_intense = "#aa2222",
    bg_diff_context = "#f8f8f8",
    string_fg = "#7f0000",
    func_bg = "#005e8b",
  },
  dark = {
    bg_main = "#191a1c",
    bg_dim = mod("#25272b", 20),
    bg_dark = mod("#191a1c", -20),
    bg_alt = "#20222a",
    fg_main = "#BCBEC4",
    fg_dim = "#7A7E85",
    fg_alt = "#CED0D6",
    border = "#2b2d32",
    border_highlight = "#CED0D6",
    -- Syntax colors from JB
    red = "#F75464",
    red_warmer = "#FA6675",
    red_cooler = "#F75464",
    red_faint = "#CF514E",
    green = "#6AAB73",
    green_warmer = "#73BD79",
    green_cooler = "#5C962C",
    green_faint = "#549159",
    yellow = "#F2C55C",
    yellow_warmer = "#CF8E6D",
    yellow_cooler = "#B3AE60",
    yellow_faint = "#C29E4A",
    blue = "#56A8F5",
    blue_warmer = "#57AAF7",
    blue_cooler = "#548AF7",
    blue_faint = "#2AACB8",
    magenta = "#C77DBB",
    magenta_warmer = "#A771BF",
    magenta_cooler = "#CF84CF",
    magenta_faint = "#B189F5",
    cyan = "#2AACB8",
    cyan_warmer = "#299999",
    cyan_cooler = "#028E8E",
    cyan_faint = "#3993D4",
    -- Semantic colors
    rust = "#CF8E6D",
    gold = "#B3AE60",
    olive = "#6AAB73",
    slate = "#2AACB8",
    indigo = "#56A8F5",
    maroon = "#C77DBB",
    pink = "#C77DBB",
    -- Intense variants
    red_intense = "#FA6675",
    green_intense = "#73BD79",
    yellow_intense = "#F2C55C",
    blue_intense = "#57AAF7",
    magenta_intense = "#C77DBB",
    cyan_intense = "#2AACB8",
    -- Background intense
    bg_red_intense = "#3e2925",
    bg_green_intense = "#223d30",
    bg_yellow_intense = "#574c33",
    bg_blue_intense = "#1b3b7d",
    bg_magenta_intense = "#372846",
    bg_cyan_intense = "#0a4251",
    -- Subtle backgrounds
    bg_red_subtle = "#231a1a",
    bg_green_subtle = "#1a231e",
    bg_yellow_subtle = "#1e232f",
    bg_blue_subtle = "#1a2337",
    bg_magenta_subtle = "#231a23",
    bg_cyan_subtle = "#1a232a",
    -- Nuanced backgrounds
    bg_red_nuanced = "#161414",
    bg_green_nuanced = "#121614",
    bg_yellow_nuanced = "#161614",
    bg_blue_nuanced = "#121216",
    bg_magenta_nuanced = "#161216",
    bg_cyan_nuanced = "#121616",
    -- UI elements
    bg_completion = "#214283",
    bg_hl_line = "#1f2123",
    bg_paren_match = "#2b2d32",
    bg_paren_expression = "#27221a",
    bg_char_0 = "#56A8F5",
    bg_char_1 = "#C77DBB",
    bg_char_2 = "#B3AE60",
    bg_active = "#25272a",
    fg_active = "#BCBEC4",
    bg_inactive = "#121315",
    fg_inactive = "#6B6C73",
    -- Status line
    bg_status_line_active = "#25272a",
    fg_status_line_active = "#BCBEC4",
    bg_status_line_inactive = "#25272b",
    fg_status_line_inactive = "#6B6C73",
    -- Tabs
    bg_tab_bar = "#25272a",
    bg_tab_current = "#191a1c",
    bg_tab_other = "#1f2123",
    fg_tab_other = "#BCBEC4",
    bg_tab_alternate = "#2b2d32",
    -- Diff colors from JB
    bg_added = "#294436",
    bg_added_faint = "#222E2A",
    bg_added_refine = "#375239",
    bg_added_fringe = "#447152",
    fg_added = "#6AAB73",
    fg_added_intense = "#73BD79",
    bg_changed = "#385570",
    bg_changed_faint = "#283541",
    bg_changed_refine = "#43698D",
    bg_changed_fringe = "#43698D",
    fg_changed = "#70AEFF",
    fg_changed_intense = "#70AEFF",
    bg_removed = "#484A4A",
    bg_removed_faint = "#2F3032",
    bg_removed_refine = "#45302B",
    bg_removed_fringe = "#656E76",
    fg_removed = "#868A91",
    fg_removed_intense = "#6F737A",
    bg_diff_context = "#191a1c",
    -- String and function colors
    string_fg = "#6AAB73",
    func_bg = "#56A8F5",
    -- UI grays - adjusted for #191a1c background
    gray_1 = "#43464c",
    gray_2 = "#64676d",
    gray_3 = "#7a7d84",
    gray_4 = "#8f9298",
    gray_5 = "#adafb4",
    gray_6 = "#bec1c6",
    gray_7 = "#cdcfd4",
    gray_8 = "#33363c",
    gray_9 = "#26282d",
    gray_10 = "#93969c",
    gray_11 = "#4b4e53",
    gray_12 = "#63666c",
    -- Accent colors
    accent_blue = "#4573E8",
    info_blue = "#5D85EB",
    indent_guide = "#23252a",
    indent_guide_active = "#5a5d61",
    vcs_green = "#549159",
    vcs_blue = "#375FAD",
    search_bg = "#B7975C",
    inc_search_bg = "#ffae00",
    match_paren = "#33363c",
    pmenu_bg = "#25272a",
    pmenu_sel_bg = "#bec1c6",
    pmenu_sel_fg = "#25272a",
    scrollbar = "#2f3236",
    scrollbar_bg = "#43464c",
    folded_fg = "#81848b",
    non_text = "#46494f",
    -- LSP references
    lsp_ref_read = "#2b312d",
    lsp_ref_write = "#332728",
    lsp_inlay_hint = "#7a7d84",
    lsp_inlay_hint_bg = "#2b2d32",
    -- Misc
    todo_fg = "#8BB33D",
    string_doc = "#5F826B",
    tree_sep = "#4a4d52",
    mini_scope = "#4a4d52",
    html_heading = "#56A8F5",
    warning_orange = "#EBC66D"
  },
  dark_tinted = {
    bg_main = "#141415",
    bg_dim = "#1c1c24",
    bg_alt = "#0f0f0f",
    fg_main = "#cdcdcd",
    fg_dim = "#606079",
    fg_alt = "#b4d4cf",
    border = mod("#252530", 70),
    border_highlight = "#878787",
    red = "#c48282",
    red_warmer = "#d8647e",
    red_cooler = "#c48282",
    red_faint = "#c48282",
    green = "#7fa563",
    green_warmer = "#7fa563",
    green_cooler = "#7fa563",
    green_faint = "#e8b589",
    yellow = "#e0a363",
    yellow_warmer = "#f3be7c",
    yellow_cooler = "#e8b589",
    yellow_faint = "#f3be7c",
    blue = "#7e98e8",
    blue_warmer = "#6e94b2",
    blue_cooler = "#7e98e8",
    blue_faint = "#9bb4bc",
    magenta = "#bb9dbd",
    magenta_warmer = "#bb9dbd",
    magenta_cooler = "#aeaed1",
    magenta_faint = "#c3c3d5",
    cyan = "#b4d4cf",
    cyan_warmer = "#9bb4bc",
    cyan_cooler = "#90a0b5",
    cyan_faint = "#b4d4cf",
    rust = "#c48282",
    gold = "#e0a363",
    olive = "#7fa563",
    slate = "#9bb4bc",
    indigo = "#7e98e8",
    maroon = "#bb9dbd",
    pink = "#c3c3d5",
    red_intense = "#d8647e",
    green_intense = "#7fa563",
    yellow_intense = "#f3be7c",
    blue_intense = "#7e98e8",
    magenta_intense = "#bb9dbd",
    cyan_intense = "#b4d4cf",
    bg_red_intense = "#4a2a35",
    bg_green_intense = "#2a3a2a",
    bg_yellow_intense = "#4a4530",
    bg_blue_intense = "#2a3550",
    bg_magenta_intense = "#3a2a45",
    bg_cyan_intense = "#2a3a45",
    bg_red_subtle = "#3a2530",
    bg_green_subtle = "#253525",
    bg_yellow_subtle = "#3a3525",
    bg_blue_subtle = "#252a3a",
    bg_magenta_subtle = "#302535",
    bg_cyan_subtle = "#253035",
    bg_red_nuanced = "#1f1a1c",
    bg_green_nuanced = "#1a1f1a",
    bg_yellow_nuanced = "#1f1f1a",
    bg_blue_nuanced = "#1a1a1f",
    bg_magenta_nuanced = "#1f1a1f",
    bg_cyan_nuanced = "#1a1f1f",
    bg_completion = "#405065",
    bg_hl_line = "#252530",
    bg_paren_match = "#405065",
    bg_paren_expression = "#333738",
    bg_char_0 = "#6e94b2",
    bg_char_1 = "#bb9dbd",
    bg_char_2 = "#7e98e8",
    bg_active = "#1c1c24",
    fg_active = "#cdcdcd",
    bg_inactive = "#252530",
    fg_inactive = "#606079",
    bg_status_line_active = "#1c1c24",
    fg_status_line_active = "#cdcdcd",
    bg_status_line_inactive = "#252530",
    fg_status_line_inactive = "#606079",
    bg_tab_bar = "#141415",
    bg_tab_current = "#141415",
    bg_tab_other = "#1c1c24",
    fg_tab_other = "#606079",
    bg_tab_alternate = "#252530",
    bg_added = "#253025",
    bg_added_faint = "#1c241c",
    bg_added_refine = "#2a3a2a",
    bg_added_fringe = "#7fa563",
    fg_added = "#7fa563",
    fg_added_intense = "#8fb573",
    bg_changed = "#3a3525",
    bg_changed_faint = "#2a2520",
    bg_changed_refine = "#4a4530",
    bg_changed_fringe = "#f3be7c",
    fg_changed = "#f3be7c",
    fg_changed_intense = "#f3be7c",
    bg_removed = "#3a2530",
    bg_removed_faint = "#2a1c20",
    bg_removed_refine = "#4a2a35",
    bg_removed_fringe = "#d8647e",
    fg_removed = "#d8647e",
    fg_removed_intense = "#e8748e",
    bg_diff_context = "#1c1c24",
    string_fg = "#e8b589",
    func_bg = "#c48282",
  },
}

local function apply()
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = "colourscheme"

  local variant = vim.g.colourscheme_variant or "default"
  local is_light = vim.o.background == "light"
  local key
  if is_light then
    key = "light"
  elseif variant == "tinted" then
    key = "dark_tinted"
  else
    key = "dark"
  end
  local c = palettes[key]

  -- Derived semantic colors
  c.bg_sidebar = c.bg_dark
  c.fg_sidebar = c.fg_main
  c.cursor = key == "dark_tinted" and c.magenta_warmer or c.fg_main
  c.comment = key == "dark_tinted" and c.fg_dim or c.fg_dim
  c.git_add_bg = key == "light" and c.bg_added or c.bg_dim
  c.git_change_bg = key == "light" and c.bg_changed or c.bg_dim
  c.git_delete_bg = key == "light" and c.bg_removed or c.bg_dim
  c.linenr_bg = key == "dark" and c.bg_dim and c.bg_dim or c.bg_main
  c.linenr_sep = key == "dark" and c.border or c.bg_border
  c.winsep = key == "light" and mod(c.border, 40) or c.border
  c.bool_fg = key == "tinted" and c.yellow or c.blue_warmer
  c.error = c.red_cooler
  c.warning = c.yellow_cooler
  c.info = c.blue_cooler
  c.hint = c.cyan_faint
  c.ok = c.green_cooler
  c.success = c.fg_added
  c.visual = c.bg_magenta_intense
  c.accent_light = c.blue_faint
  c.accent = c.blue_warmer
  c.accent_darker = c.blue
  c.accent_dark = c.blue_intense

  local NONE = "NONE"
  local bg_main = c.bg_main

  local function hi(group, opts)
    if opts.style then
      if type(opts.style) == "table" then
        opts = vim.tbl_extend("force", opts, opts.style)
      end
      opts.style = nil
    end
    vim.api.nvim_set_hl(0, group, opts)
  end

  local function set_highlights(groups)
    for group, opts in pairs(groups) do
      hi(group, opts)
    end
  end

  -- Terminal colors
  vim.g.terminal_color_0 = c.bg_main
  vim.g.terminal_color_8 = c.border
  vim.g.terminal_color_7 = c.fg_main
  vim.g.terminal_color_15 = c.fg_dim
  vim.g.terminal_color_1 = c.red
  vim.g.terminal_color_9 = c.red_intense
  vim.g.terminal_color_2 = c.green
  vim.g.terminal_color_10 = c.green_intense
  vim.g.terminal_color_3 = c.yellow
  vim.g.terminal_color_11 = c.yellow_intense
  vim.g.terminal_color_4 = c.blue
  vim.g.terminal_color_12 = c.blue_intense
  vim.g.terminal_color_5 = c.fg_main
  vim.g.terminal_color_13 = c.magenta_intense
  vim.g.terminal_color_6 = c.cyan
  vim.g.terminal_color_14 = c.cyan_intense

  -- Use darcula-style highlights for dark palette
  if key == "dark" then
    set_highlights({
      -- UI
      Normal                                 = { fg = c.fg_main, bg = bg_main },
      NormalNC                               = { fg = c.fg_main, bg = bg_main },
      NormalSB                               = { fg = c.fg_sidebar, bg = c.bg_sidebar },
      TerminalNormal                         = { bg = c.bg_sidebar },
      SidebarNormal                          = { bg = c.bg_sidebar },
      NormalFloat                            = { bg = c.bg_sidebar },
      FloatBorder                            = { fg = c.gray_2 },
      FloatTitle                             = { fg = c.border_highlight, bg = bg_main },
      Bold                                   = { bold = true },
      Italic                                 = { italic = true },
      Underlined                             = { underline = true },

      -- Editor
      ColorColumn                            = { bg = c.bg_dim },
      CursorLine                             = { bg = c.bg_alt },
      CursorColumn                           = { bg = c.bg_alt },
      ErrorMsg                               = { fg = c.red_warmer, bg = bg_main },
      LineNr                                 = { fg = c.gray_1, bg = bg_main },
      CursorLineNr                           = { fg = c.gray_10, bg = c.bg_alt, bold = true },
      CursorLineSign                         = { link = "CursorLine" },
      SignColumn                             = { fg = c.fg_dim, bg = bg_main },
      MatchParen                             = { bg = c.match_paren, bold = true },
      NonText                                = { fg = c.non_text },
      Visual                                 = { bg = "#214283" },
      VisualNOS                              = { bg = "#214283" },
      LineNrSeparator                        = { fg = c.gray_1 },

      -- Popup menu (JB style)
      Pmenu                                  = { fg = c.fg_main, bg = c.bg_dim },
      PmenuSel                               = { fg = c.pmenu_sel_fg, bg = c.pmenu_sel_bg, bold = true },
      PmenuSbar                              = { bg = c.bg_status_line_active },
      PmenuThumb                             = { bg = "#3B3C3E" },
      PmenuBorder                            = { link = "FloatBorder" },

      Scrollbar                              = { fg = c.gray_8, bg = c.bg_main },
      ScrollbarThumb                         = { fg = c.gray_1, bg = c.bg_main },

      -- Search (JB style)
      Search                                 = { fg = "#000000", bg = c.search_bg },
      IncSearch                              = { fg = c.bg_main, bg = c.inc_search_bg, underline = true },
      CurSearch                              = { link = "IncSearch" },
      Substitute                             = { fg = c.fg_main, bg = c.bg_red_intense },

      -- Folding (JB style)
      Folded                                 = { fg = c.folded_fg, bg = c.lsp_inlay_hint_bg },
      FoldColumn                             = { fg = c.gray_2, bg = bg_main },

      -- Spelling
      SpellBad                               = { undercurl = true, sp = c.red },
      SpellCap                               = { undercurl = true, sp = c.yellow },
      SpellLocal                             = { undercurl = true, sp = c.yellow },
      SpellRare                              = { undercurl = true, sp = c.yellow },

      -- Diff (JB style)
      DiffAdd                                = { bg = "#294436" },
      DiffChange                             = { bg = "#385570" },
      DiffDelete                             = { bg = "#484A4A" },
      DiffText                               = { bg = "#385570" },
      Added                                  = { link = "DiffAdd" },
      Changed                                = { link = "DiffChange" },
      Removed                                = { link = "DiffDelete" },

      -- Cursor
      Cursor                                 = { fg = c.bg_main, bg = c.cursor },
      lCursor                                = { link = "Cursor" },
      CursorIM                               = { link = "Cursor" },

      -- Gutter
      QuickFixLine                           = { link = "Visual" },

      -- Navigation
      Directory                              = { fg = c.cyan },

      -- Prompt/Status
      EndOfBuffer                            = { fg = c.bg_main },
      ModeMsg                                = { fg = c.fg_main, bold = true },
      MoreMsg                                = { fg = c.cyan },
      Question                               = { fg = c.fg_main },
      WarningMsg                             = { fg = c.warning_orange, bg = bg_main },
      WildMenu                               = { fg = c.cyan, bg = c.bg_dim },
      WinBar                                 = { fg = c.gray_6, bg = bg_main },
      WinBarNC                               = { fg = c.gray_2, bg = bg_main },

      StatusLine                             = { fg = c.fg_status_line_active, bg = c.bg_status_line_active },
      StatusLineNC                           = { fg = c.gray_4, bg = c.bg_status_line_active },
      StatusLineTerm                         = { link = "StatusLine" },
      StatusLineTermNC                       = { link = "StatusLineNC" },

      -- Tabs (JB style)
      TabLine                                = { fg = c.gray_5, bg = c.bg_status_line_active },
      TabLineFill                            = { fg = c.gray_5, bg = c.bg_status_line_active },
      TabLineSel                             = { fg = c.gray_7, bg = c.gray_8, bold = true },

      -- Window
      Title                                  = { fg = c.cyan, bold = true },
      WinSeparator                           = { fg = c.winsep, bg = c.bg_main },

      -- User highlights
      -- User1                                  = { fg = c.red, bg = c.bg_dim, bold = true },
      -- User2                                  = { fg = c.yellow, bg = c.bg_dim, bold = true },
      -- User3                                  = { fg = c.fg_main, bg = c.bg_dim, bold = true },
      -- User4                                  = { fg = c.bg_main, bg = c.yellow },
      -- User5                                  = { fg = c.fg_main, bg = c.bg_dim, bold = true },
      -- User6                                  = { fg = c.fg_status_line_active, bg = c.bg_dim },
      -- User7                                  = { fg = c.fg_main, bg = c.bg_dim, bold = true },
      -- User8                                  = { bg = c.bg_dim },
      -- User9                                  = { fg = c.fg_main, bg = c.bg_dim },

      -- Syntax - Base Groups (JB style)
      Comment                                = { fg = c.fg_dim, italic = true },
      String                                 = { fg = c.green },
      Character                              = { fg = c.green },
      Number                                 = { fg = c.blue_faint },
      Boolean                                = { fg = c.magenta },
      Float                                  = { fg = c.blue_faint },

      Function                               = { fg = c.blue },
      Identifier                             = { fg = c.fg_main },
      Statement                              = { fg = c.yellow_warmer },
      Conditional                            = { fg = c.yellow_warmer },
      Repeat                                 = { fg = c.yellow_warmer },
      Label                                  = { fg = c.fg_main },
      Operator                               = { fg = c.fg_main },
      Keyword                                = { fg = c.yellow_warmer },
      Exception                              = { fg = c.yellow_warmer },

      PreProc                                = { fg = c.yellow_warmer },
      Include                                = { fg = c.yellow_warmer },
      Define                                 = { fg = c.yellow_warmer },
      Macro                                  = { link = "Define" },
      PreCondit                              = { link = "PreProc" },

      Type                                   = { fg = c.fg_main },
      StorageClass                           = { fg = c.yellow_warmer },
      Structure                              = { fg = c.yellow_warmer },
      Typedef                                = { fg = c.yellow_warmer },
      SpecialChar                            = { fg = c.yellow_warmer },
      Tag                                    = { fg = c.fg_main },
      SpecialComment                         = { fg = c.gray_2, italic = true },
      Debug                                  = {},
      Ignore                                 = {},
      Error                                  = { fg = c.fg_main, bg = c.red },
      Todo                                   = { fg = c.todo_fg, italic = true },

      -- Constants (JB style)
      Constant                               = { fg = c.magenta, italic = true },

      -- Language Base Groups (JB style)
      Attribute                              = { fg = c.gold },
      Decorator                              = { fg = c.gold },
      Annotation                             = { link = "Decorator" },
      Variable                               = { link = "Identifier" },
      Constructor                            = { fg = c.yellow },

      -- qf
      qfLineNr                               = { fg = c.fg_dim },
      qfFileName                             = { fg = c.cyan },
      qfNormal                               = { bg = c.bg_tab_bar },

      -- html (JB style)
      htmlH1                                 = { fg = c.html_heading, bold = true },
      htmlH2                                 = { link = "htmlH1" },
      htmlH3                                 = { link = "htmlH1" },
      htmlH4                                 = { link = "htmlH1" },
      htmlH5                                 = { link = "htmlH1" },
      htmlH6                                 = { link = "htmlH1" },
      htmlBold                               = { link = "Bold" },
      htmlItalic                             = { link = "Italic" },
      htmlEndTag                             = { link = "htmlTag" },
      htmlTag                                = { fg = c.fg_main },
      htmlTagN                               = { link = "htmlTag" },
      htmlSpecialChar                        = { link = "SpecialChar" },
      htmlArg                                = { fg = c.fg_main },
      htmlLink                               = { fg = c.blue_cooler, underline = true, sp = c.blue_cooler },

      -- markdown (JB style)
      markdownHeadingDelimiter               = { fg = c.yellow_warmer, bold = true },
      markdownCode                           = { fg = c.cyan },
      markdownCodeBlock                      = { fg = c.cyan },
      markdownLinkText                       = { fg = c.blue_cooler, underline = true, sp = c.blue_cooler },
      markdownH1                             = { link = "@markup.heading.1" },
      markdownH2                             = { link = "@markup.heading.2" },
      markdownH3                             = { link = "@markup.heading.3" },
      markdownH4                             = { link = "@markup.heading.4" },
      markdownH5                             = { link = "@markup.heading.5" },
      markdownH6                             = { link = "@markup.heading.6" },

      mkdCodeDelimiter                       = { bg = c.bg_alt, fg = c.fg_main },
      mkdCodeStart                           = { fg = c.cyan, bold = true },
      mkdCodeEnd                             = { fg = c.cyan, bold = true },

      -- Diagnostics (JB style)
      DiagnosticOk                           = { fg = c.green_cooler },
      DiagnosticWarn                         = { fg = c.yellow },
      DiagnosticError                        = { fg = c.red },
      DiagnosticInfo                         = { fg = c.info_blue },
      DiagnosticHint                         = { fg = c.gray_12 },
      DiagnosticUnderlineOk                  = { sp = c.green_cooler, undercurl = true },
      DiagnosticUnderlineWarn                = { sp = "#BA9752", undercurl = true },
      DiagnosticUnderlineError               = { sp = "#FA6675", undercurl = true },
      DiagnosticUnderlineInfo                = { sp = "#3592C4", undercurl = true },
      DiagnosticUnderlineHint                = { sp = "#857042", undercurl = true },
      DiagnosticDeprecated                   = { sp = "#BCBEC4", strikethrough = true },

      -- LSP (JB style)
      LspReferenceText                       = { bg = "#373B39" },
      LspReferenceRead                       = { bg = "#373B39" },
      LspReferenceWrite                      = { bg = "#402F33" },
      LspSignatureActiveParameter            = { underline = true, bold = true, sp = c.fg_main },
      LspCodeLens                            = { fg = c.lsp_inlay_hint },
      LspCodeLensSeparator                   = { link = "Comment" },
      LspInlayHint                           = { fg = c.lsp_inlay_hint, bg = c.lsp_inlay_hint_bg },
      ["@lsp.type.namespace"]                = { link = "Identifier" },
      ["@lsp.type.operator"]                 = { link = "Operator" },
      ["@lsp.mod.defaultLibrary"]            = { fg = c.blue },

      -- Treesitter (JB style)
      ["@variable"]                          = {},
      ["@variable.builtin"]                  = { fg = c.blue },
      ["@variable.parameter"]                = {},
      ["@variable.parameter.builtin"]        = {},
      -- ["@variable.member"]                   = { fg = c.magenta },
      ["@variable.member"]                   = {},
      ["@variable.member.lua"]               = {},

      ["@constant"]                          = { link = "Constant" },
      ["@constant.builtin"]                  = { fg = c.blue },
      ["@constant.macro"]                    = { link = "Macro" },

      ["@module"]                            = { link = "Identifier" },
      ["@module.builtin"]                    = { fg = c.blue },
      ["@module.latex"]                      = { fg = c.yellow_warmer },
      ["@label"]                             = { link = "Label" },

      ["@string"]                            = { link = "String" },
      ["@string.documentation"]              = { link = "String" },
      ["@string.regex"]                      = {},
      ["@string.escape"]                     = {},
      ["@string.special"]                    = {},
      ["@string.special.symbol"]             = { link = "Identifier" },
      ["@string.special.path"]               = { fg = c.cyan },
      ["@string.special.url"]                = { fg = c.cyan, underline = true },
      ["@markup.link.label.markdown_inline"] = { link = "@markup.link.label" },
      ["@markup.link.markdown_inline"]       = { link = "@markup.link" },
      ["@markup.raw.markdown_inline"]        = { bg = c.bg_dim },

      ["@character"]                         = { link = "Character" },
      ["@character.special"]                 = { link = "SpecialChar" },

      ["@boolean"]                           = { link = "Boolean" },
      ["@number"]                            = { link = "Number" },
      ["@number.float"]                      = { link = "Float" },

      ["@type"]                              = { link = "Type" },
      ["@type.builtin"]                      = { fg = c.yellow_warmer },
      ["@type.definition"]                   = { link = "Typedef" },

      ["@attribute"]                         = { link = "Attribute" },
      ["@attribute.builtin"]                 = { link = "Attribute" },
      ["@property"]                          = { link = "@variable.member" },

      ["@function"]                          = { link = "Function" },
      ["@function.builtin"]                  = { link = "Function" },
      ["@function.call"]                     = { link = "Function" },
      ["@function.macro"]                    = { link = "Macro" },

      ["@function.method"]                   = { fg = c.blue_warmer },
      ["@function.method.call"]              = { link = "@function.method" },

      ["@constructor"]                       = { link = "Constructor" },
      ["@operator"]                          = { link = "Operator" },

      ["@keyword"]                           = { link = "Keyword" },
      ["@keyword.coroutine"]                 = { link = "@keyword" },
      ["@keyword.function"]                  = { fg = c.yellow_warmer, bold = false },
      ["@keyword.operator"]                  = { link = "@operator" },
      ["@keyword.import"]                    = { link = "Include" },
      ["@keyword.type"]                      = { link = "@type" },
      ["@keyword.modifier"]                  = { link = "@keyword" },
      ["@keyword.repeat"]                    = { link = "Repeat" },
      ["@keyword.return"]                    = { fg = c.yellow_warmer, bold = false },
      ["@keyword.debug"]                     = { link = "Debug" },
      ["@keyword.exception"]                 = { link = "Exception" },
      ["@keyword.conditional"]               = { link = "Conditional" },
      ["@keyword.conditional.ternary"]       = { link = "Conditional" },
      ["@keyword.directive"]                 = { link = "PreProc" },
      ["@keyword.directive.define"]          = { link = "Define" },

      ["@punctuation.delimiter"]             = { link = "Delimiter" },
      ["@punctuation.bracket"]               = { fg = c.fg_main },
      ["@punctuation.special"]               = { fg = c.fg_main },
      ["@punctuation.special.latex"]         = { fg = c.yellow_warmer },

      ["@comment"]                           = { link = "Comment" },
      ["@comment.documentation"]             = { link = "@string.documentation" },

      ["@comment.error"]                     = { fg = c.red, italic = true },
      ["@comment.warning"]                   = { fg = c.yellow, italic = true },
      ["@comment.todo"]                      = { link = "Todo" },
      ["@comment.note"]                      = { fg = c.info_blue, italic = true },

      ["@markup.strong"]                     = { bold = true },
      ["@markup.italic"]                     = { italic = true },
      ["@markup.strikethrough"]              = { strikethrough = true },
      ["@markup.underline"]                  = { underline = true },

      ["@markup.heading"]                    = { link = "Title" },
      ["@markup.heading.1"]                  = { fg = c.html_heading, bold = true },
      ["@markup.heading.2"]                  = { fg = c.html_heading, bold = true },
      ["@markup.heading.3"]                  = { fg = c.html_heading, bold = true },
      ["@markup.heading.4"]                  = { fg = c.html_heading, bold = true },
      ["@markup.heading.5"]                  = { fg = c.html_heading, bold = true },
      ["@markup.heading.6"]                  = { fg = c.html_heading, bold = true },

      ["@markup.quote"]                      = { italic = true },
      ["@markup.math"]                       = { link = "Special" },

      ["@markup.link"]                       = { fg = c.blue_cooler, underline = true, sp = c.blue_cooler },
      ["@markup.link.label"]                 = { link = "SpecialChar" },
      ["@markup.link.label.symbol"]          = { link = "Identifier" },
      ["@markup.link.url"]                   = { link = "Underlined" },

      ["@markup.raw"]                        = { link = "String" },
      ["@markup.raw.block"]                  = { link = "String" },

      ["@markup.list"]                       = { fg = c.fg_main },
      ["@markup.list.checked"]               = { fg = c.green },
      ["@markup.list.unchecked"]             = { fg = c.yellow },

      ["@diff.plus"]                         = { link = "DiffAdd" },
      ["@diff.minus"]                        = { link = "DiffDelete" },
      ["@diff.delta"]                        = { link = "DiffChange" },

      ["@tag"]                               = { link = "Tag" },
      ["@tag.attribute"]                     = { link = "@property" },
      ["@tag.delimiter"]                     = { link = "Delimiter" },
      ["@tag.tsx"]                           = { fg = c.red },
      ["@constructor.tsx"]                   = { fg = c.blue },
      ["@tag.delimiter.tsx"]                 = { fg = c.blue_cooler },

      ["@none"]                              = {},

      -- diff
      diffAdded                              = { link = "DiffAdd" },
      diffRemoved                            = { link = "DiffDelete" },
      diffChanged                            = { link = "DiffChange" },
      diffOldFile                            = { fg = c.yellow },
      diffNewFile                            = { fg = c.yellow_warmer },
      diffFile                               = { fg = c.cyan },
      diffLine                               = { fg = c.fg_alt },
      diffIndexLine                          = { fg = c.blue },

      -- GitSigns (JB style)
      GitSignsAdd                            = { fg = c.vcs_green, bg = bg_main },
      GitSignsChange                         = { fg = c.vcs_blue, bg = bg_main },
      GitSignsDelete                         = { fg = c.red, bg = bg_main },
      GitSignsCurrentLineBlame               = { fg = c.gray_2 },

      -- fugitive
      gitcommitDiscardedFile                 = { fg = c.red },
      gitcommitUntrackedFile                 = { fg = c.red },
      gitcommitSelectedFile                  = { fg = c.green },

      -- nvim-dap
      DapStoppedLine                         = { bg = "#393B40", underline = true },
      DapStoppedSign                         = { fg = c.bg_main, bg = c.fg_main },
      DapBreakpoint                          = { bg = c.bg_main },

      -- nvim-treesitter-context
      TreesitterContext                      = { bg = c.bg_main },
      TreesitterContextLineNumber            = { fg = c.gray_1, bg = c.bg_main },
      TreesitterContextSeparator             = { fg = c.border },

      -- BlinkCmp
      BlinkCmpMenu                           = { fg = c.fg_status_line_active, bg = bg_main },
      BlinkCmpLabelMatch                     = { fg = c.yellow, bold = false },
      BlinkCmpGhostText                      = { link = "Comment" },
      BlinkCmpMenuBorder                     = { link = "FloatBorder" },
      BlinkCmpDocBorder                      = { link = "FloatBorder" },
      BlinkCmpSignatureHelpBorder            = { link = "FloatBorder" },

      -- BlinkCmpKindStruct                     = { fg = c.yellow, bg = c.bg_main },
      -- BlinkCmpKindFunction                   = { fg = c.blue, bg = c.bg_main },
      -- BlinkCmpKindText                       = { fg = c.yellow_warmer, bg = c.bg_main },
      -- BlinkCmpKindClass                      = { fg = c.yellow, bg = c.bg_main },
      -- BlinkCmpKindValue                      = { fg = c.yellow_warmer, bg = c.bg_main },
      -- BlinkCmpKindEnum                       = { fg = c.yellow, bg = c.bg_main },
      -- BlinkCmpKindInterface                  = { fg = c.yellow, bg = c.bg_main },
      -- BlinkCmpKindMethod                     = { fg = c.cyan, bg = c.bg_main },
      -- BlinkCmpKindUnit                       = { fg = c.red, bg = c.bg_main },
      -- BlinkCmpKindConstant                   = { fg = c.fg_main, bg = c.bg_main },
      -- BlinkCmpKindField                      = { fg = c.blue, bg = c.bg_main },
      -- BlinkCmpKindModule                     = { fg = c.yellow, bg = c.bg_main },
      -- BlinkCmpKindKeyword                    = { fg = c.blue, bg = c.bg_main },
      -- BlinkCmpKindEnumMember                 = { fg = c.fg_main, bg = c.bg_main },
      -- BlinkCmpKindProperty                   = { fg = c.blue, bg = c.bg_main },
      -- BlinkCmpKindOperator                   = { fg = c.yellow_warmer, bg = c.bg_main },
      -- BlinkCmpKindReference                  = { fg = c.fg_main, bg = c.bg_main },
      -- BlinkCmpKindSnippet                    = { fg = c.fg_main, bg = c.bg_main },
      -- BlinkCmpKindTypeParameter              = { fg = c.yellow, bg = c.bg_main },
      -- BlinkCmpKindVariable                   = { fg = c.fg_main, bg = c.bg_main },

      -- FzfLua (JB style)
      FzfLuaCursor                           = { bg = c.bg_alt },
      FzfLuaBorder                           = { link = "FloatBorder" },
      FzfLuaFzfMatch                         = { fg = c.yellow, bold = true },
      FzfLuaFzfSeparator                     = { fg = c.bg_main, bg = c.bg_main },
      FzfLuaBackdrop                         = { bg = bg_main },
      FzfLuaNormal                           = { link = "Normal" },
      FzfLuaFzfNormal                        = { bg = c.bg_main },
      FzfLuaTitle                            = { fg = c.fg_dim, bg = bg_main },
      FzfLuaHeaderBind                       = { fg = c.gold },
      FzfLuaHeaderText                       = { fg = c.yellow },
      FzfLuaPathColNr                        = { fg = c.cyan },
      FzfLuaPathLineNr                       = { fg = c.green_cooler },
      FzfLuaBufName                          = { fg = c.blue },
      FzfLuaBufNr                            = { fg = c.gold },
      FzfLuaBufFlagCur                       = { fg = c.yellow },
      FzfLuaBufFlagAlt                       = { fg = c.cyan },
      FzfLuaTabTitle                         = { fg = c.cyan },
      FzfLuaTabMarker                        = { fg = c.gold },
      FzfLuaLiveSym                          = { fg = c.gold },
      FzfLuaFzfPointer                       = { link = "TerminalNormal" },
      FzfLuaLivePrompt                       = { fg = c.fg_main },
      FzfLuaBackDrop                         = { bg = c.bg_main },
      TitleFzf                               = { fg = c.bg_status_line_active, bg = c.bg_status_line_active },
      fzf1                                   = { link = "StatusLine" },
      fzf2                                   = { link = "StatusLine" },
      fzf3                                   = { link = "StatusLine" },

      -- Telescope
      TelescopeBorder                        = { link = "FloatBorder" },

      -- headlines / render-markdown
      CodeBlock                              = { bg = c.bg_dim },
      Headline                               = { bg = c.bg_blue_nuanced },
      Headline1                              = { bg = c.bg_blue_nuanced },
      Headline2                              = { bg = c.bg_yellow_nuanced },
      Headline3                              = { bg = c.bg_magenta_nuanced },
      Headline4                              = { bg = c.bg_green_nuanced },
      Headline5                              = { bg = c.bg_red_nuanced },
      Headline6                              = { bg = c.bg_cyan_nuanced },
      RenderMarkdownCodeInline               = { link = "markdownCode" },
      RenderMarkdownCode                     = { link = "markdownCodeBlock" },
      RenderMarkdownH1                       = { link = "@markup.heading.1" },
      RenderMarkdownH2                       = { link = "@markup.heading.2" },
      RenderMarkdownH3                       = { link = "@markup.heading.3" },
      RenderMarkdownH4                       = { link = "@markup.heading.4" },
      RenderMarkdownH5                       = { link = "@markup.heading.5" },
      RenderMarkdownH6                       = { link = "@markup.heading.6" },
      RenderMarkdownH1Bg                     = { fg = c.blue, bg = c.bg_blue_nuanced },
      RenderMarkdownH2Bg                     = { fg = c.yellow, bg = c.bg_yellow_nuanced },
      RenderMarkdownH3Bg                     = { fg = c.magenta, bg = c.bg_magenta_nuanced },
      RenderMarkdownH4Bg                     = { fg = c.green, bg = c.bg_green_nuanced },
      RenderMarkdownH5Bg                     = { fg = c.red, bg = c.bg_red_nuanced },
      RenderMarkdownH6Bg                     = { fg = c.cyan_warmer, bg = c.bg_cyan_nuanced },

      -- indent-blankline (JB style)
      IndentBlanklineChar                    = { fg = c.indent_guide, nocombine = true },
      IndentBlanklineContextChar             = { fg = c.blue, nocombine = true },
      IblIndent                              = { fg = c.indent_guide, nocombine = true },
      IblScope                               = { fg = c.blue, nocombine = true },

      -- NeoVim (JB style)
      healthError                            = { fg = c.red },
      healthSuccess                          = { fg = c.green_cooler },
      healthWarning                          = { fg = c.yellow },

      -- Yanky
      YankyPut                               = { link = "IncSearch" },
      YankyYanked                            = { link = "IncSearch" },

      -- Mini
      MiniTablineCurrent                     = { fg = c.gray_7, bg = c.pmenu_sel_fg, underline = true, sp = c.accent_blue },
      MiniTablineFill                        = { fg = c.border, bg = c.pmenu_sel_fg, underline = true, sp = c.border },
      MiniTablineHidden                      = { fg = c.fg_dim, bg = c.pmenu_sel_fg, underline = true, sp = c.border },
      MiniTablineModifiedCurrent             = { fg = c.blue, bg = c.pmenu_sel_fg, underline = true, sp = c.accent_blue },
      MiniTablineModifiedHidden              = { bg = c.pmenu_sel_fg, fg = c.blue, underline = true, sp = c.border },
      MiniTablineModifiedVisible             = { fg = c.blue, bg = c.pmenu_sel_fg, underline = true, sp = c.border },
      MiniTablineTabpagesection              = { bg = c.pmenu_sel_fg, fg = c.fg_dim, underline = true, sp = c.border },
      MiniTablineVisible                     = { fg = c.fg_main, bg = c.pmenu_sel_fg, underline = true, sp = c.border },
      MiniIndentScopeSymbol                  = { fg = c.border },

      -- mini.diff (JB style)
      MiniDiffSignAdd                        = { fg = c.vcs_green, bg = bg_main },
      MiniDiffSignChange                     = { fg = c.vcs_blue, bg = bg_main },
      MiniDiffSignDelete                     = { fg = c.gray_3, bg = bg_main },

      -- Language specific
      -- C
      cIncluded                              = { link = "Include" },
      cOperator                              = { link = "Operator" },
      cPreCondit                             = { link = "PreCondit" },
      cConstant                              = { link = "Constant" },
      cBlock                                 = { fg = c.fg_main },
      ["@keyword.function.c"]                = { fg = c.yellow_warmer, bold = false },
      ["@keyword.return.c"]                  = { fg = c.yellow_warmer, bold = false },
      ["@lsp.type.macro.c"]                  = { fg = c.blue },
      ["@keyword.conditional.ternary.c"]     = { link = "Operator" },

      -- CSS
      cssAttributeSelector                   = { link = "Attribute" },
      cssDefinition                          = { fg = c.fg_main },
      cssIdentifier                          = { fg = c.fg_main, underline = true },
      cssStringQ                             = { fg = c.fg_main },
      cssAttr                                = { link = "Keyword" },
      cssBraces                              = { link = "Delimiter" },
      cssClassName                           = { link = "Type" },
      cssColor                               = { link = "Number" },
      cssProp                                = { link = "cssDefinition" },
      cssPseudoClass                         = { link = "cssDefinition" },
      cssPseudoClassId                       = { link = "cssPseudoClass" },
      cssVendor                              = { link = "Keyword" },

      -- JavaScript/TypeScript
      jsGlobalNodeObjects                    = { fg = c.cyan },
      jsBrackets                             = { link = "Delimiter" },
      jsFuncCall                             = { link = "Function" },
      jsFuncParens                           = { link = "Delimiter" },
      jsThis                                 = { link = "Keyword" },
      jsNoise                                = { link = "Delimiter" },
      jsPrototype                            = { link = "Keyword" },
      jsRegexpString                         = { link = "SpecialChar" },

      typescriptBOMWindowMethod              = { fg = c.yellow },
      typescriptClassName                    = { link = "Type" },
      typescriptDecorator                    = { fg = c.yellow_faint },
      typescriptInterfaceName                = { fg = c.fg_main, bold = true },
      typescriptRegexpString                 = { fg = c.yellow_warmer },
      typescriptOperator                     = { link = "Operator" },
      typescriptBinaryOp                     = { link = "Operator" },
      typescriptAssign                       = { link = "Operator" },
      typescriptMember                       = { link = "Identifier" },
      typescriptDOMStorageMethod             = { link = "Identifier" },
      typescriptArrowFuncArg                 = { link = "Identifier" },
      typescriptGlobal                       = { link = "typescriptClassName" },
      typescriptBOMWindowProp                = { link = "Function" },
      typescriptArrowFuncDef                 = { link = "Function" },
      typescriptAliasDeclaration             = { link = "Function" },
      typescriptPredefinedType               = { link = "Type" },
      typescriptTypeReference                = { link = "typescriptClassName" },
      typescriptTypeAnnotation               = { link = "Structure" },
      typescriptDocNamedParamType            = { link = "SpecialComment" },
      typescriptDocNotation                  = { link = "Keyword" },
      typescriptDocTags                      = { link = "Keyword" },
      typescriptImport                       = { link = "Keyword" },
      typescriptExport                       = { link = "Keyword" },
      typescriptTry                          = { link = "Keyword" },
      typescriptVariable                     = { link = "Keyword" },
      typescriptBraces                       = { link = "Normal" },
      typescriptObjectLabel                  = { link = "Normal" },
      typescriptCall                         = { link = "Normal" },
      typescriptClassHeritage                = { link = "typescriptClassName" },
      typescriptFuncTypeArrow                = { link = "Structure" },
      typescriptMemberOptionality            = { link = "Structure" },
      typescriptNodeGlobal                   = { link = "typescriptGlobal" },
      typescriptTypeBrackets                 = { link = "Structure" },

      -- TSX
      tsxAttrib                              = { fg = c.yellow_faint },
      tsxEqual                               = { link = "Operator" },
      tsxIntrinsicTagName                    = { link = "htmlTag" },
      tsxTagName                             = { link = "tsxIntrinsicTagName" },

      -- Java
      javaDocTags                            = { fg = c.fg_main },
      javaCommentTitle                       = { link = "Comment" },
      javaScriptBraces                       = { link = "Delimiter" },
      javaScriptIdentifier                   = { link = "Keyword" },
      javaScriptNumber                       = { link = "Number" },

      -- Python
      pythonBuiltin                          = { link = "Type" },
      pythonEscape                           = { link = "SpecialChar" },

      -- Ruby
      rubyConstant                           = { fg = c.blue },
      rubySymbol                             = { fg = c.blue, bold = true },
      rubyAttribute                          = { link = "Attribute" },
      rubyBlockParameterList                 = { link = "Operator" },
      rubyInterpolationDelimiter             = { link = "Keyword" },
      rubyKeywordAsMethod                    = { link = "Function" },
      rubyLocalVariableOrMethod              = { link = "Function" },
      rubyPseudoVariable                     = { link = "Keyword" },
      rubyRegexp                             = { link = "SpecialChar" },

      -- Rust
      rustAttribute                          = { link = "Attribute" },
      rustEnum                               = { fg = c.fg_main, bold = true },
      rustMacro                              = { fg = c.yellow, bold = true },
      rustModPath                            = { fg = c.fg_main },
      rustPanic                              = { fg = c.yellow_warmer, bold = true },
      rustTrait                              = { fg = c.fg_main },
      rustCommentLineDoc                     = { link = "Comment" },
      rustDerive                             = { link = "rustAttribute" },
      rustEnumVariant                        = { link = "rustEnum" },
      rustEscape                             = { link = "SpecialChar" },
      rustQuestionMark                       = { link = "Keyword" },
      ["@module.rust"]                       = { link = "Identifier" },

      -- Go
      goBuiltins                             = { fg = c.fg_main },
      goConstants                            = { link = "Keyword" },

      -- PHP
      phpClasses                             = { fg = c.fg_main },
      phpDocTags                             = { fg = c.fg_main },
      phpDocCustomTags                       = { link = "phpDocTags" },
      phpMemberSelector                      = { link = "Keyword" },
      phpClass                               = { link = "Type" },
      phpClassImplements                     = { fg = c.fg_main, bold = true },
      phpClassExtends                        = { link = "phpClass" },
      phpFunction                            = { link = "Function" },
      phpMethod                              = { link = "Function" },
      phpUseClass                            = { link = "phpClass" },

      -- JSON
      jsonKeyword                            = { fg = c.blue },
      jsonCommentError                       = { link = "Comment" },

      -- XML
      xmlAttrib                              = { fg = c.yellow_faint },
      xmlCdataStart                          = { fg = c.border, bold = true },
      xmlNamespace                           = { fg = c.fg_main },
      xmlAttribPunct                         = { link = "Delimiter" },
      xmlCdata                               = { link = "Comment" },
      xmlCdataCdata                          = { link = "xmlCdataStart" },
      xmlCdataEnd                            = { link = "xmlCdataStart" },
      xmlEndTag                              = { link = "xmlTagName" },
      xmlProcessingDelim                     = { link = "Keyword" },
      xmlTagName                             = { link = "Keyword" },

      -- YAML
      yamlBlockMappingKey                    = { fg = c.blue },
      yamlBool                               = { link = "Keyword" },
      yamlDocumentStart                      = { link = "Keyword" },
      yamlKey                                = { fg = c.blue },

      -- Vim
      vimAugroup                             = { fg = c.fg_main },
      vimMapRhs                              = { fg = c.fg_main },
      vimNotation                            = { fg = c.fg_main },
      vimFunc                                = { link = "Function" },
      vimFunction                            = { link = "Function" },
      vimUserFunc                            = { link = "Function" },
      ["@variable.parameter.vimdoc"]         = { fg = c.cyan },

      -- TeX/LaTeX
      texDelim                               = { fg = c.fg_main },
      texEnvArgName                          = { fg = c.yellow_warmer, bold = true },
      texFileOpt                             = { fg = c.yellow_warmer },
      texFileArg                             = { fg = c.green },
      texTCBZone                             = { fg = c.yellow },

      ArtioNormal                            = { bg = c.bg_main },
      ArtioSel                               = { bg = c.bg_hl_line },

      SnacksWinSeparator                     = { fg = c.winsep, bg = c.bg_main },

      BufferLineOffsetSeparator              = { fg = c.winsep, bg = c.bg_main },
      BufferLineOffsetExplorer               = { link = "SidebarNormal" },
      BufferLineOffset                       = { link = "SidebarNormal" },

      SnacksPickerGitStatusUntracked         = { fg = mod(c.fg_dim, 20) },
      SnacksImageMath                        = { fg = "#90a0b5" },
      SnacksIndentScope                      = { fg = mod(c.fg_dim, -30) },
      SnacksIndent                           = { fg = mod(c.fg_dim, -60) },

      -- Zig
      ["@attribute.zig"]                     = { link = "Keyword" },
    })
  else
    -- Light and dark_tinted use modus-style highlights
    set_highlights({
      -- UI
      Normal                           = { fg = c.fg_main, bg = bg_main },
      NormalNC                         = { fg = c.fg_main, bg = bg_main },
      NormalSB                         = { fg = c.fg_sidebar, bg = c.bg_sidebar },
      TerminalNormal                   = { bg = c.bg_dim },
      NormalFloat                      = { fg = c.fg_active, bg = bg_main },
      FloatBorder                      = { fg = c.border, bg = bg_main },
      FloatTitle                       = { fg = c.border_highlight, bg = bg_main },
      Folded                           = { fg = c.green_faint, bg = c.bg_dim },
      LineNr                           = { fg = c.border, bg = c.linenr_bg },
      LineNrAbove                      = { fg = c.fg_dim, bg = c.linenr_bg },
      LineNrBelow                      = { fg = c.fg_dim, bg = c.linenr_bg },
      CursorLineNr                     = { fg = c.fg_active, bg = c.linenr_bg, bold = true },
      SignColumn                       = { fg = c.fg_dim, bg = c.linenr_bg },
      CursorLine                       = { fg = NONE, bg = c.bg_hl_line },
      CursorColumn                     = { fg = NONE, bg = c.bg_hl_line },
      NonText                          = { fg = c.fg_dim },
      ErrorMsg                         = { fg = c.fg_main, bg = c.bg_red_intense },
      Conceal                          = { fg = c.yellow_faint },
      Cursor                           = { fg = c.bg_main, bg = c.cursor },
      lCursor                          = { link = "Cursor" },
      CursorIM                         = { link = "Cursor" },
      ColorColumn                      = { fg = c.fg_main, bg = c.bg_dim },
      FoldColumn                       = { fg = c.fg_inactive, bg = c.bg_inactive },
      Search                           = { fg = c.fg_main, bg = c.bg_green_intense },
      IncSearch                        = { fg = c.fg_main, bg = c.bg_yellow_intense },
      CurSearch                        = { link = "IncSearch" },
      Substitute                       = { fg = c.fg_main, bg = c.bg_red_intense },
      QuickFixLine                     = { link = "Visual" },
      Pmenu                            = { fg = c.fg_active, bg = bg_main },
      PmenuSel                         = { bg = c.bg_completion },
      PmenuSbar                        = { fg = c.fg_active, bg = c.bg_dim },
      PmenuThumb                       = { bg = c.border },
      PmenuBorder                      = { link = "FloatBorder" },
      Menu                             = { link = "Pmenu" },
      Directory                        = { fg = c.blue },
      Title                            = { fg = c.fg_alt, bold = true },
      Visual                           = { bg = c.bg_hl_line },
      VisualNOS                        = { link = "Visual" },
      WildMenu                         = { fg = c.fg_main, bg = c.visual },
      Whitespace                       = { link = "NonText" },
      StatusLine                       = { fg = c.fg_status_line_active, bg = c.bg_status_line_active },
      StatusLineNC                     = { fg = c.fg_status_line_inactive, bg = c.bg_status_line_active },
      TabLine                          = { fg = c.border, bg = c.bg_tab_bar, underline = true, sp = mod(c.bg_status_line_active, -5) },
      TabLineSel                       = { fg = c.fg_main, bg = c.bg_status_line_active, bold = true, underline = true, sp = mod(c.bg_status_line_active, -5) },
      TabLineFill                      = { fg = c.border, bg = c.bg_tab_bar, underline = true, sp = mod(c.bg_status_line_active, -5) },
      WinBar                           = { link = "TabLineSel" },
      WinBarNC                         = { link = "TabLine" },
      EndOfBuffer                      = { fg = c.fg_inactive },
      MatchParen                       = { fg = c.fg_main, bg = c.bg_paren_match },
      ModeMsg                          = { fg = c.fg_main },
      MsgArea                          = { fg = c.fg_main },
      MoreMsg                          = { fg = c.blue },
      VertSplit                        = { fg = c.border },
      WinSeparator                     = { fg = c.winsep, bold = true },
      DiffAdd                          = { fg = c.fg_added, bg = c.bg_added },
      DiffDelete                       = { fg = c.fg_removed, bg = c.bg_removed },
      DiffChange                       = { fg = c.fg_changed, bg = c.bg_changed },
      DiffText                         = { fg = c.fg_changed, bg = c.bg_changed },
      SpecialKey                       = { fg = c.fg_dim },
      SpellBad                         = { sp = c.error, undercurl = true },
      SpellCap                         = { sp = c.warning, undercurl = true },
      SpellLocal                       = { sp = c.info, undercurl = true },
      SpellRare                        = { sp = c.hint, undercurl = true },
      WarningMsg                       = { fg = c.warning },
      Question                         = { fg = c.blue },
      Scrollbar                        = { link = "PmenuSbar" },
      ScrollbarThumb                   = { fg = c.border },
      LineNrSeparator                  = { fg = c.winsep },

      -- User1                            = { fg = c.red_warmer, bold = true },
      -- User2                            = { fg = c.blue_warmer, bold = true },
      -- User3                            = { fg = c.fg_main, bold = true },
      -- User5                            = { fg = c.blue_warmer, bg = c.bg_status_line_active, bold = true },
      -- User6                            = { fg = c.fg_main, bg = c.bg_status_line_active },
      -- User7                            = { fg = c.fg_main, bold = true },
      -- User8                            = { bg = c.bg_status_line_active },
      -- User9                            = { fg = c.bg_main, bg = c.blue_warmer, bold = false },

      -- Syntax
      Comment                          = { fg = c.comment, italic = true },
      String                           = { fg = c.string_fg },
      Character                        = { fg = c.blue_warmer },
      Boolean                          = { fg = c.bool_fg, bold = true },
      Statement                        = { fg = c.magenta_cooler },
      Conditional                      = { fg = c.blue_warmer },
      Repeat                           = { fg = c.magenta_cooler },
      Label                            = { fg = c.cyan },
      Keyword                          = { fg = c.blue_warmer },
      Exception                        = { fg = c.magenta_cooler },
      StorageClass                     = { fg = c.magenta_cooler },
      Structure                        = { fg = c.magenta_cooler },
      Constant                         = { fg = c.rust },
      Function                         = { fg = c.func_bg, bold = true },
      Identifier                       = { fg = c.blue_faint },
      PreProc                          = { fg = c.rust },
      Include                          = { fg = c.magenta_cooler },
      Define                           = { fg = c.red_cooler },
      Macro                            = { fg = c.blue_warmer },
      PreCondit                        = { fg = c.red_cooler },
      Todo                             = { fg = c.magenta, bold = true },
      Type                             = { fg = c.cyan_cooler },
      TypeDef                          = { fg = c.cyan_warmer },
      Number                           = { fg = c.blue_faint },
      Float                            = { link = "Number" },
      Operator                         = { fg = c.fg_main },
      Tag                              = { fg = c.magenta },
      Delimiter                        = { fg = c.fg_main },
      Special                          = { fg = c.magenta_cooler, bold = true },
      SpecialChar                      = { link = "Special" },
      Underlined                       = { fg = c.fg_alt, underline = true },
      Error                            = { fg = c.fg_main, bg = c.bg_red_intense },

      -- Misc syntax
      qfLineNr                         = { fg = c.fg_dim },
      qfFileName                       = { fg = c.blue },
      qfNormal                         = { bg = c.bg_dim },

      htmlH1                           = { fg = c.blue, bold = true },
      htmlH2                           = { fg = c.yellow, bold = true },
      htmlH3                           = { fg = c.magenta_cooler, bold = true },
      htmlH4                           = { fg = c.green, bold = true },
      htmlH5                           = { fg = c.red, bold = true },
      htmlH6                           = { fg = c.cyan_warmer, bold = true },

      mkdCodeDelimiter                 = { bg = c.bg_alt, fg = c.fg_main },
      mkdCodeStart                     = { fg = c.cyan_cooler, bold = true },
      mkdCodeEnd                       = { fg = c.cyan_cooler, bold = true },

      markdownHeadingDelimiter         = { fg = c.rust, bold = true },
      markdownCode                     = { fg = c.cyan_cooler },
      markdownCodeBlock                = { fg = c.cyan_cooler },
      markdownLinkText                 = { fg = c.blue, underline = true },
      markdownH1                       = { link = "@markup.heading.1" },
      markdownH2                       = { link = "@markup.heading.2" },
      markdownH3                       = { link = "@markup.heading.3" },
      markdownH4                       = { link = "@markup.heading.4" },
      markdownH5                       = { link = "@markup.heading.5" },
      markdownH6                       = { link = "@markup.heading.6" },

      -- LSP
      LspCodeLens                      = { fg = c.comment },
      LspInlayHint                     = { bg = bg_main, fg = c.comment, italic = true },
      LspReferenceText                 = { bg = c.bg_blue_intense, fg = c.fg_main },
      LspReferenceRead                 = { bg = c.bg_blue_intense, fg = c.fg_main },
      LspReferenceWrite                = { bg = c.bg_blue_intense, fg = c.fg_main },
      LspSignatureActiveParameter      = { link = "Visual" },
      LspInfoBorder                    = { fg = c.border_highlight, bg = bg_main },

      -- Diagnostics
      DiagnosticError                  = { fg = c.error, bold = true },
      DiagnosticWarn                   = { fg = c.warning, bold = true },
      DiagnosticInfo                   = { fg = c.info, bold = true },
      DiagnosticHint                   = { fg = c.hint, bold = true },
      DiagnosticOk                     = { fg = c.ok, bold = true },
      DiagnosticUnnecessary            = { fg = c.fg_dim },

      DiagnosticSignError              = { fg = c.error, bold = true },
      DiagnosticSignWarn               = { fg = c.warning, bold = true },
      DiagnosticSignInfo               = { fg = c.info, bold = true },
      DiagnosticSignHint               = { fg = c.hint, bold = true },
      DiagnosticSignOk                 = { fg = c.ok, bold = true },

      DiagnosticVirtualTextError       = { fg = c.error, bold = true },
      DiagnosticVirtualTextWarn        = { fg = c.warning, bold = true },
      DiagnosticVirtualTextInfo        = { fg = c.info, bold = true },
      DiagnosticVirtualTextHint        = { fg = c.hint, bold = true },
      DiagnosticVirtualTextOk          = { fg = c.ok, bold = true },

      DiagnosticUnderlineError         = { undercurl = true, sp = c.error },
      DiagnosticUnderlineWarn          = { undercurl = true, sp = c.warning },
      DiagnosticUnderlineInfo          = { undercurl = true, sp = c.info },
      DiagnosticUnderlineHint          = { undercurl = true, sp = c.hint },
      DiagnosticUnderlineOk            = { undercurl = true, sp = c.ok },

      TreesitterContext                = { bg = bg_main },
      TreesitterContextSeparator       = { fg = c.bg_status_line_active },
      TreesitterContextLineNumber      = { fg = c.winsep },

      -- Treesitter
      ["@variable"]                    = {},
      ["@variable.builtin"]            = { link = "Conditional" },
      ["@variable.parameter"]          = { fg = c.cyan },
      ["@variable.parameter.builtin"]  = { fg = c.cyan_faint },
      ["@variable.member"]             = { link = "Identifier" },

      ["@constant"]                    = { link = "Constant" },
      ["@constant.builtin"]            = { link = "Special" },
      ["@constant.macro"]              = { link = "Define" },

      ["@module"]                      = { link = "Include" },
      ["@module.builtin"]              = { link = "Conditional" },
      ["@label"]                       = { link = "Label" },

      ["@string"]                      = { link = "String" },
      ["@string.documentation"]        = { fg = c.green_faint, italic = true },
      ["@string.regex"]                = { fg = c.green_cooler },
      ["@string.escape"]               = { fg = c.yellow_faint },
      ["@string.special"]              = { fg = c.red_faint },
      ["@string.special.symbol"]       = { link = "Identifier" },
      ["@string.special.path"]         = { fg = c.blue },
      ["@string.special.url"]          = { fg = c.cyan_cooler },

      ["@character"]                   = { link = "Character" },
      ["@character.special"]           = { link = "SpecialChar" },

      ["@boolean"]                     = { link = "Boolean" },
      ["@number"]                      = { link = "Number" },
      ["@number.float"]                = { link = "Float" },

      ["@type"]                        = { link = "Type" },
      ["@type.builtin"]                = { link = "Type" },
      ["@type.definition"]             = { link = "Typedef" },

      ["@attribute"]                   = { link = "PreProc" },
      ["@attribute.builtin"]           = { link = "PreProc" },
      ["@property"]                    = { link = "@field" },

      ["@function"]                    = { link = "Function" },
      ["@function.builtin"]            = { link = "Special" },
      ["@function.call"]               = { link = "Special" },
      ["@function.macro"]              = { link = "Macro" },

      ["@function.method"]             = { link = "Function" },
      ["@function.method.call"]        = { link = "@function.method" },

      ["@constructor"]                 = { fg = c.yellow_cooler },
      ["@operator"]                    = { link = "Operator" },

      ["@keyword"]                     = { link = "Keyword" },
      ["@keyword.coroutine"]           = { link = "@keyword" },
      ["@keyword.function"]            = { fg = c.blue_warmer },
      ["@keyword.operator"]            = { link = "@operator" },
      ["@keyword.import"]              = { link = "Include" },
      ["@keyword.type"]                = { link = "@type" },
      ["@keyword.modifier"]            = { link = "@keyword" },
      ["@keyword.repeat"]              = { link = "Repeat" },
      ["@keyword.return"]              = { link = "@keyword" },
      ["@keyword.debug"]               = { link = "Debug" },
      ["@keyword.exception"]           = { link = "Exception" },

      ["@keyword.conditional"]         = { link = "Conditional" },
      ["@keyword.conditional.ternary"] = { link = "Conditional" },

      ["@keyword.directive"]           = { link = "PreProc" },
      ["@keyword.directive.define"]    = { link = "Define" },

      ["@punctuation.delimiter"]       = { link = "Delimiter" },
      ["@punctuation.bracket"]         = { fg = c.fg_main },
      ["@punctuation.special"]         = { fg = c.fg_main },

      ["@comment"]                     = { link = "Comment" },
      ["@comment.documentation"]       = { link = "@string.documentation" },

      ["@comment.error"]               = { fg = c.error },
      ["@comment.warning"]             = { fg = c.warning },
      ["@comment.todo"]                = { link = "Todo" },
      ["@comment.note"]                = { fg = c.hint },

      ["@markup.strong"]               = { bold = true },
      ["@markup.italic"]               = { italic = true },
      ["@markup.strikethrough"]        = { strikethrough = true },
      ["@markup.underline"]            = { underline = true },

      ["@markup.heading"]              = { link = "Title" },
      ["@markup.heading.1"]            = { fg = c.blue, bold = true },
      ["@markup.heading.2"]            = { fg = c.yellow, bold = true },
      ["@markup.heading.3"]            = { fg = c.magenta_cooler, bold = true },
      ["@markup.heading.4"]            = { fg = c.green, bold = true },
      ["@markup.heading.5"]            = { fg = c.red, bold = true },
      ["@markup.heading.6"]            = { fg = c.cyan_warmer, bold = true },

      ["@markup.quote"]                = { italic = true },
      ["@markup.math"]                 = { link = "Special" },

      ["@markup.link"]                 = { fg = c.cyan_cooler },
      ["@markup.link.label"]           = { link = "SpecialChar" },
      ["@markup.link.label.symbol"]    = { link = "Identifier" },
      ["@markup.link.url"]             = { link = "Underlined" },

      ["@markup.raw"]                  = { link = "String" },
      ["@markup.raw.block"]            = { link = "String" },

      ["@markup.list"]                 = { fg = c.fg_main },
      ["@markup.list.checked"]         = { fg = c.green },
      ["@markup.list.unchecked"]       = { fg = c.yellow },

      ["@diff.plus"]                   = { link = "DiffAdd" },
      ["@diff.minus"]                  = { link = "DiffDelete" },
      ["@diff.delta"]                  = { link = "DiffChange" },

      ["@tag"]                         = { link = "Label" },
      ["@tag.attribute"]               = { link = "@property" },
      ["@tag.delimiter"]               = { link = "Delimiter" },

      ["@none"]                        = {},

      -- tsx
      ["@tag.tsx"]                     = { fg = c.red },
      ["@constructor.tsx"]             = { fg = c.blue },
      ["@tag.delimiter.tsx"]           = { fg = c.blue_cooler },

      -- diff
      diffAdded                        = { link = "DiffAdd" },
      diffRemoved                      = { link = "DiffDelete" },
      diffChanged                      = { link = "DiffChange" },
      diffOldFile                      = { fg = c.yellow },
      diffNewFile                      = { fg = c.yellow_warmer },
      diffFile                         = { fg = c.blue },
      diffLine                         = { fg = c.fg_alt },
      diffIndexLine                    = { fg = c.magenta },

      -- GitSigns
      GitSignsAdd                      = { fg = c.green_cooler, bg = c.bg_main },
      GitSignsChange                   = { fg = c.yellow, bg = c.bg_main },
      GitSignsDelete                   = { fg = c.red, bg = c.bg_main },
      GitSignsCurrentLineBlame         = { fg = c.border },

      -- Fzf Lua
      FzfLuaNormal                     = { link = "Normal" },
      FzfLuaFzfNormal                  = { bg = c.bg_main },
      FzfLuaFzfSeparator               = { fg = c.bg_main, bg = c.bg_main },
      FzfLuaBorder                     = { fg = c.border, bg = bg_main },
      FzfLuaTitle                      = { fg = c.fg_dim, bg = bg_main },
      FzfLuaHeaderBind                 = { fg = c.gold },
      FzfLuaHeaderText                 = { fg = c.yellow_cooler },
      FzfLuaPathColNr                  = { fg = c.cyan_cooler },
      FzfLuaPathLineNr                 = { fg = c.green_cooler },
      FzfLuaBufName                    = { fg = c.magenta_warmer },
      FzfLuaBufNr                      = { fg = c.gold },
      FzfLuaBufFlagCur                 = { fg = c.yellow_cooler },
      FzfLuaBufFlagAlt                 = { fg = c.cyan_cooler },
      FzfLuaTabTitle                   = { fg = c.blue_warmer },
      FzfLuaTabMarker                  = { fg = c.gold },
      FzfLuaLiveSym                    = { fg = c.gold },
      FzfLuaFzfPointer                 = { link = "TerminalNormal" },
      FzfLuaLivePrompt                 = { fg = c.fg_main },
      FzfLuaBackDrop                   = { bg = c.bg_main },
      TitleFzf                         = { fg = c.bg_status_line_active, bg = c.bg_status_line_active },
      fzf1                             = { link = "StatusLine" },
      fzf2                             = { link = "StatusLine" },
      fzf3                             = { link = "StatusLine" },

      -- Telescope
      TelescopeBorder                  = { link = "FloatBorder" },

      BlinkCmpMenuBorder               = { link = "FloatBorder" },
      BlinkCmpSignatureHelpBorder      = { link = "FloatBorder" },
      BlinkCmpDocBorder                = { link = "FloatBorder" },
      BlinkCmpLabelMatch               = { fg = c.blue_warmer, bold = true },
      BlinkCmpGhostText                = { link = "Comment" },

      -- headlines / render-markdown
      CodeBlock                        = { bg = c.bg_dim },
      Headline                         = { bg = c.bg_blue_nuanced },
      Headline1                        = { bg = c.bg_blue_nuanced },
      Headline2                        = { bg = c.bg_yellow_nuanced },
      Headline3                        = { bg = c.bg_magenta_nuanced },
      Headline4                        = { bg = c.bg_green_nuanced },
      Headline5                        = { bg = c.bg_red_nuanced },
      Headline6                        = { bg = c.bg_cyan_nuanced },
      RenderMarkdownCodeInline         = { link = "markdownCode" },
      RenderMarkdownCode               = { link = "markdownCodeBlock" },
      RenderMarkdownH1                 = { link = "@markup.heading.1" },
      RenderMarkdownH2                 = { link = "@markup.heading.2" },
      RenderMarkdownH3                 = { link = "@markup.heading.3" },
      RenderMarkdownH4                 = { link = "@markup.heading.4" },
      RenderMarkdownH5                 = { link = "@markup.heading.5" },
      RenderMarkdownH6                 = { link = "@markup.heading.6" },
      RenderMarkdownH1Bg               = { fg = c.blue, bg = c.bg_blue_nuanced },
      RenderMarkdownH2Bg               = { fg = c.yellow, bg = c.bg_yellow_nuanced },
      RenderMarkdownH3Bg               = { fg = c.magenta, bg = c.bg_magenta_nuanced },
      RenderMarkdownH4Bg               = { fg = c.green, bg = c.bg_green_nuanced },
      RenderMarkdownH5Bg               = { fg = c.red, bg = c.bg_red_nuanced },
      RenderMarkdownH6Bg               = { fg = c.cyan_warmer, bg = c.bg_cyan_nuanced },

      -- indent-blankline
      IndentBlanklineChar              = { fg = c.fg_dim, nocombine = true },
      IndentBlanklineContextChar       = { fg = c.magenta_cooler, nocombine = true },
      IblIndent                        = { fg = c.fg_dim, nocombine = true },
      IblScope                         = { fg = c.magenta_cooler, nocombine = true },

      -- NeoVim
      healthError                      = { fg = c.error },
      healthSuccess                    = { fg = c.green_cooler },
      healthWarning                    = { fg = c.warning },

      -- Yanky
      YankyPut                         = { link = "IncSearch" },
      YankyYanked                      = { link = "IncSearch" },

      -- Mini
      MiniTablineCurrent               = { fg = c.fg_main, bg = c.bg_tab_bar, bold = true, underline = true, sp = mod(c.bg_status_line_active, -5) },
      MiniTablineFill                  = { fg = c.border, bg = c.bg_tab_bar, underline = true, sp = mod(c.bg_status_line_active, -5) },
      MiniTablineHidden                = { fg = c.fg_dim, bg = c.bg_tab_bar, underline = true, sp = mod(c.bg_status_line_active, -5) },
      MiniTablineModifiedCurrent       = { fg = c.yellow_cooler, bg = c.bg_status_line_active, bold = true },
      MiniTablineModifiedHidden        = { bg = c.bg_tab_other, fg = c.yellow_faint },
      MiniTablineModifiedVisible       = { fg = c.yellow_cooler, bg = c.bg_alt },
      MiniTablineTabpagesection        = { bg = c.bg_tab_bar, fg = c.fg_main, underline = true, sp = mod(c.bg_status_line_active, -10) },
      MiniTablineVisible               = { fg = c.fg_main, bg = c.bg_alt },

      MiniIndentScopeSymbol            = { fg = c.bg_status_line_active },

      -- mini.diff
      MiniDiffSignAdd                  = { fg = c.fg_added_intense, bg = bg_main },
      MiniDiffSignChange               = { fg = c.fg_changed_intense, bg = bg_main },
      MiniDiffSignDelete               = { fg = c.fg_removed_intense, bg = bg_main },

      BufferLineOffset                 = { link = "SidebarNormal" },
    })
  end
end

-- Apply the theme
apply()

-- Re-apply when background changes (system light/dark mode toggle)
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    if vim.g.colors_name == "colourscheme" then
      apply()
    end
  end,
})
