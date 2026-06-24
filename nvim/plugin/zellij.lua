if vim.env.ZELLIJ then
  vim.pack.add({
    "https://github.com/GR3YH4TT3R93/zellij-nav.nvim"
  })

  vim.g.zellij_nav_default_mappings = false
  require("zellij-nav").setup()

  vim.keymap.set({ "n", "t" }, "<A-h>", "<cmd>ZellijNavigateLeft<CR>")
  vim.keymap.set({ "n", "t" }, "<A-j>", "<cmd>ZellijNavigateDown<CR>")
  vim.keymap.set({ "n", "t" }, "<A-k>", "<cmd>ZellijNavigateUp<CR>")
  vim.keymap.set({ "n", "t" }, "<A-l>", "<cmd>ZellijNavigateRight<CR>")
  vim.keymap.set({ "n", "t" }, "<A-n>", "<cmd>ZellijNewPane<CR>")
  vim.keymap.set({ "n", "t" }, "<A-s>", "<cmd>ZellijNewPaneSplit<CR>")
  vim.keymap.set({ "n", "t" }, "<A-v>", "<cmd>ZellijNewPaneVSplit<CR>")
  vim.keymap.set({ "n", "t" }, "<A-f>", "<cmd>ZellijToggleFloatingPanes<CR>")
  vim.keymap.set({ "n", "t" }, "<A-x>", "<cmd>ZellijClosePane<CR>")
  vim.keymap.set({ "n", "t" }, "<A-t>", "<cmd>ZellijNewTab<CR>")

  vim.api.nvim_create_autocmd("VimLeave", {
    pattern = "*",
    command = "silent !zellij action switch-mode normal",
  })
end
