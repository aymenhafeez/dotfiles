local navic = require("nvim-navic")
local colors = require "config.colors"

navic.setup {
    icons = {
    --     File          = " ",
    --     Module        = " ",
    --     Namespace     = " ",
    --     Package       = " ",
    --     Class         = " ",
    --     Method        = " ",
    --     Property      = " ",
    --     Field         = " ",
    --     Constructor   = " ",
    --     Enum          = "練",
    --     Interface     = "練",
    --     Function      = " ",
        Function      = " ",
        Variable      = " ",
    --     Constant      = " ",
    --     String        = " ",
    --     Number        = " ",
    --     Boolean       = "◩ ",
    --     Array         = " ",
    --     Object        = " ",
    --     Key           = " ",
    --     Null          = "ﳠ ",
    --     EnumMember    = " ",
        Struct        = " ",
    --     Event         = " ",
    --     Operator      = " ",
    --     TypeParameter = " ",
    },
    highlight = true,
}

-- vim.api.nvim_set_hl(0, "NavicIconsClass", { fg = colors.yellow3 })
-- vim.api.nvim_set_hl(0, "NavicIconsVariable", { fg = colors.blue })
-- vim.api.nvim_set_hl(0, "NavicIconsModule", { fg = colors.blue })
-- vim.api.nvim_set_hl(0, "NavicIconsMethod", { fg = colors.dark_purple })
-- vim.api.nvim_set_hl(0, "NavicIconsField", { fg = colors.dark_purple })
-- vim.api.nvim_set_hl(0, "NavicIconsFunction", { fg = colors.blue })
-- vim.api.nvim_set_hl(0, "NavicIconsProperty", { fg = colors.blue, bold = false})
-- vim.api.nvim_set_hl(0, "NavicIconsEnum", { fg = colors.dark_purple })
-- vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { fg = colors.yellow })
-- vim.api.nvim_set_hl(0, "NavicIconsTypeParamter", { fg = colors.yellow })
-- vim.api.nvim_set_hl(0, "NavicIconsConstant", { fg = colors.green })
-- vim.api.nvim_set_hl(0, "NavicIconsStruct", { fg = colors.blue })
-- vim.api.nvim_set_hl(0, "NavicText", { fg = colors.light_grey2, italic = false, bold = false })
-- vim.api.nvim_set_hl(0, "NavicSeparator", { fg = colors.nord_blue})
