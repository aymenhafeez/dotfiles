local present, kanagawa = pcall(require, "kanagawa")
if not present then
  return
end

local options = {
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = "none"
        },
      }
    }
  },
  overrides = function(colors)
    local theme = colors.theme
    local palette = colors.palette
    return {
      -- Identifier = { fg = palette.fujiWhite},

      NormalFloat = { bg = "none" },
      FloatBorder = { bg = "none" },
      FloatTitle = { bg = "none" },
      LspReferenceWrite = { underline = false },
      LspReferenceText = { underline = false },
      LspReferenceRead = { underline = false },

      MiniIndentscopeSymbol = { fg = theme.ui.bg_p1 },

      Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },  -- add `blend = vim.o.pumblend` to enable transparency
      PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
      PmenuSbar = { bg = theme.ui.bg_m1 },
      PmenuThumb = { bg = theme.ui.bg_p2 },

      -- TelescopeTitle = { fg = theme.ui.special, bold = true },
      -- TelescopePromptNormal = { bg = theme.ui.bg_p1 },
      -- TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
      -- TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
      -- TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
      -- TelescopePreviewNormal = { bg = theme.ui.bg_dim },
      -- TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
    }
  end,
}

kanagawa.setup(options)
