local capabilities = nil
if pcall(require, "blink.cmp") then
	capabilities = require("blink.cmp").get_lsp_capabilities()
end

return {
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
