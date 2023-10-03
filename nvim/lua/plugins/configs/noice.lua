local present, noice = pcall(require, "noice")
if not present then
  return
end

local options = {
  cmdline = {
    enabled = true,
    -- view = "cmdline",
    -- win_options = {
    --   
    -- },
    format = {
      search_down = { kind = "search", pattern = "^/", icon = "  ", lang = "regex" },
      search_up = { kind = "search", pattern = "^%?", icon = "  ", lang = "regex" },
    }
  },
  routes = {
    {
      filter = {
        event = "msg_show",
        kind = "",
        find = "written",
      },
      opts = { skip = true },
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
    command_palette = {
      views = {
        cmdline_popup = {
          position = {
            row = -2,
            col = "2.5%",
          },
        },
      },
    },
  }
}

noice.setup(options)
