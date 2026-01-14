local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, util_opts, ...)
	util_opts = util_opts or {}
	util_opts.max_width = 75
	util_opts.max_height = 15
	return orig_util_open_floating_preview(contents, syntax, util_opts, ...)
end

local capabilities = nil
if pcall(require, "blink.cmp") then
	capabilities = require("blink.cmp").get_lsp_capabilities()
end

vim.lsp.config.basedpyright = {
	cmd = { "basedpyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
	capabilities = capabilities,
	settings = {
		basedpyright = {
			analysis = {
				typeCheckingMode = "standard",
				diagnosticMode = "openFilesOnly",
				useLibraryCodeForTypes = true,
				autoSearchPaths = true,
				autoImportCompletions = true,
			},
		},
	},
}

vim.lsp.config.lua_ls = {
	cmd = { vim.fn.expand "~/.local/share/nvim/mason/bin/lua-language-server" },
	filetypes = { "lua" },
	root_markers = {
		".luarc.json",
		".luarc.jsonc",
		".luacheckrc",
		".stylua.toml",
		"stylua.toml",
		"selene.toml",
		".git",
	},
	capabilities = capabilities,
	settings = {
		Lua = {
			hint = {
				enable = true,
			},
			completion = {
				callSnippet = "Replace",
			},
		},
	},
}

vim.lsp.config.remark_ls = {
	cmd = { "remark-language-server", "--stdio" },
	filetypes = { "markdown" },
	root_markers = { ".remarkrc", ".remarkrc.json", ".remarkrc.js", "package.json", ".git" },
	capabilities = capabilities,
	settings = {
		remark = {
			requireConfig = false,
		},
	},
}

vim.lsp.config.texlab = {
	bibtexFormatter = "texlab",
	cmd = { "texlab" },
	filetypes = { "tex", "plaintex", "bib" },
}

vim.lsp.config.vimls = {
	cmd = { "vim-language-server", "--stdio" },
	filetypes = { "vim" },
	init_options = {
		diagnostic = {
			enable = true,
		},
		indexes = {
			count = 3,
			gap = 100,
			projectRootPatterns = { "runtime", "nvim", ".git", "autoload", "plugin" },
			runtimepath = true,
		},
		isNeovim = true,
		iskeyword = "@,48-57,_,192-255,-#",
		runtimepath = "",
		suggest = {
			fromRuntimepath = true,
			fromVimruntime = true,
		},
		vimruntime = "",
	},
}

vim.lsp.config.vtsls = {
	cmd = { "vtsls", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	init_options = {
		hostInfo = "neovim",
	},
}

vim.lsp.config.rust_analyzer = {
	cmd = { vim.fn.expand "~/.local/share/nvim/mason/bin/rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { "Cargo.toml", "rust-project.json" },
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {
			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self",
			},
			cargo = {
				buildScripts = {
					enable = true,
				},
			},
			procMacro = {
				enable = true,
			},
		},
	},
}

vim.lsp.enable { "basedpyright", "lua_ls", "texlab", "vimls", "vtsls", "rust_analyzer" }

local ensure_installed = {
	"vtsls",
	"basedpyright",
	"ruff",
	"lua-language-server",
	"stylua",
	"vim-language-server",
	"rust-analyzer",
}

require("mason-tool-installer").setup { ensure_installed = ensure_installed }
