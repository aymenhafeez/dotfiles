local present, toggle = pcall(require, 'toggleterm')
if not present then
  return
end

local options = {
  size = function(term)
    if term.direction == 'horizontal' then
      return 11
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.45
    end
  end,
  shade_filetypes = { "help" },
  shade_terminals = false,
  persistent_size = false,
  autochdir = true,
  float_opts = {
    border = 'curved'
  },
  -- highlights = {
  --   Normal = {
  --     guibg = "#181821",
  --   },
  --   FloatBorder = {
  --     guifg = "#181821",
  --     guibg = "#181821",
  --   },
  -- },
}

-- vim.cmd('hi ToggleTerm1Normal guibg=#23272e')

toggle.setup(options)
