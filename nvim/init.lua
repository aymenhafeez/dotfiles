if vim.loader then
  vim.loader.enable()
end

require("ah.utils").version()

require "ah.options"
require "plugins"
require "ah.mappings"
require "ah.autocmds"
require "ah.globals"
require "ah.telescope"
require "ah.telescope.mappings"
