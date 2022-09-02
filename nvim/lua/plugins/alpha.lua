local M = {}

function M.setup()
  local status_ok, alpha = pcall(require, "alpha")
  if not status_ok then
    return
  end

  local dashboard = require "alpha.themes.dashboard"
  dashboard.section.header.opts.hl = "Type"
  dashboard.section.header.val = {
      [[                                                ]],
      [[                                          _.oo. ]],
      [[                  _.u[[/;:,.         .odMMMMMM' ]],
      [[               .o888UU[[[/;:-.  .o@P^    MMM^   ]],
      [[              oN88888UU[[[/;::-.        dP^     ]],
      [[             dNMMNN888UU[[[/;:--.   .o@P^       ]],
      [[            ,MMMMMMN888UU[[/;::-. o@^           ]],
      [[            NNMMMNN888UU[[[/~.o@P^              ]],
      [[            888888888UU[[[/o@^-..               ]],
      [[           oI8888UU[[[/o@P^:--..                ]],
      [[        .@^  YUU[[[/o@^;::---..                 ]],
      [[      oMP     ^/o@P^;:::---..                   ]],
      [[   .dMMM    .o@^ ^;::---...                     ]],
      [[  dMMMMMMM@^`       `^^^^                       ]],
      [[ YMMMUP^                                        ]],
      [[  ^^                                            ]],
      [[                                                ]],
  }


  dashboard.section.buttons.val = {
    dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
    dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
    dashboard.button("n", "  Search notes", ":Telescope find_files cwd=~/Dropbox/notes/MyNotes/<CR>"),
    dashboard.button("h", "  Search help", ":Telescope help_tags<CR>"),
    dashboard.button("c", "  Configuration", ":Telescope find_files cwd=~/.config/nvim/<CR>"),
    dashboard.button("u", "  Update plugins", "<cmd>PackerSync<CR>"),
    dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
  }

  local function footer()
    local total_plugins = #vim.tbl_keys(packer_plugins)
    local datetime = os.date "%d-%m-%Y %H:%M:%S"
    local plugins_text = "   "
        .. total_plugins
        .. " plugins"
        .. "   v"
        .. vim.version().major
        .. "."
        .. vim.version().minor
        .. "."
        .. vim.version().patch
        .. "   "
        .. datetime

    -- Quote
    local fortune = require "alpha.fortune"
    local quote = table.concat(fortune(), "\n")

    return plugins_text .. "\n" .. quote
  end

  dashboard.section.footer.val = footer()

  dashboard.section.footer.opts.hl = "Type"
  dashboard.section.header.opts.hl = "Include"
  dashboard.section.buttons.opts.hl = "Keyword"

  dashboard.opts.opts.noautocmd = true
  alpha.setup(dashboard.opts)
end

return M
