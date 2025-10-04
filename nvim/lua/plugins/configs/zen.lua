local present, zen = pcall(require, "zen-mode")
if not present then
  return
end

local options = {
  window = {
    backdrop = 1,
    -- width = 0.6,

    width = function()
      local max_width = 200
      local min_width = 85
      local percentage = 0.6
      local target = math.floor(vim.o.columns * percentage)
      if target > max_width then
        return max_width
      elseif target < min_width then
        return min_width
      else
        return target
      end
    end,

    height= 0.92,
    options = {
      number = false,
      relativenumber = false,
      cursorline = false,
      cursorcolumn = false,
      list = false
    }
  },
  plugins = {
    options = {
      laststatus = 0,
      showcmd = false
    },
    tmux = { enabled = true },
  }
}

return zen.setup(options)
