local present, lualine = pcall(require, "lualine")
if not present then
  return
end

local utils = require("ah.utils")

local colors = {
  bg             = "#191d25",
  bg1            = "#21283b",
  bg_d           = "#141b24",
  fg             = "#a0a8b7",
  yellow         = "#e5c07b",
  yellow_2       =  "#ffbc03",
  yellow_3       = "#ee9d28",
  cyan           = "#008080",
  darkblue       = "#081633",
  green          = "#98c379",
  orange         = "#FF8800",
  orange_2       = "#FF9E64",
  violet         = "#a9a1e1",
  magenta        = "#c678dd",
  blue           = "#61afef",
  blue_1         = "#8094b4",
  blue_2         = "#51afef",
  blue_3         = "#06B6EF",
  blue_4         = "#4d78cd",
  red            = "#ec5f67",
  light_grey     = "#343b46",
  light_grey_2   = "#282d39",
  light_grey_3   = "#686b71",
  light_grey_4   = "#9ea5b5",
  white          = "#f3f6fc"
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local config = {
  options = {
    component_separators = "",
    section_separators = "",
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left {
  function()
    -- return "█"
    -- return "   "
    return " "
  end,
  on_click = function()
    return vim.api.nvim_exec2("lua", {})
  end,
  color = function()
    local mode_color = {
      n = colors.blue_4,
      i = colors.green,
      v = colors.magenta,
      [""] = colors.blue,
      V = colors.magenta,
      c = colors.yellow,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [""] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ["r?"] = colors.cyan,
      ["!"] = colors.red,
      t = colors.orange,
    }
    return { bg = mode_color[vim.fn.mode()], fg = colors.white }
  end,
  padding = { left = 0, right = 1 },
}

ins_left {
  function()
    return ""
  end,
  on_click = function()
    return vim.cmd("Neotree toggle")
  end,
  -- color = { fg = colors.blue_1 },
  color = { fg = colors.light_grey_3 },
  padding = { left = 2, right = 3}
}

ins_left {
  function()
    return ""
  end,
  on_click = function()
    return require("telescope.builtin").find_files()
  end,
  -- color = { fg = colors.blue_1 },
  color = { fg = colors.light_grey_3 },
  padding = { left = 0, right = 2}
}

ins_left {
  function()
    return ""
  end,
  on_click = function()
    utils.float_terminal("lazygit")
  end,
  -- color = { fg = colors.blue_1 },
  color = { fg = colors.light_grey_3 },
  padding = { left = 1, right = 2}
}

ins_left {
  function()
    return ""
  end,
  on_click = function()
    return vim.cmd.Lazy()
  end,
  -- color = { fg = colors.blue_1 },
  color = { fg = colors.light_grey_3 },
  padding = { left = 1, right = 2}
}

-- ins_left {
--   "filetype",
--   cond = conditions.buffer_not_empty,
--   icon_only = false,
--   padding = { left = 2, right = 3 },
-- }
--
-- ins_left {
--   "filename",
--   symbols = {
--     modified = ""
--   },
--   color = { gui = "bold" },
--   padding = { left = 1, right = 3 },
-- }

ins_left {
  "branch",
  icon = "",
  color = { fg = colors.blue_1 },
  padding = { left = 2, right = 3 },
}

ins_left {
  "diff",
  symbols = { added = " ", modified = " ", removed = " " },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.yellow },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
  padding = { left = 0, right = 2 },
}

-- right



ins_right {
  function()
    if vim.api.nvim_get_vvar("hlsearch") == 1 then
      local res = vim.fn.searchcount({ maxcount = 999, timeout = 500 })
      if res.total > 0 then
        return string.format("%s/%d %s", res.current, res.total, vim.fn.getreg("/"))
      end
    end
    return ""
  end,
  color = { fg = colors.blue }
}

ins_right {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = " ", warn = " ", hint = " ", info = " " },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
  on_click = function()
    return require("telescope.builtin").diagnostics({0})
  end,
  padding = { left = 3, right = 0 }
}

ins_right {
  function()
    local msg = "LS Inactive"
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  on_click = function()
    return vim.cmd("LspInstallInfo")
  end,
  icon = " ",
  color = { fg = colors.blue_1 },
  padding = { left = 1, right = 3 }
}

ins_right {
  function()
    return " TS"
  end,
  on_click = function()
    local b = vim.api.nvim_get_current_buf()
    vim.cmd("TSToggle highlight")
    vim.notify("TSToggle highlight")
    -- if next(vim.treesitter.highlighter.active[b]) then
    --   return vim.notify("Treesitter highlight enabled")
    -- else
    --   return vim.notify("Treesitter highlight disabled")
    -- end
  end,
  color = { fg = colors.blue_1 },
  padding = { left = 1, right = 4 },
  cond = conditions.hide_in_width,
}

ins_right  {
  function()
    return ""
  end,
  on_click = function()
    return vim.cmd("Telescope notify")
  end,
  color = { fg = colors.blue_1 },
  padding = { left = 0, right = 2 }
}

ins_right {
  function()
    local current_line = vim.fn.line "."
    local total_lines = vim.fn.line "$"
    local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
    local line_ratio = current_line / total_lines
    local index = math.ceil(line_ratio * #chars)
    return chars[index]
  end,
  color = { fg = colors.yellow, gui = "" },
  padding = { right = 0, left = 0 }
}

-- ins_right {
--   function()
--     return "▊"
--   end,
--   color = function()
--     local mode_color = {
--       n = colors.blue,
--       i = colors.green,
--       v = colors.magenta,
--       [""] = colors.blue,
--       V = colors.magenta,
--       c = colors.yellow,
--       no = colors.red,
--       s = colors.orange,
--       S = colors.orange,
--       [""] = colors.orange,
--       ic = colors.yellow,
--       R = colors.red,
--       Rv = colors.red,
--       cv = colors.violet,
--       ce = colors.violet,
--       r = colors.cyan,
--       rm = colors.cyan,
--       ["r?"] = colors.cyan,
--       ["!"] = colors.red,
--       t = colors.orange,
--     }
--     return { fg = mode_color[vim.fn.mode()] }
--   end,
--   padding = { left = 1, right = 0 },
-- }

lualine.setup(config)
