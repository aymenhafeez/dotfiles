local capabilities = nil
if pcall(require, "blink.cmp") then
	capabilities = require("blink.cmp").get_lsp_capabilities()
end

return {
	cmd = { "clangd" },
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	root_markers = {
		".clangd",
		".clang-tidy",
		".clang-format",
		"compile_commands.json",
		"compile_flags.txt",
		"configure.ac",
		".git",
	},
	capabilities = capabilities
}
