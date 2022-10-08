local util = require("ah.utils")

require "ah.options"
require "ah.mappings"
require "ah.statusline"

vim.schedule(function()
  util.version()
  util.require "plugins"
  util.require "ah.autocmds"
  util.require "ah.globals"
  util.require "ah.telescope"
  util.require "ah.telescope.mappings"
end)
