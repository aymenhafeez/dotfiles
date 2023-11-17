local present, saga = pcall(require, "lspsaga")
if not present then
  return
end

local options = {
  ui = {
    code_action = '💡',
  },
  lightbulb = {
    sign = false
  },
  symbol_in_winbar = {
    separator = "  ",
    folder_level = 0,
    color_mode = true
  },
  outline = {
    win_width = 35
  }
}

vim.cmd("hi SagaWinbarSep guifg=#93a4c3")

saga.setup(options)
