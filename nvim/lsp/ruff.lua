return {
	cmd = { "ruff", "server" },
	filetypes = { "python" },

	on_attach = function(client)
		client.server_capabilities.diagnosticProvider = nil
	end,
}
