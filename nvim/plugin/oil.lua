vim.pack.add({ "https://github.com/stevearc/oil.nvim" }, { load = false })

require("oil").setup {
  win_options = {
    statuscolumn = " ",
    number = false,
  },
  delete_to_trash = true,
  keymaps = {
    ["<C-v>"] = { "actions.select", opts = { vertical = true } },
    ["<C-s>"] = { "actions.select", opts = { horizontal = true } },
  }
}

vim.keymap.set("n", "<leader>-", function()
  require("oil").open()
end)

vim.keymap.set("n", "<leader>d-", function()
  local prompt = vim.fn.input("Directory> ")
  if prompt == "" then
    return ""
  end
  require("oil").open_float("~/" .. prompt)
end)
