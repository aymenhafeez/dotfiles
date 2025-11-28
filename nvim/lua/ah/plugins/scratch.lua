return {
  dir = "~/Documents/projects/scratch.nvim/",
  config = function()
    require("scratch").setup {
      win_options = {
        number = true,
      },
    }

    vim.keymap.set("n", "<leader>ss", function()
      require("scratch").toggle {
        window_type = "float",
        float_config = {
          border = "rounded",
        },
      }
    end)

    vim.keymap.set("n", "<leader>sc", function()
      require("scratch").toggle {
        window_type = "split",
      }
    end)
  end,
}
