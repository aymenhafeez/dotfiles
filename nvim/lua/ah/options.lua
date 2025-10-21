-- ============================================================================
-- OPTIONS
-- ============================================================================

local opt = vim.opt
local g = vim.g

-- Disable Builtin Plugins
local builtin_plugins = {
  "2html_plugin", "getscript", "getscriptPlugin", "gzip", "logipat", "netrw",
  "netrwPlugin", "netrwSettings", "netrwFileHandlers", "matchit", "tar", "tarPlugin",
  "rrhelper", "spellfile_plugin", "vimball", "vimballPlugin", "zip", "zipPlugin",
  "tutor", "rplugin", "syntax", "synmenu", "optwin", "compiler", "bugreport", "ftplugin",
}
for _, plugin in pairs(builtin_plugins) do
  g["loaded_" .. plugin] = 1
end

-- Indentation
opt.autoindent = true
opt.smartindent = true
opt.breakindent = true
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4

-- UI
opt.conceallevel = 2
opt.laststatus = 3
opt.cursorline = true
opt.showmode = false
opt.showcmd = false
opt.cmdheight = 0
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.signcolumn = "yes:1"
opt.wrap = false

-- Search
opt.hlsearch = true
opt.ignorecase = true
opt.incsearch = true
opt.smartcase = true

-- File handling
opt.backup = false
opt.swapfile = false
opt.writebackup = false
opt.undofile = true
opt.inccommand = "split"
opt.autoread = true
opt.hidden = true

-- Completion
opt.completeopt = { "menu", "menuone" }
opt.omnifunc = "syntaxcomplete#Complete"
opt.pumheight = 12
opt.scrolloff = 7
opt.winborder = 'rounded'

-- Misc
opt.formatoptions:remove { "c" }
opt.spelllang = "en_gb"
opt.ttimeoutlen = 0
opt.mousemoveevent = true
opt.clipboard = "unnamedplus"
opt.path:append { "**" }
opt.splitright = true
opt.splitbelow = true
opt.termguicolors = true
opt.background = "dark"
opt.autochdir = true
opt.wildmenu = true
opt.wildoptions = "pum"
vim.o.list = true
vim.o.confirm = true

-- Lua file navigation
opt.include = [[\v<((do|load)file|require)[^''"]*[''"]\zs[^''"]+]]
opt.includeexpr = "substitute(v:fname,'\\.','/','g')"
for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
  opt.path:append(path .. '/lua')
end
opt.suffixesadd:prepend('.lua')

-- Plugin globals
g.UltiSnipsExpandTrigger = "<tab>"
g.UltiSnipsJumpForwardTrigger = "<tab>"
g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
g.UltiSnipsNoPythonWarning = 1
g.scratch_filetype = "lua"
g.tex_flavor = "latex"

local fences = { "lua", "vim", "json", "shell=sh", "python", "sh", "console=sh" }
g.markdown_fenced_languages = fences

g.calmblue_variant = "darkerblue"
vim.cmd.colorscheme("calmblue")
