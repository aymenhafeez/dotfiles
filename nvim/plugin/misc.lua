vim.schedule(function()
  vim.pack.add({
    "https://github.com/folke/snacks.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/neogitorg/neogit",
    "https://github.com/sindrets/diffview.nvim",
    "https://github.com/copilotlsp-nvim/copilot-lsp"
  }, { load = true })

  require("neogit").setup {
    graph_style = "unicode"
  }

  require("diffview").setup {
    use_icons = false
  }

  require("snacks").setup({
    input = { enabled = false },
    image = {
      enabled = true,
      math = {
        latex = {
          font_size = "normalsize"
        }
      }
    },
    styles = {
      snacks_image = { focusable = true },
    },
  })

  vim.keymap.set("n", "<leader>im", function() require("snacks").image.hover() end)
end)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "snacks_picker_input",
  callback = function()
    vim.b.minicompletion_disable = true
  end,
})

vim.g.copilot_nes_debounce = 250

vim.keymap.set("n", "<Tab>", function()
  if not vim.b.nes_state then
    return "<C-i>"
  end

  local nes = require("copilot-lsp.nes")
  if not nes.walk_cursor_start_edit() and nes.apply_pending_nes() then
    nes.walk_cursor_end_edit()
  end
end, { expr = true })

vim.keymap.set("n", "<Esc>", function()
  if vim.b.nes_state then
    require("copilot-lsp.nes").clear()
  end
  return "<Esc>"
end, { expr = true })
