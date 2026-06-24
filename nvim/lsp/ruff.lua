return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
  init_options = {
    settings = {
      configuration = "~/.config/ruff/ruff.toml",
    },
  },

  on_attach = function(client)
    client.server_capabilities.hoverProvider = false
  end,
}
