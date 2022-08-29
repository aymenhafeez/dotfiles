local api = vim.api
local opts = { noremap = true, silent = true }

api.nvim_set_keymap("n", "<leader>z", ":TZMinimalist<CR>", opts)
api.nvim_set_keymap("n", "<leader>x", ":TZAtaraxis<CR>", opts)

local function open_opts()
  vim.o.cursorline = false
  vim.o.cmdheight = 0
  vim.o.winbar = ""
end

local function close_opts()
  vim.o.winbar = "%{%v:lua.require'config.winbar'.get_winbar()%}"
  vim.o.cursorline = true
end

require("true-zen").setup {
  modes = {
    ataraxis = {
      padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
      },
      callbacks = {
        open_pos = open_opts(),
        close_pos = close_opts()
      }
    },
    minimalist = {
      ignored_buf_types = { "nofile" },
      options = {
        signcolumn = "yes",
        cmdheight = 0,
        winbar = false,
      },
    },
  },
  integrations = {
    lualine = true
  }
}
