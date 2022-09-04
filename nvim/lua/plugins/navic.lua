local present, navic = pcall(require, "nvim-navic")
if not present then
  return
end

navic.setup {
  icons = {
    Function      = " ",
    Variable      = " ",
    Struct        = " ",
    Module        = " ",
    Field         = "[] ",
  },
  highlight = true,
}
   -- icons = { -- default icons
   --      File          = " ",
   --      Module        = " ",
   --      Namespace     = " ",
   --      Package       = " ",
   --      Class         = " ",
   --      Method        = " ",
   --      Property      = " ",
   --      Constructor   = " ",
   --      Enum          = "練",
   --      Interface     = "練",
   --      Function      = " ",
   --      Variable      = " ",
   --      Constant      = " ",
   --      String        = " ",
   --      Number        = " ",
   --      Boolean       = "◩ ",
   --      Array         = " ",
   --      Object        = " ",
   --      Key           = " ",
   --      Null          = "ﳠ ",
   --      EnumMember    = " ",
   --      Struct        = " ",
   --      Event         = " ",
   --      Operator      = " ",
   --      TypeParameter = " ",
   --  },
