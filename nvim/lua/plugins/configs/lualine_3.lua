local present, lualine = pcall(require, "lualine")
if not present then
  return
end

local utils = require("ah.utils")
local telescope_utils = require("ah.telescope.utils")

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
  blue_5         = "#2ac3de",
  blue_6         = "#4B34A4",
  blue_7         = "#3B4261",
  blue_8         = "#7AA2F7",
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
    globalstatus = true
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
    -- return " "
    return "▎"
  end,
  on_click = function()
    return vim.api.nvim_exec2("lua", {})
  end,
  color = function()
    local mode_color = {
      n = colors.blue_5,
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
    -- return { bg = mode_color[vim.fn.mode()], fg = colors.white }
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { left = 0, right = 0 },
}

ins_left {
  "filetype",
  cond = conditions.buffer_not_empty,
  icon_only = false,
  color = { fg = colors.blue_1 },
  padding = { left = 1, right = 2 },
}

ins_left {
  "branch",
  icon = "",
  color = { fg = colors.yellow_3 },
  padding = { left = 1, right = 2 },
}

ins_left {
  "diff",
  symbols = { added = " ", modified = " ", removed = " " },
  -- diff_color = {
  --   added = { fg = colors.green },
  --   modified = { fg = colors.yellow },
  --   removed = { fg = colors.red },
  -- },
  cond = conditions.hide_in_width,
  padding = { left = 0, right = 2 },
}

-- right

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
        return " " .. client.name
      end
    end
    return " " .. msg
  end,

  on_click = function()
    return vim.cmd("Mason")
  end,

  color = { fg = colors.blue_1 },
  padding = { left = 1, right = 1 }
}

ins_right {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = " ", warn = " ", hint = " ", info = " " },
  -- diagnostics_color = {
  --   color_error = { fg = colors.red },
  --   color_warn = { fg = colors.yellow },
  --   color_info = { fg = colors.cyan },
  -- },
  on_click = function()
    return telescope_utils.search_diagnostics()
  end,
  padding = { left = 1, right = 1 }
}

ins_right {
  function()
    return " TS"
  end,
  on_click = function()
    vim.cmd("TSToggle highlight")
    vim.notify("TSToggle highlight")
  end,
  color = { fg = colors.blue_1 },
  padding = { left = 2, right = 2 },
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
  padding = { left = 1, right = 3 }
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
  padding = { right = 0, left = 1 }
}

ins_right {
  function()
    -- return "▊"
    return "󰇙"
  end,
  color = function()
    local mode_color = {
      n = colors.blue,
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
      R = colors.red,
      Rv = colors.red,
      cv = colors.violet,
      ce = colors.violet,
      r = colors.cyan,
      rm = colors.cyan,
      ["r?"] = colors.cyan,
      ["!"] = colors.red,
      t = colors.orange,
    }
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { left = 1, right = 0 },
}

lualine.setup(config)

