vim.schedule(function()
  vim.pack.add({ "https://github.com/stevearc/oil.nvim" }, { load = true })
  require("oil").setup {
    view_options = { show_hidden = true },
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    keymaps = {
      ["<C-v>"] = { "actions.select", opts = { vertical = true } },
      ["<C-s>"] = { "actions.select", opts = { horizontal = true } },
    }
  }
end)

vim.keymap.set("n", "<leader>-", function()
  require("oil").open()
end)

vim.keymap.set("n", "<M-.>", function() require("oil").toggle_hidden() end)

vim.keymap.set("n", "<leader>d-", function()
  local prompt = vim.fn.input("Directory> ")
  local width = vim.api.nvim_win_get_width(0)
  local split_direction = width > 130 and "vsplit" or "split"
  vim.cmd(split_direction)
  if prompt ~= "" then
    require("oil").open("~/" .. prompt)
  else
    require("oil").open()
  end
end)
