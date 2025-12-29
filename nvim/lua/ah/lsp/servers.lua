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

vim.lsp.config.ruff = {
	cmd = { vim.fn.expand "~/.local/share/nvim/mason/bin/ruff", "server" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
	capabilities = capabilities,
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

vim.lsp.config.basedpyright = {
	cmd = { "basedpyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
	capabilities = capabilities,
	settings = {
		basedpyright = {
			analysis = {
				typeCheckingMode = "standard", -- "off", "basic", "standard", or "strict"
				diagnosticMode = "openFilesOnly", -- or "workspace" for full project analysis
				useLibraryCodeForTypes = true, -- Infer types from library code
				autoSearchPaths = true,
				autoImportCompletions = true, -- Show auto-import suggestions
				diagnosticSeverityOverrides = {
					-- Customize diagnostic severity if needed
					-- reportUnusedImport = "information",
					-- reportUnusedVariable = "information",
				},
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

vim.lsp.config.texlab = {
	bibtexFormatter = "texlab",
	cmd = { "texlab" },
	filetypes = { "tex", "plaintex", "bib" },
}

vim.lsp.enable { "basedpyright", "ruff", "remark_ls", "lua_ls", "texlab" }

local ensure_installed = {
	"basedpyright",
	"ruff",
	"lua-language-server",
	"stylua",
	-- "ty",
}

require("mason-tool-installer").setup { ensure_installed = ensure_installed }
