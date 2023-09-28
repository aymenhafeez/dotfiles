local present, noice = pcall(require, "noice")
if not present then
  return
end

local options = {
  cmdline = {
    enabled = true,
    view = "cmdline"
  },
  messages = {
    enabled = true,
    view = "notify",
    view_error = "notify",
    view_warn = "notify",
    view_history = "messages",
    view_search = "virtualtext",
  },
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
    hover = {
      enabled = false
    },
    signature = {
      enabled = false
    }
  },
  presets = {
    lsp_doc_border = true
  }
}

noice.setup(options)
