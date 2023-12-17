local present, monokai = pcall(require, "monokai-pro")
if not present then
  return
end

local options = {
  background_clear = {
    -- "float_win",
    -- "toggleterm",
    "telescope",
    -- "which-key",
    "renamer",
    -- "notify",
    -- "nvim-tree",
    -- "neo-tree",
    -- "bufferline", -- better used if background of `neo-tree` or `nvim-tree` is cleared
  },-- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree", "nvim-tree", "bufferline"
  plugins = {
    bufferline = {
      underline_selected = true,
      underline_visible = true,
    }
  },
  override = function()
    return {
      LspReferenceRead = { bg = "#383839"},
      LspReferenceText = { bg = "#383839" },
      LspReferenceWrite = { bg = "#383839" },

      MiniIndentScopeSymbol = { fg = "#383839" },

      -- TelescopeTitle = {},
      TelescopePromptNormal = { bg = "#383839" },
      TelescopePromptBorder = { bg = "#383839", fg = "#383839" },
      TelescopeResultsNormal = { bg = "#2c2c2d" },
      TelescopeResultsBorder = { bg = "#2c2c2d", fg = "#2c2c2d" },
      TelescopePreviewNormal = { bg = "#131313" },
      TelescopePreviewBorder = { bg = "#131313", fg = "#131313" },
    }
  end
}

monokai.setup(options)
