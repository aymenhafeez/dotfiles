-- Standard Themes for Neovim
-- Port of https://github.com/protesilaos/standard-themes
--
-- Configuration (all optional):
--   vim.g.standard_themes_variant = "default" | "tinted"
--   vim.g.standard_themes_variant = { light = "adwaita", dark = "wombat" }
--   vim.g.standard_themes_light_variant = "standard-light" | "standard-light-tinted" | "standard-adwaita"
--   vim.g.standard_themes_dark_variant = "standard-dark" | "standard-dark-tinted" | "standard-wombat"

local theme_name = "standard-themes"

local function merge(base, override)
  return vim.tbl_deep_extend("force", {}, base, override)
end

local function clone(tbl)
  return vim.deepcopy(tbl)
end

local mod = require("utils").modify_colour

local raw_palettes = {
  standard_light = {
    bg_main = "#dddddd",
    fg_main = "#000000",
    bg_dim = "#ebebeb",
    fg_dim = "#7f7f7f",
    bg_alt = "#dcdcdc",
    fg_alt = "#193f8f",
    bg_active = "#bfbfbf",
    bg_inactive = "#f0f0f0",
    border = "#bababa",
    red = "#b3303a",
    red_warmer = "#e00033",
    red_cooler = "#ce2b50",
    red_faint = "#b22222",
    green = "#228b22",
    green_warmer = "#4f7400",
    green_cooler = "#008858",
    green_faint = "#61756c",
    yellow = "#a45f22",
    yellow_warmer = "#b6532f",
    yellow_cooler = "#a0522d",
    yellow_faint = "#76502a",
    blue = "#001faf",
    blue_warmer = "#3a5fcd",
    blue_cooler = "#0000ff",
    blue_faint = "#483d8b",
    magenta = "#721045",
    magenta_warmer = "#8b2252",
    magenta_cooler = "#800080",
    magenta_faint = "#8f4499",
    cyan = "#1f6fbf",
    cyan_warmer = "#2f8fab",
    cyan_cooler = "#008b8b",
    cyan_faint = "#3f7a80",
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
    bg_red_nuanced = "#fff1f0",
    bg_green_nuanced = "#ecf7ed",
    bg_yellow_nuanced = "#fff3da",
    bg_blue_nuanced = "#f3f3ff",
    bg_magenta_nuanced = "#fdf0ff",
    bg_cyan_nuanced = "#ebf6fa",
    bg_added = "#c0f8d0",
    bg_added_faint = "#d0ffe0",
    bg_added_refine = "#b4e8c4",
    fg_added = "#007200",
    bg_changed = "#ffdfa9",
    bg_changed_faint = "#ffefbf",
    bg_changed_refine = "#fac090",
    fg_changed = "#8d6a12",
    bg_removed = "#ffd8d5",
    bg_removed_faint = "#ffe9e9",
    bg_removed_refine = "#f3b5af",
    fg_removed = "#a02a2a",
    bg_mark_other = "#c0effa",
    fg_mark_other = "#1f6fb0",
    bg_mark_delete = "#ffd5ea",
    fg_mark_delete = "#b32230",
    bg_mark_select = "#fafa7b",
    fg_mark_select = "#805f00",
    bg_completion = "#bfe8ff",
    bg_popup = "#f2f2f4",
    bg_hover = "#aaeccf",
    bg_hover_secondary = "#ffff00",
    bg_hl_line = "#b4eeb4",
    bg_region = "#eedc82",
    bg_paren_match = "#40e0d0",
    bg_mode_line_active = "#b3b3b3",
    fg_mode_line_active = "#000000",
    border_mode_line_active = "#5a5a5a",
    bg_mode_line_inactive = "#e5e5e5",
    fg_mode_line_inactive = "#7f7f7f",
    border_mode_line_inactive = "#bababa",
    modeline_err = "#b02020",
    modeline_warning = "#5f1080",
    modeline_info = "#002fb0",
    underline_err = "#ef0f1f",
    underline_warning = "#bf5f00",
    underline_note = "#02af52",
    rainbow_0 = "#191970",
    semantic = {
      comment = "red_faint",
      constant = "cyan_cooler",
      keyword = "magenta_cooler",
      string = "magenta_warmer",
      type = "green",
      variable = "yellow_cooler",
      func = "blue_cooler",
      builtin = "blue_faint",
      preproc = "blue_faint",
      special = "cyan",
      err = "red_warmer",
      warning = "yellow_warmer",
      info = "green",
      hint = "cyan_faint",
      ok = "green_cooler",
      link = "blue_warmer",
      link_visited = "magenta",
    },
  },

  standard_dark = {
    bg_main = "#000000",
    fg_main = "#ffffff",
    bg_dim = "#272727",
    fg_dim = "#a6a6a6",
    bg_alt = "#363636",
    fg_alt = "#a0afef",
    bg_active = "#606060",
    bg_inactive = "#202020",
    border = "#606070",
    red = "#ff6f60",
    red_warmer = "#ff7f24",
    red_cooler = "#ff778f",
    red_faint = "#ee5c42",
    green = "#44cc44",
    green_warmer = "#7abd0f",
    green_cooler = "#98fb98",
    green_faint = "#61a06c",
    yellow = "#eedd82",
    yellow_warmer = "#fec43f",
    yellow_cooler = "#ffa07a",
    yellow_faint = "#dfb08f",
    blue = "#87ceff",
    blue_warmer = "#80aaff",
    blue_cooler = "#02cfff",
    blue_faint = "#b0c4de",
    magenta = "#df8faf",
    magenta_warmer = "#ff8fe7",
    magenta_cooler = "#ce82ff",
    magenta_faint = "#efafdf",
    cyan = "#00ffff",
    cyan_warmer = "#87cefa",
    cyan_cooler = "#7fffd4",
    cyan_faint = "#6acbcb",
    bg_red_intense = "#9d1f1f",
    bg_green_intense = "#2f822f",
    bg_yellow_intense = "#7a6100",
    bg_blue_intense = "#1640b0",
    bg_magenta_intense = "#7030af",
    bg_cyan_intense = "#2266ae",
    bg_red_subtle = "#620f2a",
    bg_green_subtle = "#00422a",
    bg_yellow_subtle = "#4a4000",
    bg_blue_subtle = "#242679",
    bg_magenta_subtle = "#552f5f",
    bg_cyan_subtle = "#004065",
    bg_red_nuanced = "#2c0614",
    bg_green_nuanced = "#001904",
    bg_yellow_nuanced = "#221000",
    bg_blue_nuanced = "#0f0e39",
    bg_magenta_nuanced = "#230631",
    bg_cyan_nuanced = "#041529",
    bg_added = "#00331f",
    bg_added_faint = "#002410",
    bg_added_refine = "#03492f",
    fg_added = "#4fb04f",
    bg_changed = "#323200",
    bg_changed_faint = "#281a00",
    bg_changed_refine = "#484800",
    fg_changed = "#e0cf03",
    bg_removed = "#4a1119",
    bg_removed_faint = "#320a0f",
    bg_removed_refine = "#751a1f",
    fg_removed = "#ff5f5f",
    bg_mark_other = "#002f4a",
    fg_mark_other = "#57cefa",
    bg_mark_delete = "#440d09",
    fg_mark_delete = "#ff5f60",
    bg_mark_select = "#333000",
    fg_mark_select = "#d0d082",
    bg_completion = "#254b5f",
    bg_popup = "#222222",
    bg_hover = "#457b2f",
    bg_hover_secondary = "#00688b",
    -- bg_hl_line = "#334815",
    bg_hl_line = mod("#111111", 20),
    bg_region = "#20009d",
    bg_paren_match = "#4f94cd",
    bg_mode_line_active = "#505050",
    fg_mode_line_active = "#ffffff",
    border_mode_line_active = "#959595",
    bg_mode_line_inactive = "#323232",
    fg_mode_line_inactive = "#a6a6a6",
    border_mode_line_inactive = "#606070",
    modeline_err = "#ff80af",
    modeline_warning = "#dfcf33",
    modeline_info = "#2fc82f",
    underline_err = "#df2f2f",
    underline_warning = "#c0b000",
    underline_note = "#22b022",
    rainbow_0 = "#afeeee",
    semantic = {
      comment = "red_warmer",
      constant = "cyan_cooler",
      keyword = "cyan",
      string = "yellow_cooler",
      type = "green_cooler",
      variable = "yellow",
      func = "cyan_warmer",
      builtin = "blue_faint",
      preproc = "blue_faint",
      special = "cyan",
      err = "red",
      warning = "yellow_warmer",
      info = "green",
      hint = "cyan_faint",
      ok = "green_cooler",
      link = "cyan",
      link_visited = "magenta_cooler",
    },
  },

  standard_light_tinted = {
    bg_main = "#eeecd9",
    fg_main = "#000000",
    bg_dim = "#e2d3ca",
    fg_dim = "#606060",
    bg_alt = "#d0bfb8",
    fg_alt = "#193f8f",
    bg_active = "#b09a90",
    bg_inactive = "#dedecd",
    border = "#9a7a7a",
    red = "#b3303a",
    red_warmer = "#e00033",
    red_cooler = "#ce2b50",
    red_faint = "#b22222",
    green = "#228b22",
    green_warmer = "#4f7400",
    green_cooler = "#008858",
    green_faint = "#61756c",
    yellow = "#a45f22",
    yellow_warmer = "#b6532f",
    yellow_cooler = "#a0522d",
    yellow_faint = "#76502a",
    blue = "#001faf",
    blue_warmer = "#3a5fcd",
    blue_cooler = "#0000ff",
    blue_faint = "#483d8b",
    magenta = "#721045",
    magenta_warmer = "#8b2252",
    magenta_cooler = "#800080",
    magenta_faint = "#8f4499",
    cyan = "#1f6fbf",
    cyan_warmer = "#2f8fab",
    cyan_cooler = "#008b8b",
    cyan_faint = "#3f7a80",
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
    bg_red_nuanced = "#fff1f0",
    bg_green_nuanced = "#ecf7ed",
    bg_yellow_nuanced = "#fff3da",
    bg_blue_nuanced = "#f3f3ff",
    bg_magenta_nuanced = "#fdf0ff",
    bg_cyan_nuanced = "#ebf6fa",
    bg_added = "#c3ebc1",
    bg_added_faint = "#d0eac0",
    bg_added_refine = "#acd6a5",
    fg_added = "#005000",
    bg_changed = "#ffdfa9",
    bg_changed_faint = "#ffe2bf",
    bg_changed_refine = "#fac090",
    fg_changed = "#553d00",
    bg_removed = "#f4c2c7",
    bg_removed_faint = "#f2d3d0",
    bg_removed_refine = "#f3b5a7",
    fg_removed = "#8f1313",
    bg_mark_other = "#c0effa",
    fg_mark_other = "#1f6fb0",
    bg_mark_delete = "#ffd5ea",
    fg_mark_delete = "#b32230",
    bg_mark_select = "#fafa7b",
    fg_mark_select = "#805f00",
    bg_completion = "#afc8df",
    bg_popup = "#e7e5ca",
    bg_hover = "#8acf9f",
    bg_hover_secondary = "#ffff00",
    bg_hl_line = "#b6ded0",
    bg_region = "#d0acb2",
    bg_paren_match = "#40aff0",
    bg_mode_line_active = "#cf93a0",
    fg_mode_line_active = "#000000",
    border_mode_line_active = "#7a5a50",
    bg_mode_line_inactive = "#d0baaf",
    fg_mode_line_inactive = "#503f3f",
    border_mode_line_inactive = "#b39590",
    modeline_err = "#b02020",
    modeline_warning = "#5f1080",
    modeline_info = "#002fb0",
    underline_err = "#ef0f1f",
    underline_warning = "#bf5f00",
    underline_note = "#02af52",
    cursor = "#aa0090",
    semantic = {
      comment = "red_faint",
      constant = "cyan_cooler",
      keyword = "magenta_cooler",
      string = "magenta_warmer",
      type = "green",
      variable = "yellow_cooler",
      func = "blue_cooler",
      builtin = "blue_faint",
      preproc = "blue_faint",
      special = "cyan",
      err = "red_warmer",
      warning = "yellow_warmer",
      info = "green",
      hint = "cyan_faint",
      ok = "green_cooler",
      link = "blue_warmer",
      link_visited = "magenta",
    },
  },

  standard_dark_tinted = {
    bg_main = "#182440",
    fg_main = "#ffffff",
    bg_dim = "#2e3355",
    fg_dim = "#a6a6a6",
    bg_alt = "#3f4560",
    fg_alt = "#ac90e0",
    bg_active = "#5f6580",
    bg_inactive = "#203348",
    border = "#707090",
    red = "#ff6f60",
    red_warmer = "#ff7f24",
    red_cooler = "#ff778f",
    red_faint = "#ee5c42",
    green = "#44cc44",
    green_warmer = "#7abd0f",
    green_cooler = "#98fb98",
    green_faint = "#61a06c",
    yellow = "#eedd82",
    yellow_warmer = "#fec43f",
    yellow_cooler = "#ffa07a",
    yellow_faint = "#dfb08f",
    blue = "#87ceff",
    blue_warmer = "#80aaff",
    blue_cooler = "#02cfff",
    blue_faint = "#b0c4de",
    magenta = "#df8faf",
    magenta_warmer = "#ff8fe7",
    magenta_cooler = "#ce82ff",
    magenta_faint = "#efafdf",
    cyan = "#00ffff",
    cyan_warmer = "#87cefa",
    cyan_cooler = "#7fffd4",
    cyan_faint = "#6acbcb",
    bg_red_intense = "#9d1f1f",
    bg_green_intense = "#2f822f",
    bg_yellow_intense = "#7a6100",
    bg_blue_intense = "#1640b0",
    bg_magenta_intense = "#7030af",
    bg_cyan_intense = "#2266ae",
    bg_red_subtle = "#620f2a",
    bg_green_subtle = "#00422a",
    bg_yellow_subtle = "#4a4000",
    bg_blue_subtle = "#242679",
    bg_magenta_subtle = "#552f5f",
    bg_cyan_subtle = "#004065",
    bg_red_nuanced = "#2c0614",
    bg_green_nuanced = "#001904",
    bg_yellow_nuanced = "#221000",
    bg_blue_nuanced = "#0f0e39",
    bg_magenta_nuanced = "#230631",
    bg_cyan_nuanced = "#041529",
    bg_added = "#12522f",
    bg_added_faint = "#0f3a30",
    bg_added_refine = "#17623f",
    fg_added = "#4fb04f",
    bg_changed = "#424200",
    bg_changed_faint = "#383a00",
    bg_changed_refine = "#684f20",
    fg_changed = "#e0cf03",
    bg_removed = "#602119",
    bg_removed_faint = "#4e0f1f",
    bg_removed_refine = "#792f2f",
    fg_removed = "#ff5f5f",
    bg_mark_other = "#223f6a",
    fg_mark_other = "#57defa",
    bg_mark_delete = "#5a201f",
    fg_mark_delete = "#ff7f60",
    bg_mark_select = "#494000",
    fg_mark_select = "#d0d082",
    bg_completion = "#406a70",
    bg_popup = mod("#1d2c4f", 20),
    bg_hover = "#35705f",
    bg_hover_secondary = "#00688b",
    bg_hl_line = "#304845",
    bg_region = "#4f2f99",
    bg_paren_match = "#4f94cd",
    -- bg_mode_line_active = "#5b59b2",
    bg_mode_line_active = mod("#182440", -30),
    fg_mode_line_active = "#ffffff",
    border_mode_line_active = "#9595b5",
    bg_mode_line_inactive = "#353a52",
    fg_mode_line_inactive = "#a6a6a6",
    border_mode_line_inactive = "#606070",
    modeline_err = "#ff80af",
    modeline_warning = "#dfcf33",
    modeline_info = "#2fc82f",
    underline_err = "#df2f2f",
    underline_warning = "#c0b000",
    underline_note = "#22b022",
    cursor = "#d072f0",
    semantic = {
      comment = "red_warmer",
      constant = "cyan_cooler",
      keyword = "cyan",
      string = "yellow_cooler",
      type = "green_cooler",
      variable = "yellow",
      func = "cyan_warmer",
      builtin = "blue_faint",
      preproc = "blue_faint",
      special = "cyan",
      err = "red",
      warning = "yellow_warmer",
      info = "green",
      hint = "cyan_faint",
      ok = "green_cooler",
      link = "cyan",
      link_visited = "magenta_cooler",
    },
  },

  standard_adwaita = {
    bg_main = "#ededed",
    fg_main = "#2e3436",
    red = "#b50000",
    red_warmer = "#c01c28",
    red_faint = "#a52a2a",
    red_intense = "#f5666d",
    green = "#4cb64a",
    green_warmer = "#4e9a06",
    green_cooler = "#2f8b58",
    green_faint = "#9cbb43",
    yellow = "#c88800",
    yellow_intense = "#ce5c00",
    blue = "#3584e4",
    blue_cooler = "#0066cc",
    blue_faint = "#204a87",
    magenta = "#9841bb",
    magenta_cooler = "#a020f0",
    magenta_intense = "#ff7092",
    cyan = "#2190a4",
    cyan_cooler = "#0084c8",
    cyan_faint = "#00578e",
    bg_blue_intense = "#6799cc",
    bg_tab_bar = "#eeeeec",
    bg_tab_other = "#ffffff",
    cursor = "#00bbff",
    border = "#ededed",
    fringe = "#e6e6e6",
    bg_mode_line_active = "#ffffff",
    fg_mode_line_active = "#2e3436",
    bg_mode_line_inactive = "#ffffff",
    fg_mode_line_inactive = "#c6c6c6",
    bg_hl_line = "#d9e2ef",
    bg_region = "#c2d5e9",
    bg_popup = "#e2e2e2",
    fg_search_current = "#ffffff",
    bg_added = "#c0f8d0",
    bg_added_faint = "#d0ffe0",
    bg_added_refine = "#b4e8c4",
    fg_added = "#007200",
    bg_changed = "#ffdfa9",
    bg_changed_faint = "#ffefbf",
    bg_changed_refine = "#fac090",
    fg_changed = "#8d6a12",
    bg_removed = "#ffd8d5",
    bg_removed_faint = "#ffe9e9",
    bg_removed_refine = "#f3b5af",
    fg_removed = "#a02a2a",
    semantic = {
      comment = "blue_faint",
      constant = "red_intense",
      keyword = "red_faint",
      string = "green_warmer",
      type = "green_cooler",
      variable = "cyan_cooler",
      func = "cyan_faint",
      builtin = "magenta_cooler",
      preproc = "magenta_cooler",
      special = "cyan_cooler",
      err = "red",
      warning = "yellow_intense",
      info = "green_warmer",
      hint = "cyan",
      ok = "green",
      link = "blue_cooler",
      link_visited = "cyan",
    },
  },

  standard_wombat = {
    bg_main = "#242424",
    fg_main = "#f6f3e8",
    fg_dim = "#99968b",
    red = "#e5786d",
    red_warmer = "#ff9900",
    red_cooler = "#b85149",
    green = "#95e454",
    green_warmer = "#cae682",
    green_faint = "#92a65e",
    yellow = "#ddaa6f",
    yellow_faint = "#ccaa8f",
    blue = "#8ac6f2",
    blue_faint = "#5b98c2",
    magenta = "#a6a1de",
    magenta_faint = "#64619a",
    cyan = "#70cecc",
    cyan_faint = "#3f9f9e",
    bg_blue_subtle = "#333366",
    cursor = "#656565",
    fringe = "#303030",
    border = "#303030",
    bg_search_current = "#343434",
    fg_search_current = "#857b6f",
    bg_hover = "#333333",
    bg_hl_line = "#404040",
    bg_region = "#4f4f4f",
    bg_popup = "#2f2f2f",
    bg_mode_line_active = "#444444",
    fg_mode_line_active = "#f6f3e8",
    fg_mode_line_inactive = "#857b6f",
    bg_tab_bar = "#303030",
    bg_button_active = "#333333",
    fg_button_active = "#f6f3e8",
    bg_search_lazy = "#384048",
    fg_search_lazy = "#a0a8b0",
    bg_added = "#00331f",
    bg_added_faint = "#002410",
    bg_added_refine = "#03492f",
    fg_added = "#4fb04f",
    bg_changed = "#323200",
    bg_changed_faint = "#281a00",
    bg_changed_refine = "#484800",
    fg_changed = "#e0cf03",
    bg_removed = "#4a1119",
    bg_removed_faint = "#320a0f",
    bg_removed_refine = "#751a1f",
    fg_removed = "#ff5f5f",
    semantic = {
      comment = "fg_dim",
      constant = "red",
      keyword = "blue",
      string = "green",
      type = "green_faint",
      variable = "green_warmer",
      func = "green_warmer",
      builtin = "red",
      preproc = "red",
      special = "yellow",
      err = "red",
      warning = "red_warmer",
      info = "green",
      hint = "cyan_faint",
      ok = "green",
      link = "blue",
      link_visited = "red",
    },
  },
}

local palettes = {
  standard_light = raw_palettes.standard_light,
  standard_dark = raw_palettes.standard_dark,
  standard_light_tinted = merge(raw_palettes.standard_light, raw_palettes.standard_light_tinted),
  standard_dark_tinted = merge(raw_palettes.standard_dark, raw_palettes.standard_dark_tinted),
  standard_adwaita = merge(raw_palettes.standard_light, raw_palettes.standard_adwaita),
  standard_wombat = merge(raw_palettes.standard_dark, raw_palettes.standard_wombat),
}

local light_variants = {
  standard_light = true,
  standard_light_tinted = true,
  standard_adwaita = true,
}

local dark_variants = {
  standard_dark = true,
  standard_dark_tinted = true,
  standard_wombat = true,
}

local variant_aliases = {
  ["light"] = "standard_light",
  ["standard-light"] = "standard_light",
  ["standard_light"] = "standard_light",
  ["light-tinted"] = "standard_light_tinted",
  ["standard-light-tinted"] = "standard_light_tinted",
  ["standard_light_tinted"] = "standard_light_tinted",
  ["adwaita"] = "standard_adwaita",
  ["standard-adwaita"] = "standard_adwaita",
  ["standard_adwaita"] = "standard_adwaita",

  ["dark"] = "standard_dark",
  ["standard-dark"] = "standard_dark",
  ["standard_dark"] = "standard_dark",
  ["dark-tinted"] = "standard_dark_tinted",
  ["standard-dark-tinted"] = "standard_dark_tinted",
  ["standard_dark_tinted"] = "standard_dark_tinted",
  ["wombat"] = "standard_wombat",
  ["standard-wombat"] = "standard_wombat",
  ["standard_wombat"] = "standard_wombat",
}

local function normalize_variant(value, side)
  if type(value) ~= "string" then
    return nil
  end

  local key = value:lower():gsub("%s+", "-"):gsub("_", "-")
  local normalized = variant_aliases[key] or key:gsub("-", "_")

  if side == "light" and light_variants[normalized] then
    return normalized
  end

  if side == "dark" and dark_variants[normalized] then
    return normalized
  end

  return nil
end

local function resolve_selected_variants()
  local selected = {
    light = "standard_light",
    dark = "standard_dark",
  }

  local variant = vim.g.standard_themes_variant
  if type(variant) == "string" then
    local token = variant:lower():gsub("%s+", "-"):gsub("_", "-")

    if token == "default" or token == "classic" then
      selected.light = "standard_light"
      selected.dark = "standard_dark"
    elseif token == "tinted" then
      selected.light = "standard_light_tinted"
      selected.dark = "standard_dark_tinted"
    else
      local light_choice = normalize_variant(token, "light")
      local dark_choice = normalize_variant(token, "dark")
      if light_choice then
        selected.light = light_choice
      end
      if dark_choice then
        selected.dark = dark_choice
      end
    end
  elseif type(variant) == "table" then
    local light_choice = normalize_variant(variant.light, "light")
    local dark_choice = normalize_variant(variant.dark, "dark")
    if light_choice then
      selected.light = light_choice
    end
    if dark_choice then
      selected.dark = dark_choice
    end
  end

  local light_override = normalize_variant(vim.g.standard_themes_light_variant, "light")
  if light_override then
    selected.light = light_override
  end

  local dark_override = normalize_variant(vim.g.standard_themes_dark_variant, "dark")
  if dark_override then
    selected.dark = dark_override
  end

  return selected
end

local function pick(tbl, ...)
  for i = 1, select("#", ...) do
    local key = select(i, ...)
    local value = tbl[key]
    if value ~= nil then
      return value
    end
  end

  return nil
end

local function derive_palette(name)
  local c = clone(palettes[name] or palettes.standard_dark)

  c.none = "NONE"

  c.cursor = c.cursor or c.fg_main
  c.fringe = c.fringe or c.bg_dim

  c.bg_tab_bar = c.bg_tab_bar or c.bg_alt
  c.bg_tab_current = c.bg_tab_current or c.bg_main
  c.bg_tab_other = c.bg_tab_other or c.bg_active
  c.fg_tab_other = c.fg_tab_other or c.fg_dim

  c.bg_popup = c.bg_popup or c.bg_alt
  c.bg_hover = c.bg_hover or c.bg_cyan_subtle or c.bg_dim
  c.bg_hl_line = c.bg_hl_line or c.bg_hover or c.bg_dim
  c.bg_region = c.bg_region or c.bg_blue_subtle or c.bg_alt
  c.bg_completion = c.bg_completion or c.bg_blue_subtle or c.bg_alt
  c.bg_paren_match = c.bg_paren_match or c.bg_completion

  c.bg_mode_line_active = c.bg_mode_line_active or c.bg_active
  c.fg_mode_line_active = c.fg_mode_line_active or c.fg_main
  c.border_mode_line_active = c.border_mode_line_active or c.border

  c.bg_mode_line_inactive = c.bg_mode_line_inactive or c.bg_inactive
  c.fg_mode_line_inactive = c.fg_mode_line_inactive or c.fg_dim
  c.border_mode_line_inactive = c.border_mode_line_inactive or c.border

  c.bg_search_current = c.bg_search_current or c.bg_magenta_intense or c.bg_completion
  c.bg_search_lazy = c.bg_search_lazy or c.bg_cyan_intense or c.bg_hover or c.bg_dim
  c.fg_search_current = c.fg_search_current or c.fg_main
  c.fg_search_lazy = c.fg_search_lazy or c.fg_main

  c.bg_diff_context = c.bg_diff_context or c.bg_dim

  c.bg_line_number_inactive = c.bg_line_number_inactive or c.bg_main
  c.bg_line_number_active = c.bg_line_number_active or c.bg_hl_line
  c.fg_line_number_inactive = c.fg_line_number_inactive or c.fg_dim
  c.fg_line_number_active = c.fg_line_number_active or c.fg_main

  c.bg_diag_error = pick(c, "bg_red_subtle", "bg_red_nuanced", "bg_removed_faint", "bg_dim")
  c.bg_diag_warn = pick(c, "bg_yellow_subtle", "bg_yellow_nuanced", "bg_changed_faint", "bg_dim")
  c.bg_diag_info = pick(c, "bg_blue_subtle", "bg_blue_nuanced", "bg_completion", "bg_dim")
  c.bg_diag_hint = pick(c, "bg_cyan_subtle", "bg_cyan_nuanced", "bg_hover", "bg_dim")
  c.bg_diag_ok = pick(c, "bg_green_subtle", "bg_green_nuanced", "bg_added_faint", "bg_dim")

  local semantic = c.semantic or {}
  local function semantic_color(key, ...)
    local mapped = semantic[key]
    if type(mapped) == "string" and c[mapped] then
      return c[mapped]
    end
    return pick(c, ...)
  end

  c.syn_comment = semantic_color("comment", "fg_dim") or c.fg_dim
  c.syn_constant = semantic_color("constant", "magenta", "blue") or c.fg_main
  c.syn_keyword = semantic_color("keyword", "blue", "magenta") or c.fg_main
  c.syn_string = semantic_color("string", "green", "yellow") or c.fg_main
  c.syn_type = semantic_color("type", "cyan", "green") or c.fg_main
  c.syn_variable = semantic_color("variable", "fg_main") or c.fg_main
  c.syn_func = semantic_color("func", "blue", "cyan") or c.fg_main
  c.syn_builtin = semantic_color("builtin", "blue_faint", "magenta") or c.fg_main
  c.syn_preproc = semantic_color("preproc", "blue_faint", "cyan") or c.fg_main
  c.syn_special = semantic_color("special", "cyan", "yellow", "magenta") or c.fg_main
  c.syn_link = semantic_color("link", "blue", "blue_cooler", "fg_alt") or c.fg_alt
  c.syn_link_visited = semantic_color("link_visited", "magenta", "magenta_cooler", "fg_alt") or c.fg_alt

  c.diag_error = semantic_color("err", "red", "red_warmer") or c.red
  c.diag_warn = semantic_color("warning", "yellow_warmer", "yellow", "red_warmer") or c.yellow
  c.diag_info = semantic_color("info", "green", "cyan") or c.green
  c.diag_hint = semantic_color("hint", "cyan_faint", "cyan", "blue") or c.cyan
  c.diag_ok = semantic_color("ok", "green_cooler", "green") or c.green

  return c
end

local function set_terminal_colors(c)
  vim.g.terminal_color_0 = c.bg_main
  vim.g.terminal_color_8 = c.fg_dim

  vim.g.terminal_color_1 = pick(c, "red", "red_warmer") or c.diag_error
  vim.g.terminal_color_9 = pick(c, "red_warmer", "red_cooler", "red") or c.diag_error

  vim.g.terminal_color_2 = pick(c, "green", "green_cooler") or c.diag_ok
  vim.g.terminal_color_10 = pick(c, "green_cooler", "green_warmer", "green") or c.diag_ok

  vim.g.terminal_color_3 = pick(c, "yellow", "yellow_warmer") or c.diag_warn
  vim.g.terminal_color_11 = pick(c, "yellow_warmer", "yellow_cooler", "yellow") or c.diag_warn

  vim.g.terminal_color_4 = pick(c, "blue", "blue_warmer") or c.syn_func
  vim.g.terminal_color_12 = pick(c, "blue_cooler", "blue_warmer", "blue") or c.syn_func

  vim.g.terminal_color_5 = pick(c, "fg_main", "fg_main") or c.syn_keyword
  vim.g.terminal_color_13 = pick(c, "magenta_cooler", "magenta_warmer", "magenta") or c.syn_keyword

  vim.g.terminal_color_6 = pick(c, "cyan", "cyan_cooler") or c.syn_special
  vim.g.terminal_color_14 = pick(c, "cyan_cooler", "cyan_warmer", "cyan") or c.syn_special

  vim.g.terminal_color_7 = c.fg_main
  vim.g.terminal_color_15 = c.fg_alt
end

local function make_groups(c)
  local float_bg = vim.o.winborder == "rounded" and c.bg_main or c.bg_popup

  return {
    Normal                           = { fg = c.fg_main, bg = c.bg_main },
    NormalNC                         = { fg = c.fg_main, bg = c.bg_main },
    NormalSB                         = { fg = c.fg_main, bg = c.bg_dim },
    TerminalNormal                   = { fg = c.fg_main, bg = c.bg_main },
    SidebarNormal                    = { fg = c.fg_main, bg = c.bg_main },

    NormalFloat                      = { bg = c.bg_mode_line_inactive },
    FloatBorder                      = vim.o.winborder == "none" and { fg = float_bg, bg = float_bg } or
        { fg = c.border, bg = float_bg },
    FloatTitle                       = { fg = c.fg_alt, bg = float_bg, bold = true },
    Pmenu                            = { fg = c.fg_main, bg = float_bg },
    PmenuSel                         = { fg = c.fg_main, bg = c.bg_completion },
    PmenuMatch                       = { fg = c.syn_keyword, bold = true },
    PmenuMatchSel                    = { fg = c.syn_keyword, bold = true, underline = true },
    PmenuSbar                        = { bg = c.bg_dim },
    PmenuThumb                       = { bg = c.border },
    PmenuBorder                      = "FloatBorder",

    Cursor                           = { fg = c.bg_main, bg = c.cursor },
    lCursor                          = "Cursor",
    CursorIM                         = "Cursor",
    CursorLine                       = { bg = c.bg_hl_line },
    CursorColumn                     = { bg = c.bg_hl_line },
    ColorColumn                      = { bg = c.bg_dim },

    LineNr                           = { fg = c.fg_line_number_inactive, bg = c.bg_main },
    LineNrAbove                      = "LineNr",
    LineNrBelow                      = "LineNr",
    CursorLineNr                     = { fg = c.fg_line_number_active, bg = c.bg_main, bold = true },
    CursorLineFold                   = { fg = c.fg_main, bold = true },

    SignColumn                       = { bg = c.bg_main },
    FoldColumn                       = { fg = c.fg_dim, bg = c.bg_main },
    Folded                           = { fg = c.fg_dim, bg = c.bg_dim },

    WinSeparator                     = { fg = c.border },
    VertSplit                        = "WinSeparator",

    StatusLine                       = {
      -- fg = c.fg_mode_line_active,
      -- bg = c.bg_mode_line_active,
      fg = c.fg_mode_line_inactive,
      bg = c.bg_mode_line_inactive,
      -- underline = true,
      -- overline = true,
      -- sp = c.border_mode_line_active,
    },
    StatusLineNC                     = {
      fg = c.fg_mode_line_inactive,
      bg = c.bg_mode_line_inactive,
      -- underline = true,
      -- overline = true,
      -- sp = c.border_mode_line_inactive,
    },
    StatusLineTerm                   = {
      fg = c.fg_mode_line_active,
      bg = c.bg_mode_line_active,
      -- underline = true,
      -- overline = true,
      -- sp = c.border_mode_line_active,
    },
    StatusLineTermNC                 = {
      fg = c.fg_mode_line_active,
      bg = c.bg_mode_line_active,
      -- underline = true,
      -- overline = true,
      -- sp = c.border_mode_line_active,
    },
    WinBar                           = { fg = c.fg_mode_line_active, bg = c.bg_tab_bar },
    WinBarNC                         = { fg = c.fg_mode_line_inactive, bg = c.bg_tab_bar },

    TabLine                          = { fg = c.fg_tab_other, bg = c.bg_main },
    TabLineSel                       = { fg = c.fg_main, bg = c.bg_main, bold = true },
    TabLineFill                      = { fg = c.fg_dim, bg = c.bg_main },

    Search                           = { fg = c.fg_search_current, bg = c.bg_search_current },
    IncSearch                        = { fg = c.fg_search_lazy, bg = c.bg_search_lazy },
    CurSearch                        = "IncSearch",
    Substitute                       = { fg = c.fg_main, bg = c.bg_red_intense },

    Visual                           = { bg = c.bg_region },
    VisualNOS                        = "Visual",
    MatchParen                       = { fg = c.fg_main, bg = c.bg_paren_match, bold = true },

    NonText                          = { fg = c.fg_dim },
    SpecialKey                       = "NonText",
    Whitespace                       = "NonText",
    Conceal                          = { fg = c.syn_builtin },
    EndOfBuffer                      = { fg = c.bg_main },

    Directory                        = { fg = c.syn_func },
    Title                            = { fg = c.fg_alt, bold = true },
    Question                         = { fg = c.syn_func },
    MoreMsg                          = { fg = c.syn_type },
    WarningMsg                       = { fg = c.diag_warn, bold = true },
    ErrorMsg                         = { fg = c.diag_error, bold = true },
    ModeMsg                          = { fg = c.fg_main },
    QuickFixLine                     = { bg = c.bg_hl_line },
    WildMenu                         = { fg = c.fg_main, bg = c.bg_mark_select },

    Scrollbar                        = { fg = c.bg_mode_line_inactive },
    ScrollbarThumb                   = { fg = c.border },

    SpellBad                         = { undercurl = true, sp = c.diag_error },
    SpellCap                         = { undercurl = true, sp = c.diag_warn },
    SpellLocal                       = { undercurl = true, sp = c.diag_info },
    SpellRare                        = { undercurl = true, sp = c.diag_hint },

    DiffAdd                          = { fg = c.fg_added, bg = c.bg_added },
    DiffChange                       = { fg = c.fg_changed, bg = c.bg_changed },
    DiffDelete                       = { fg = c.fg_removed, bg = c.bg_removed },
    DiffText                         = { fg = c.fg_main, bg = c.bg_changed_refine },
    diffAdded                        = "DiffAdd",
    diffChanged                      = "DiffChange",
    diffRemoved                      = "DiffDelete",

    Comment                          = { fg = c.syn_comment, italic = true },
    Constant                         = { fg = c.syn_constant },
    String                           = { fg = c.syn_string },
    Character                        = "String",
    Number                           = { fg = c.syn_constant },
    Boolean                          = { fg = c.syn_constant, bold = true },
    Float                            = "Number",
    Identifier                       = { fg = c.syn_variable },
    Function                         = { fg = c.syn_func },
    Statement                        = { fg = c.syn_keyword },
    Conditional                      = "Statement",
    Repeat                           = "Statement",
    Label                            = { fg = c.syn_special },
    Operator                         = { fg = c.fg_main },
    Keyword                          = { fg = c.syn_keyword },
    Exception                        = { fg = c.syn_keyword },
    PreProc                          = { fg = c.syn_preproc },
    Include                          = "PreProc",
    Define                           = { fg = c.syn_builtin },
    Macro                            = { fg = c.syn_builtin },
    Type                             = { fg = c.syn_type },
    StorageClass                     = { fg = c.syn_type },
    Structure                        = { fg = c.syn_type },
    Typedef                          = { fg = c.syn_type },
    Special                          = { fg = c.syn_special },
    SpecialChar                      = "Special",
    Tag                              = { fg = c.syn_keyword },
    Delimiter                        = { fg = c.fg_main },
    Underlined                       = { fg = c.syn_link, underline = true },
    Bold                             = { bold = true },
    Italic                           = { italic = true },
    Error                            = { fg = c.diag_error },
    Todo                             = { fg = c.fg_main, bg = c.bg_mark_select, bold = true },

    LspCodeLens                      = { fg = c.fg_dim, italic = true },
    LspInlayHint                     = { fg = c.fg_dim, bg = c.bg_popup, italic = true },
    LspReferenceText                 = { bg = c.bg_hover },
    LspReferenceRead                 = "LspReferenceText",
    LspReferenceWrite                = "LspReferenceText",
    LspSignatureActiveParameter      = { underline = true, bold = true },
    LspInfoBorder                    = "FloatBorder",

    DiagnosticError                  = { fg = c.diag_error },
    DiagnosticWarn                   = { fg = c.diag_warn },
    DiagnosticInfo                   = { fg = c.diag_info },
    DiagnosticHint                   = { fg = c.diag_hint },
    DiagnosticOk                     = { fg = c.diag_ok },

    DiagnosticSignError              = { fg = c.diag_error, bold = true },
    DiagnosticSignWarn               = { fg = c.diag_warn, bold = true },
    DiagnosticSignInfo               = { fg = c.diag_info, bold = true },
    DiagnosticSignHint               = { fg = c.diag_hint, bold = true },
    DiagnosticSignOk                 = { fg = c.diag_ok, bold = true },

    -- DiagnosticVirtualTextError       = { fg = c.diag_error, bg = c.bg_diag_error },
    -- DiagnosticVirtualTextWarn        = { fg = c.diag_warn, bg = c.bg_diag_warn },
    -- DiagnosticVirtualTextInfo        = { fg = c.diag_info, bg = c.bg_diag_info },
    -- DiagnosticVirtualTextHint        = { fg = c.diag_hint, bg = c.bg_diag_hint },
    -- DiagnosticVirtualTextOk          = { fg = c.diag_ok, bg = c.bg_diag_ok },

    DiagnosticUnderlineError         = { undercurl = true, sp = c.diag_error },
    DiagnosticUnderlineWarn          = { undercurl = true, sp = c.diag_warn },
    DiagnosticUnderlineInfo          = { undercurl = true, sp = c.diag_info },
    DiagnosticUnderlineHint          = { undercurl = true, sp = c.diag_hint },
    DiagnosticUnderlineOk            = { undercurl = true, sp = c.diag_ok },

    TreesitterContext                = { bg = c.bg_main, underline = true, sp = c.border },
    TreesitterContextLineNumber      = { fg = c.fg_main, bg = c.bg_main, underline = true, sp = c.border },
    TreesitterContextSeparator       = { fg = c.border },

    ["@variable"]                    = { fg = c.fg_main },
    ["@variable.builtin"]            = { fg = c.syn_builtin },
    ["@variable.parameter"]          = { fg = c.syn_variable },
    ["@variable.parameter.builtin"]  = { fg = c.syn_builtin },
    -- ["@variable.member"]             = { fg = c.syn_variable },

    ["@constant"]                    = "Constant",
    ["@constant.builtin"]            = "Constant",
    ["@constant.macro"]              = "Macro",

    ["@module"]                      = { fg = c.syn_variable },
    ["@module.builtin"]              = { fg = c.syn_builtin },
    ["@label"]                       = "Label",

    ["@string"]                      = "String",
    ["@string.documentation"]        = { fg = c.syn_comment, italic = true },
    ["@string.escape"]               = { fg = c.syn_special },
    ["@string.special"]              = { fg = c.syn_special },
    ["@string.special.path"]         = { fg = c.syn_link },
    ["@string.special.url"]          = { fg = c.syn_link, underline = true },

    ["@character"]                   = "Character",
    ["@character.special"]           = "SpecialChar",
    ["@boolean"]                     = "Boolean",
    ["@number"]                      = "Number",
    ["@number.float"]                = "Float",

    ["@type"]                        = "Type",
    ["@type.builtin"]                = { fg = c.syn_builtin },
    ["@type.definition"]             = "Typedef",

    ["@attribute"]                   = "PreProc",
    ["@attribute.builtin"]           = "PreProc",
    ["@property"]                    = { fg = c.syn_variable },

    ["@function"]                    = { fg = c.syn_func },
    ["@function.builtin"]            = { fg = c.syn_builtin },
    ["@function.call"]               = "Function",
    ["@function.macro"]              = "Macro",
    ["@function.method"]             = "Function",
    ["@function.method.call"]        = "Function",
    ["@constructor"]                 = { fg = c.syn_type },

    ["@operator"]                    = "Operator",
    ["@keyword"]                     = "Keyword",
    ["@keyword.coroutine"]           = "Keyword",
    ["@keyword.function"]            = "Keyword",
    ["@keyword.operator"]            = "Operator",
    ["@keyword.import"]              = "Include",
    ["@keyword.repeat"]              = "Repeat",
    ["@keyword.return"]              = "Keyword",
    ["@keyword.exception"]           = "Exception",
    ["@keyword.conditional"]         = "Conditional",
    ["@keyword.conditional.ternary"] = "Conditional",
    ["@keyword.directive"]           = "PreProc",
    ["@keyword.directive.define"]    = "Define",

    ["@punctuation.delimiter"]       = "Delimiter",
    ["@punctuation.bracket"]         = "Delimiter",
    ["@punctuation.special"]         = "Special",

    ["@comment"]                     = "Comment",
    ["@comment.documentation"]       = { fg = c.syn_comment, italic = true },
    ["@comment.error"]               = { fg = c.diag_error },
    ["@comment.warning"]             = { fg = c.diag_warn },
    ["@comment.todo"]                = "Todo",
    ["@comment.note"]                = { fg = c.diag_hint },

    ["@markup.strong"]               = { bold = true },
    ["@markup.italic"]               = { italic = true },
    ["@markup.strikethrough"]        = { strikethrough = true },
    ["@markup.underline"]            = { underline = true },
    ["@markup.heading"]              = "Title",
    ["@markup.heading.1"]            = { fg = c.rainbow_0 or c.syn_func, bold = true },
    ["@markup.heading.2"]            = { fg = c.blue_cooler or c.syn_func, bold = true },
    ["@markup.heading.3"]            = { fg = c.yellow_cooler or c.syn_type, bold = true },
    ["@markup.heading.4"]            = { fg = c.cyan or c.syn_keyword, bold = true },
    ["@markup.heading.5"]            = { fg = c.red_faint or c.diag_error, bold = true },
    ["@markup.heading.6"]            = { fg = c.green_warmer or c.syn_type, bold = true },

    ["@markup.quote"]                = { fg = c.syn_comment, italic = true },
    ["@markup.math"]                 = { fg = c.syn_special },
    ["@markup.link"]                 = { fg = c.syn_link, underline = true },
    ["@markup.link.label"]           = { fg = c.syn_special },
    ["@markup.link.url"]             = { fg = c.syn_link, underline = true },
    ["@markup.raw"]                  = { fg = c.syn_string },
    ["@markup.raw.block"]            = { fg = c.syn_string },
    ["@markup.raw.markdown_inline"]  = { fg = c.syn_string, bg = c.bg_alt },
    ["@markup.list"]                 = { fg = c.fg_main },
    ["@markup.list.checked"]         = { fg = c.diag_ok },
    ["@markup.list.unchecked"]       = { fg = c.diag_warn },

    ["@diff.plus"]                   = "DiffAdd",
    ["@diff.minus"]                  = "DiffDelete",
    ["@diff.delta"]                  = "DiffChange",

    ["@tag"]                         = "Tag",
    ["@tag.attribute"]               = "@property",
    ["@tag.delimiter"]               = "Delimiter",

    GitSignsAdd                      = { fg = c.fg_added },
    GitSignsChange                   = { fg = c.fg_changed },
    GitSignsDelete                   = { fg = c.fg_removed },

    MiniDiffSignAdd                  = "GitSignsAdd",
    MiniDiffSignChange               = "GitSignsChange",
    MiniDiffSignDelete               = "GitSignsDelete",

    TelescopeBorder                  = "FloatBorder",
    BlinkCmpMenuBorder               = "FloatBorder",
    BlinkCmpDocBorder                = "FloatBorder",
    BlinkCmpSignatureHelpBorder      = "FloatBorder",
    BlinkCmpLabelMatch               = "PmenuMatch",
    BlinkCmpGhostText                = { fg = c.fg_dim },

    FzfLuaBorder                     = "FloatBorder",
    FzfLuaFzfSeparator               = { fg = c.bg_main },
    FzfLuaSeparator                  = { fg = c.bg_main },
    FzfLuaLivePrompt                 = { fg = c.fg_main },
    FzfLuaHeaderBind                 = { fg = c.fg_main },
    FzfLuaBufFlagCur                 = { fg = c.fg_main },
    FzfLuaPathLineNr                 = { fg = c.fg_main },
    FzfLuaPathColNr                  = { fg = c.fg_main },
    FzfLuaBufFlagAlt                 = { fg = c.fg_main },
    FzfLuaBufNr                      = { fg = c.fg_main },
    FzfLuaHeaderText                 = { fg = c.fg_main },
    fzf1                             = { fg = "bg", bg = "bg" },
    fzf2                             = "fzf1",
    fzf3                             = "fzf1",
    FzfLuaTitle                      = "fzf1",
    FzfLuaTitleFlags                 = "fzf1",

    SnacksPicker                     = { bg = c.bg_main },
    SnacksWinSeparator               = { fg = c.border, bg = c.bg_main },
    SnacksPickerInputBorder          = { fg = c.border, bg = c.bg_main },
    SnacksPickerTree                 = { fg = c.border, bg = c.bg_main },
    SnacksPickerPrompt               = { fg = c.cyan, bg = c.bg_main },
    SnacksPickerCursorLine           = { bg = mod(c.bg_main, 20) },
    SnacksIndent                     = { fg = mod(c.border, -30) },
    SnacksIndentScope                = { fg = c.border },

    BufferLineOffsetSeparator        = { fg = c.border, bg = c.bg_main },
    BufferLineOffsetHelp             = "TerminalNormal",
    BufferLineOffset                 = "SidebarNormal",
    BufferLineOffsetExplorer         = { fg = c.fg_main, bg = c.bg_main },

    healthError                      = { fg = c.diag_error },
    healthWarning                    = { fg = c.diag_warn },
    healthSuccess                    = { fg = c.diag_ok },
  }
end

local function apply_highlights(groups)
  for group, spec in pairs(groups) do
    if type(spec) == "string" then
      vim.api.nvim_set_hl(0, group, { link = spec })
    else
      vim.api.nvim_set_hl(0, group, spec)
    end
  end
end

local function apply()
  if vim.g.colors_name then
    vim.cmd("highlight clear")
  end

  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = theme_name

  local side = vim.o.background == "light" and "light" or "dark"
  local selected = resolve_selected_variants()
  local variant = selected[side]
  local colors = derive_palette(variant)

  vim.g.standard_themes_active_variant = variant

  set_terminal_colors(colors)
  apply_highlights(make_groups(colors))
end

apply()

local bg_sync_group = vim.api.nvim_create_augroup("StandardThemesBackgroundSync", { clear = true })
vim.api.nvim_create_autocmd("OptionSet", {
  group = bg_sync_group,
  pattern = "background",
  callback = function()
    if vim.g.colors_name == theme_name then
      apply()
    end
  end,
})
