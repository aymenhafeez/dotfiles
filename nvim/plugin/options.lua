local opt = vim.opt

local builtin_plugins = {
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logiPat",
	"rrhelper",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
}
for _, plugin in pairs(builtin_plugins) do
	vim.g["loaded_" .. plugin] = 1
end

opt.smartindent = true
opt.breakindent = true
-- opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4

opt.conceallevel = 2

-- only show the cursorline in the active window
opt.cursorline = true
if vim.opt.cursorline:get() == true then
	local group = vim.api.nvim_create_augroup("CursorLineCurrentWindow", { clear = true })
	local set_cursorline = function(event, value, pattern)
		vim.api.nvim_create_autocmd(event, {
			group = group,
			pattern = pattern,
			callback = function()
				vim.opt_local.cursorline = value
			end,
		})
	end

	set_cursorline("WinLeave", false)
	set_cursorline("WinEnter", true)
end

opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes:1"
opt.wrap = false
opt.showmatch = true
opt.equalalways = false
opt.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldmethod = "marker"
opt.completeopt = { "menu", "menuone", "noselect" }
opt.scrolloff = 8
opt.sidescroll = 0

opt.ignorecase = true
opt.smartcase = true

opt.swapfile = false
opt.undofile = true
opt.inccommand = "split"

opt.formatoptions:append { "tcqj" }
opt.spelllang = "en_gb"
opt.splitright = true
opt.splitbelow = true
opt.termguicolors = true
opt.confirm = true
opt.autochdir = false
opt.mouse = "nvc"
opt.cedit = "^C"
opt.winborder = "rounded"
opt.pumborder = "rounded"
opt.pumheight = 15

vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- simplified lua implementation of cyclist.vim
opt.list = true
vim.opt.listchars = "tab:  ,nbsp:␣,extends:⋯,precedes:⋯,trail:·"
local listchars = {
	"tab:⊳ ,eol:↵,nbsp:␣,extends:⋯,precedes:⋯,trail:·",
	"tab:>-,eol:¬,nbsp:␣,extends:>,precedes:<,trail:-",
	"tab:>-,eol:↵,nbsp:␣,extends:>,precedes:<,trail:-",
	"tab:  ,eol:↲,nbsp:␣,extends:>,precedes:<,trail:·",
	"tab:»·,eol:↲,nbsp:␣,extends:>,precedes:<,trail:·",
	"tab:»·,eol:↲,nbsp:␣,extends:>,precedes:<,trail:·,space:␣",
	"",
}
local listchar_index = 1
local cyclelist_chars = function()
	listchar_index = listchar_index % #listchars + 1
	vim.opt.listchars = listchars[listchar_index]
end

vim.keymap.set("n", "<leader>cl", function()
	cyclelist_chars()
end)

-- lua file navigation
opt.include = [[\v<((do|load)file|require)[^''"]*[''"]\zs[^''"]+]]
opt.includeexpr = "substitute(v:fname,'\\.','/','g')"
for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
	opt.path:append(path .. "/lua")
end
opt.suffixesadd:prepend ".lua"

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

local fences = { "lua", "vim", "json", "shell=sh", "python", "sh", "console=sh" }
vim.g.markdown_fenced_languages = fences

vim.go.statusline = "%{%v:lua.require'ah.statusline'.statusline()%}"
-- vim.go.tabline = "%{%v:lua.require'ah.statusline'.tabline()%}"

-- -- only show winbar if laststatus = 3
-- if opt.laststatus:get() == 3 then
-- 	opt.winbar = "%=%f%m"
-- else
-- 	opt.winbar = ""
-- end

vim.cmd "colorscheme nord"

-- local function fix_colorscheme()
-- 	vim.cmd [[
-- 		highlight SpellBad gui=undercurl
-- 		highlight CursorLine ctermbg=235
-- 		highlight Comment ctermfg=gray cterm=italic gui=italic
-- 		highlight MsgSeparator guibg=bg guifg=fg
-- 		highlight Pmenu guibg=bg
-- 		highlight PmenuThumb guibg=NvimLightGrey1
-- 		highlight NormalFloat guibg=bg
-- 		highlight QuickFixLine guifg=None guibg=NvimDarkCyan
--
-- 		highlight User1 guifg=NvimLightRed guibg=NvimDarkGrey4 gui=bold
-- 		highlight User2 guifg=NvimLightBlue guibg=NvimDarkGrey4 gui=bold
-- 		highlight User3 guifg=fg guibg=NvimDarkGrey4 gui=bold
-- 		highlight User4 guifg=NvimDarkGrey4 guibg=NvimLightYellow
-- 		highlight User8 guifg=bg guibg=NvimLightGrey4
-- 		highlight User9 guifg=fg guibg=NvimDarkGrey4
-- 	]]
-- end
--
-- vim.api.nvim_create_autocmd({ "ColorScheme" }, {
-- 	group = vim.api.nvim_create_augroup("colorscheme_group", { clear = true }),
-- 	callback = fix_colorscheme
-- })
-- fix_colorscheme()
