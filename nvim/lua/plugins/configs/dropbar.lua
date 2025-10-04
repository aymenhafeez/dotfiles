local present, dropbar = pcall(require, "dropbar")
if not present then
  return
end

local options = {
  bar = {
    enable = function(buf, win, _)
      return not vim.api.nvim_win_get_config(win).zindex
        and (vim.bo.buftype == '' or vim.bo[buf].buftype == 'toggleterm'
        or vim.bo[buf].buftype == 'terminal')
        and vim.api.nvim_buf_get_name(buf) ~= ''
        and not vim.wo[win].diff
    end,
  },
  icons = {
    enable = true,
    kinds = {
      symbols = {
        Function = " ",
        Method = " ",
        String = " ",
        Variable = " "
      }
    }
  }
}

return dropbar.setup(options)
