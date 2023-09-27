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
  persistent_size = false,
  autochdir = true,
  float_opts = {
    border = 'curved'
  }
}

toggle.setup(options)
