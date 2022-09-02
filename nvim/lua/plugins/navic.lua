local status, navic = pcall(require, 'nvim-navic')
if (not status) then return end

navic.setup {
  icons = {
    Function      = " ",
    Variable      = " ",
    Struct        = " ",
  },
  highlight = true,
}
