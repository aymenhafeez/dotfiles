local present, noice = pcall(require, "noice")
if not present then
  return
end

local options = {
  cmdline = {
    enabled = true,
    format = {
      search_down = { kind = "search", pattern = "^/", icon = "  ", lang = "regex" },
      search_up = { kind = "search", pattern = "^%?", icon = "  ", lang = "regex" },
    }
  },
  messages = {
    enabled = true,
    view = "notify",
    view_error = "notify",
    view_warn = "notify",
    view_history = "messages",
    view_search = "virtualtext",
  },
  views = {
    cmdline_popup = {
      border = {
        style = "rounded",
        padding = { 0, 2 }
      },
      filter_options = {},
      position = {
        row = -2,
        col = "0%"
      },
    },
  },
  routes = {
    {
      filter = {
        event = "msg_show",
        find = "written"
      },
      view = "notify",
    },
    {
      filter = { event = "msg_show", find = "change" },
      view = "notify",
      opts = {
        replace = true,
        merge = true,
      }
    },
    {
      view = "split",
      filter = { event = "msg_show", min_height = 20 },
    },
    {
      view = "notify",
      filter = { event = "msg_showmode" },
    }
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
      enabled = false,
    },
  },
  presets = {
    lsp_doc_border = true,
  }
}

noice.setup(options)
