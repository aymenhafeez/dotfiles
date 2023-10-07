local present, breadcrumb = pcall(require, "breadcrumb")
if not present then
  return
end

local options = {
  disabled_filetype = {
    "help",
  },
  icons = {
    File = " ",
    Module = " ",
    Namespace = " ",
    Package = " ",
    Class = " ",
    Method = " ",
    Property = " ",
    Field = " ",
    Constructor = " ",
    Enum = "練",
    Interface = "練",
    Function = " ",
    Variable = " ",
    Constant = " ",
    String = " ",
    Number = " ",
    Boolean = "◩ ",
    Array = " ",
    Object = " ",
    Key = " ",
    Null = "ﳠ ",
    EnumMember = " ",
    Struct = " ",
    Event = " ",
    Operator = " ",
    TypeParameter = " ",
  },
  separator = ">",
  depth_limit = 0,
  depth_limit_indicator = "..",
  color_icons = true,
  highlight_group = {
    component = "BreadcrumbText",
    separator = "BreadcrumbSeparator",
  },

  require("breadcrumb").init()

}

breadcrumb.setup(options)
