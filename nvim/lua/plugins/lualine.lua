local status, lualine = pcall(require, "lualine")
if (not status) then return end

-- onedark deep cursorline bg = '#21283b'
-- onedark darker cursorline bg = '#282c34'
-- lighter onedark cursorline bg = '2c313a'
-- astrovim theme cursorline bg = '#252931'
-- astrovim2 theme cursorline bg = '#2c323c'
-- medium bg = '#222732'
-- dark statusline color option = '#1b1f27'
-- darker statusline color option = '#181c23'
-- another dark statusline color option = '#191d25'

-- stylua: ignore
local colors = {
    bg       = '#191d25',
    fg       = '#bbc2cf',
    yellow   = '#e5c07b',
    cyan     = '#008080',
    darkblue = '#081633',
    green    = '#98c379',
    orange   = '#FF8800',
    violet   = '#a9a1e1',
    magenta  = '#c678dd',
    blue     = '#61afef',
    blue_1   = '#8094b4',
    blue_2   = '#51afef',
    red      = '#ec5f67',
}

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

local config = {
    options = {
        component_separators = '',
        section_separators = '',
        theme = {
            normal = { c = { fg = colors.fg, bg = colors.bg } },
            inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },
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
        return '▊'
    end,
    color = function()
        local mode_color = {
            n = colors.blue,
            i = colors.green,
            v = colors.magenta,
            [''] = colors.blue,
            V = colors.magenta,
            c = colors.yellow,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [''] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ['r?'] = colors.cyan,
            ['!'] = colors.red,
            t = colors.orange,
        }
        return { fg = mode_color[vim.fn.mode()] }
    end,
    padding = { left = 0, right = 1 },
}

-- ins_left {
--   -- filesize component
--   'filesize',
--   cond = conditions.buffer_not_empty,
--   padding = { left = 1, right = 2 }
-- }

-- ins_left {
--   'filename',
--   file_status = true,
--   cond = conditions.buffer_not_empty,
--   symbols = {
--     -- modified = ' ●',
--     modified = ' ',
--     readonly = ' -',
--   },
--   color = { fg = colors.fg, gui = 'bold' },
--   padding = { left = 0, right = 2 },
-- }

ins_left {
    'filetype',
    cond = conditions.buffer_not_empty,
    icon_only = false,
    color = { fg = colors.fg, gui = '' },
    padding = { left = 0, right = 2 },
}

ins_left {
    'branch',
    color = { fg = colors.orange, gui = 'bold' },
    padding = { left = 1, right = 2 },
}

ins_left {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    symbols = { error = ' ', warn = ' ', info = ' ' },
    diagnostics_color = {
        color_error = { fg = colors.red },
        color_warn = { fg = colors.yellow },
        color_info = { fg = colors.cyan },
    },
}

ins_left {
    'diff',
    -- Is it me or the symbol for modified us really weird
    symbols = { added = ' ', modified = ' ', removed = ' ' },
    diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
    },
    cond = conditions.hide_in_width,
    padding = { left = 2, right = 2 },
}

ins_right {
    function()
        local b = vim.api.nvim_get_current_buf()
        if next(vim.treesitter.highlighter.active[b]) then
            return ""
        end
        return ""
    end,
    color = { fg = colors.blue_1 },
    padding = { left = 2, right = 2 },
    cond = conditions.hide_in_width,
}

ins_right {
    function()
        local msg = 'LS Inactive'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
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
    icon = '',
    color = { fg = '#a0a8b7', gui = 'bold' },
    padding = { left = 1, right = 2 }
}


-- ins_right { 'location', padding = { left = 1, right = 1}}

ins_right { 'progress', color = { fg = colors.fg } }

ins_right {
    function()
        local current_line = vim.fn.line "."
        local total_lines = vim.fn.line "$"
        local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
        local line_ratio = current_line / total_lines
        local index = math.ceil(line_ratio * #chars)
        return chars[index]
    end,
    color = { fg = colors.yellow, gui = '' },
    padding = { right = 1, left = 0 }
}

ins_right {
    function()
        return '▊'
    end,
    color = function()
        local mode_color = {
            n = colors.blue,
            i = colors.green,
            v = colors.magenta,
            [''] = colors.blue,
            V = colors.magenta,
            c = colors.yellow,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [''] = colors.orange,
            ic = colors.yellow,
            R = colors.red,
            Rv = colors.red,
            cv = colors.violet,
            ce = colors.violet,
            r = colors.cyan,
            rm = colors.cyan,
            ['r?'] = colors.cyan,
            ['!'] = colors.red,
            t = colors.orange,
        }
        return { fg = mode_color[vim.fn.mode()] }
    end,
    padding = { left = 0, right = 0 },
}

lualine.setup(config)
