local opt = vim.opt
local o = vim.o
local g = vim.g

opt.autoindent = true
opt.smartindent = true
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4

opt.conceallevel = 2
opt.laststatus = 3
opt.showtabline = 2
opt.cursorline = true
opt.showmode = false
opt.showcmd = false
opt.number = true
opt.numberwidth = 4
opt.linebreak = true
opt.guicursor = "n-i-ci-ve-v-c:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
opt.cmdheight = 0
opt.formatoptions = vim.opt.formatoptions - "c"
opt.spelllang = "en_gb"
opt.shortmess:append "sI"

opt.hlsearch = true
opt.ignorecase = true
opt.incsearch = true
opt.smartcase = true
opt.backup = false
opt.swapfile = false
opt.writebackup = false
opt.undofile = true
opt.inccommand = "split"

opt.completeopt = { "menu", "menuone" }
opt.omnifunc = "syntaxcomplete#Complete"
opt.pumheight = 10
opt.pumblend = 10
opt.winblend = 10

opt.autochdir = true
opt.wildmenu = true
opt.wildoptions = "pum"

opt.autoread = true
opt.hidden = true
opt.ttimeoutlen = 0
opt.lazyredraw = true
opt.mouse = "nvia"
opt.clipboard = "unnamedplus"
opt.path:append { "**" }

opt.splitright = true

opt.termguicolors = true

o.winbar = "%{%v:lua.require'ah.winbar'.get_winbar()%}"

g.CoolTotalMatches = 1
g.tex_flavor = "latex"

g.UltiSnipsExpandTrigger = "<tab>"
g.UltiSnipsJumpForwardTrigger = "<tab>"
g.UltiSnipsJumpBackwardTrigger = "<s-tab>"

g.scratch_filetype = "lua"

vim.cmd [[
let g:OxfDictionary#app_id="ed82927e"
let g:OxfDictionary#app_key="97ed8b2daccd553e7f62a3aebdbdc492"
]]

local default_plugins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "tutor",
  "rplugin",
  "syntax",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  "ftplugin",
}

for _, plugin in pairs(default_plugins) do
  g["loaded_" .. plugin] = 1
end

local colorscheme = "neodark"

if colorscheme == "onedark" then
  require("onedark").setup({
    style = "deep"
  })
end

if colorscheme == "catppuccin" then
  vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
end

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
