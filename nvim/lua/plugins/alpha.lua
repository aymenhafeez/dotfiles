local present, alpha = pcall(require, "alpha")
if not present then
  return
end

local dashboard = require("alpha.themes.dashboard")
math.randomseed(os.time())

local function button(sc, txt, keybind, keybind_opts)
  local b = dashboard.button(sc, txt, keybind, keybind_opts)
  b.opts.hl = "Keyword"
  b.opts.hl_shortcut = "TSField"
  return b
end

local function footer()
  local total_plugins = #vim.tbl_keys(packer_plugins)
  local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
  return "   v"
    .. vim.version().major
    .. "."
    .. vim.version().minor
    .. "."
    .. vim.version().patch
    .. "   "
    .. total_plugins
    .. " plugins"
    .. "  " .. datetime
end

local group = vim.api.nvim_create_augroup("CleanDashboard", {})
vim.api.nvim_create_autocmd("User", {
  callback = function()
    vim.opt.showtabline = 0
    vim.opt.showmode = false
    vim.opt.laststatus = 0
    vim.opt.showcmd = false
    vim.opt.ruler = false
  end,
  group = group,
  pattern = "AlphaReady",
})

vim.api.nvim_create_autocmd("BufUnload", {
  callback = function()
    vim.opt.showtabline = 2
    vim.opt.showmode = true
    vim.opt.laststatus = 3
    vim.opt.showcmd = true
    vim.opt.ruler = true
  end,
  group = group,
  pattern = "<buffer>",
})

dashboard.section.header.val = {
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

dashboard.section.header.opts.hl = "Type"

dashboard.section.buttons.val = {
  button("SPC s f", "  Find file"),
  button("SPC s r", "  Recently used files"),
  button("SPC s n", "  Search notes"),
  button("SPC h h", "  Search help"),
  button("SPC s .", "  Settings"),
  button("SPC p s", "  Update plugins"),
  button("q", "  Quit", "<Cmd>qa<CR>"),
}

dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = "Type"

alpha.setup(dashboard.opts)
