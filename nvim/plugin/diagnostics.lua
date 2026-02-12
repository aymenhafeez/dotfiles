vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("LazyLoad", { clear = false }),
  once = true,
  callback = function()
    vim.diagnostic.config {
      severity_sort = true,
      signs = false,
      virtual_text = true,
      jump = {
        float = true,
        wrap = false,
      },
      float = {
        header = "",
        source = true
      },
      status = {
        text = {
          -- stylua: ignore start
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.INFO] = " ",
          [vim.diagnostic.severity.HINT] = " ",
          -- stylua: ignore end
        }
      }
    }

    -- :h diagnostic-toggle-virtual-lines-example
    vim.keymap.set("n", "gL", function()
      local virtlines_config = not vim.diagnostic.config().virtual_lines
      vim.diagnostic.config({ virtual_lines = virtlines_config })
    end)

    vim.keymap.set("n", "gV", function()
      local virttext_config = not vim.diagnostic.config().virtual_text
      vim.diagnostic.config({ virtual_text = virttext_config })
    end)

    vim.keymap.set("n", "<leader>sd", vim.diagnostic.setloclist)
    vim.keymap.set("n", "<leader>sD", vim.diagnostic.setqflist)
  end
})
