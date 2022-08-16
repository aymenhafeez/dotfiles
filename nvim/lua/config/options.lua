vim.opt.autoindent = true
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
vim.opt.linebreak = true
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
vim.opt.cmdheight = 0

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

vim.opt.autochdir = true
vim.opt.wildmenu = true
vim.opt.wildoptions = "pum"

vim.opt.autoread = true
vim.opt.hidden = true
vim.opt.ttimeoutlen = 0
vim.opt.lazyredraw = true
vim.opt.mouse = "a"
vim.opt.clipboard = 'unnamed'

vim.opt.splitright = true

vim.opt.termguicolors = true

vim.opt.rtp:append{ '/usr/local/opt/fzf' }

vim.g.CoolTotalMatches = 1
vim.g.tex_flavor = "latex"
