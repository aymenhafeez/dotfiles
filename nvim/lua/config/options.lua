vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.opt.conceallevel = 2
vim.opt.laststatus = 3
vim.opt.showtabline = 2
vim.opt.cursorline = true
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.number = true
vim.opt.numberwidth = 5
vim.opt.linebreak = true
vim.opt.guicursor = "n-i-ci-ve-v-c:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
vim.opt.cmdheight = 0
vim.opt.formatoptions = vim.opt.formatoptions - 'c'
vim.opt.spelllang='en_gb'

vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false
vim.opt.undofile = true

vim.opt.completeopt = { "menu", "menuone" }
vim.opt.omnifunc = "syntaxcomplete#Complete"
vim.opt.pumheight = 10
vim.opt.pumblend = 10
vim.opt.winblend = 10

vim.opt.autochdir = true
vim.opt.wildmenu = true
vim.opt.wildoptions = "pum"

vim.opt.autoread = true
vim.opt.hidden = true
vim.opt.ttimeoutlen = 0
vim.opt.lazyredraw = true
vim.opt.mouse = "nvia"
vim.opt.clipboard:append { 'unnamedplus' }

vim.opt.splitright = true

vim.opt.termguicolors = true

vim.o.winbar = "%{%v:lua.require'config.winbar'.get_winbar()%}"

vim.g.CoolTotalMatches = 1
vim.g.tex_flavor = "latex"

