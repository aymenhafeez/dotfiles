return {
  cmd = { "copilot-language-server", "--stdio" },
  init_options = {
    editorInfo = {
      name = "Neovim", version = tostring(vim.version()) },
    editorPluginInfo = { name = "copilot-lsp", version = "0.0.1" },
  },
  settings = { nextEditSuggestions = { enabled = true } },
  handlers = require("copilot-lsp.handlers"),
  on_init = function(client)
    local group = vim.api.nvim_create_augroup("copilot-lsp", { clear = true })
    require("copilot-lsp.nes").lsp_on_init(client, group)
  end,
}
