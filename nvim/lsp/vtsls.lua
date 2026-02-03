local capabilities = nil
if pcall(require, "blink.cmp") then
  capabilities = require("blink.cmp").get_lsp_capabilities()
end

return {
  cmd = { "vtsls", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  init_options = {
    hostInfo = "neovim"
  },
  capabilities = capabilities
}
