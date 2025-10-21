return {
  { 'NMAC427/guess-indent.nvim', event = 'BufReadPre' },
  { 'kylechui/nvim-surround', event = 'InsertEnter', opts = {} },
  { 'windwp/nvim-autopairs', event = 'InsertEnter', opts = {} },
  { 'moll/vim-bbye', cmd = { 'Bdelete', 'Bwipeout' } },
  { 'tpope/vim-scriptease', cmd = { 'Messages', 'Verbose' } },
  { 'lewis6991/gitsigns.nvim', event = 'BufReadPre', opts = {} },

  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 2000,
      stages = "no_animation",
      render = "wrapped-compact",
      top_down = false,
    }
  },

  {
    'folke/zen-mode.nvim',
    cmd = { 'ZenMode' },
    opts = {
      window = {
        backdrop = 1,
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
        twilight = { enabled = false },
        tmux = { enabled = true },
      }
    }
  },
}
