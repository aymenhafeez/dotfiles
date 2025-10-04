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
    view_error = "notify", -- view for errors
    view_warn = "notify", -- view for warnings
    view_history = "messages", -- view for :messages
    view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
  },
  views = {
    cmdline_popup = {
      border = {
        style = "none",
        padding = { 1, 2 }
      },
      filter_options = {},
      win_options = {
        -- winhighlight = {
        --   Normal = "StatusLine",
        --   FloatBorder = "StatusLine"
        -- },
      },
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
    -- merge undo/redo messages
    {
      filter = { event = "msg_show", find = "change" },
      view = "notify",
      opts = {
        replace = true,
        merge = true,
      }
    },
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
