local present, zen = pcall(require, "true-zen")
if not present then
  return
end

zen.setup {
  modes = {
    ataraxis = {
      minimum_writing_area = {
        width = 100,
        height = 100
      },
      padding = { -- padding windows
        left = 52,
        right = 52,
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
    lualine = true,
    tmux = true
  }
}
