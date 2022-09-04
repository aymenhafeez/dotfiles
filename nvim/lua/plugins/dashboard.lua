local home = os.getenv('HOME')
local db = require('dashboard')
-- macos
-- db.preview_command = 'cat | lolcat -F 0.3'
--
-- db.preview_file_path = home .. '/.config/nvim/static/neovim.cat'
db.preview_file_height = 11
db.preview_file_width = 70
db.custom_center = {
  { icon = '  ',
    desc = 'Find  file                              ',
    action = 'Telescope find_files find_command=rg,--hidden,--files',
    shortcut = 'SPC s f' },
  { icon = '  ',
    desc = 'Recently used files                     ',
    action = 'Telescope old_files',
    shortcut = 'SPC s r' },
  { icon = '  ',
    desc = 'Search notes                            ',
    action = 'Telescope find_files cwd=~/Dropbox/notes/MyNotes/',
    shortcut = 'SPC s n' },
  { icon = '  ',
    desc = 'Search help                             ',
    action = 'Telescope help_tags',
    shortcut = 'SPC h h' },
  { icon = '  ',
    desc = 'Open Personal dotfiles                  ',
    action = 'Telescope find_files cwd=~/.config/nvim/',
    shortcut = 'SPC s .' },
}

db.custom_header = {
  [[                                          _.oo. ]],
  [[                  _-u[[/;:,.         .odMMMMMM' ]],
  [[               .o888UU[[[/;:-.. .o@P^    MMM^   ]],
  [[              oN88888UU[[[/;::-..       dP^     ]],
  [[             dNMMNN888UU[[[/;:--..  .o@P^       ]],
  [[            ,MMMMMMN888UU[[/;::-..o@^           ]],
  [[            NNMMMNN888UU[[[/~.o@P^              ]],
  [[            888888888UU[[[/o@^-...              ]],
  [[           oI8888UU[[[/o@P^:--....              ]],
  [[        .@^  YUU[[[/o@^;::---....               ]],
  [[      oMP     ^/o@P^;:::---....                 ]],
  [[   .dMMM    .o@^ ^;::---.....                   ]],
  [[  dMMMMMMM@^`       `^^^^^                      ]],
  [[ YMMMUP^                                        ]],
  [[                                                ]],
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
  .. "   "
  .. datetime

  -- local quote = table.concat(fortune(), "\n")

  return plugins_text
end

vim.cmd [[
hi DashboardShortcut guifg=#c678dd
]]

-- db.custom_footer = footer()
