local present, zen = pcall(require, "true-zen")
if not present then
  return
end

zen.setup {
  modes = {
    ataraxis = {
      padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
      },
    },
    minimalist = {
      ignored_buf_types = { "nofile" },
      options = {
        signcolumn = "yes",
        cmdheight = 0,
        winbar = false,
        cursorline = false
      },
    },
  },
  integrations = {
    lualine = true
  }
}
