if vim.loader then
  vim.loader.enable()
end

require("ah.utils").version()

require "plugins"
require "ah.options"
require "ah.mappings"
require "ah.autocmds"
require "ah.globals"
require "ah.telescope"
require "ah.telescope.mappings"
