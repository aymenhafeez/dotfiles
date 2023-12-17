local present, scrollbar = pcall(require, "scrollbar")
if not present then
  return
end

local options = {
  marks = {
    Cursor = {
      text = "",
      priority = 10,
      gui = nil,
      color = nil,
      cterm = nil,
      color_nr = nil, -- cterm
      highlight = "CursorLine",
    },
    Error = {
      text = { "▎", "▎" },
      priority = 2,
      gui = nil,
      color = nil,
      cterm = nil,
      color_nr = nil, -- cterm
      highlight = "DiagnosticVirtualTextError",
    },
    Warn = {
      text = { "▎", "▎" },
      priority = 3,
      gui = nil,
      color = nil,
      cterm = nil,
      color_nr = nil, -- cterm
      highlight = "DiagnosticVirtualTextWarn",
    },
    Info = {
      text = { "▎", "▎" },
      priority = 4,
      gui = nil,
      color = nil,
      cterm = nil,
      color_nr = nil, -- cterm
      highlight = "DiagnosticVirtualTextInfo",
    },
    Hint = {
      text = { "▎", "▎" },
      priority = 5,
      gui = nil,
      color = nil,
      cterm = nil,
      color_nr = nil, -- cterm
      highlight = "DiagnosticVirtualTextHint",
    },
  },
  excluded_filetypes = {
    "cmp_docs",
    "cmp_menu",
    "noice",
    "TelescopePrompt",
    "lazy",
    "mason",
    "neo-tree",
  }
}

return scrollbar.setup(options)
