local active_colorscheme = ""

return {
  {
    'kepano/flexoki-neovim',
    name = 'flexoki',
    priority = 1000,
    config = function()
      if active_colorscheme == "flexoki" then
        vim.cmd.colorscheme("flexoki")
      end
    end
  },

  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      if active_colorscheme == "kanagawa" then
        require("kanagawa").setup({
          dimInactive = false,
          overrides = function(colors)
            local theme = colors.theme
            return {
              NormalFloat = { bg = "none" },
              FloatBorder = { fg = theme.ui.bg_dim, bg = theme.ui.bg_dim },
              NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
              LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
              MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
              Number = { fg = colors.palette.roninYellow },
              TelescopeTitle = { fg = theme.ui.special, bold = true },
              TelescopePromptNormal = { bg = theme.ui.bg_p1 },
              TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
              TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
              TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
              TelescopePreviewNormal = { bg = theme.ui.bg_dim },
              TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
              Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
              PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
              PmenuSbar = { bg = theme.ui.bg_m1 },
              PmenuThumb = { bg = theme.ui.bg_p2 },
              StatusLine = { bg = colors.theme.ui.bg_p1, fg = colors.palette.katanaGray },
            }
          end,
        })
        vim.cmd.colorscheme("kanagawa")
      end
    end
  },

  {
    "Shatur/neovim-ayu",
    priority = 1000,
    config = function()
      if active_colorscheme == "ayu" then
        require('ayu').setup {
          style = 'mirage'
        }
        vim.cmd.colorscheme("ayu")
      end
    end
  },

  {
    'maxmx03/solarized.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      if active_colorscheme == "solarized" then
        vim.cmd.colorscheme("solarized")
      end
    end,
  },

  {
    'folke/tokyonight.nvim',
    priority = 1000,
    ---@diagnostic disable-next-line: missing-fields
    config = function()
      if active_colorscheme == 'tokyonight' then
        require("tokyonight").setup({
          on_colors = function()
          end,
          style = "storm",
          styles = {
            comments = { italic = true },
          },
          on_highlights = function(hl, c)
            local header = "#7aa2f7"
            local header_modified = "#f7768e"
            local statusline_fg = "#565f89"
            hl.StatusLine = {
              bg = c.bg_statusline,
              fg = statusline_fg
            }
            hl.StatusLineHeader = {
              bg = header,
              fg = c.bg
            }
            hl.StatusLineHeaderModified = {
              bg = header_modified,
              fg = c.bg
            }
          end

        })
        vim.cmd.colorscheme("tokyonight-night")
      end
    end,
  },

  {
    'vague2k/vague.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      if active_colorscheme == "vague" then
        require("vague").setup({
          style = {
            strings = 'none'
          },
          on_highlights = function(highlights, colors)
            highlights.MatchParen.fg = '#e8b589'
            highlights.MatchParen.bg = '#252530'
            highlights.StatusLineNC.bg = '#1c1c24'
            highlights.TreesitterContext.bg = '#1c1c24'
            highlights.TreesitterContextLineNumber.bg = '#1c1c24'
            highlights.LspReferenceText.bg = '#252530'
            highlights.LspReferenceWrite.bg = '#252530'
            highlights.LspReferenceRead.fg = '#252530'
            highlights.StatusLineTerm.bg = '#1c1c24'
            highlights.StatusLineHeader = { fg = colors.fg, bg = '#606079' }
            highlights.StatusLineHeaderModified = { fg = colors.bg, bg = '#c48282' }
            highlights.StatusLineCurrentBuffer = { bg = colors.fg, fg = '#606079' }
          end,
        })
        vim.cmd.colorscheme("vague")
      end
    end
  },
}
