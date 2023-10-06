local present, toggle = pcall(require, 'toggleterm')
if not present then
  return
end

local options = {
  size = function(term)
    if term.direction == 'horizontal' then
      return 13
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.45
    end
  end,
  -- highlights = {
  --   Normal = {
  --     guibg = "#1e2227"
  --   }
  -- },
  shade_filetypes = { "help" },
  shade_terminals = false,
  persistent_size = false,
  autochdir = true,
  float_opts = {
    border = 'curved'
  }
}

-- vim.cmd('hi ToggleTerm1Normal guibg=#23272e')

toggle.setup(options)
