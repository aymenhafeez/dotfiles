local opts = {
  hidden     = true,
  winopts    = {
    backdrop = 100,
    height   = 0.7,
    preview  = { hidden = "hidden" },
  },
  fzf_opts   = {
    ["--layout"] = "default",
    ["--cycle"] = true,
  },
  keymap     = {
    builtin = {
      ["<M-p>"]      = "toggle-preview",
      ["<S-down>"]   = "preview-page-down",
      ["<S-up>"]     = "preview-page-up",
      ["<M-S-j>"] = "preview-down",
      ["<M-S-k>"]   = "preview-up",
    },
    fzf = {
      ["ctrl-q"] = "select-all+accept",
      ["ctrl-n"] = "up",
      ["ctrl-p"] = "down",
    },
  },
  fzf_colors = {
    true,
    ["bg"] = { "bg", "FzfLuaNormal" }
  }
}

vim.schedule(function()
  vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" }, { load = false })
  require("fzf-lua").setup(opts)
end)

vim.keymap.set("n", "<leader>f", function() require("fzf-lua").files(opts) end)
vim.keymap.set("n", "<C-p>", function() require("fzf-lua").files(opts) end)
vim.keymap.set("n", "<leader><C-b>", function() require("fzf-lua").builtin(opts) end)
vim.keymap.set("n", "<leader>b", function() require("fzf-lua").buffers(opts) end)

vim.keymap.set("n", "<leader>/", function() require("fzf-lua").blines(opts) end)

vim.keymap.set("n", "<leader>sr", function()
  require("fzf-lua").oldfiles(
    vim.tbl_extend("keep", opts, {
      include_current_session = true
    })
  )
end)

vim.keymap.set("n", "gS", function()
  require("fzf-lua").git_status()
end)

vim.keymap.set("n", "<leader>h", function()
  require("fzf-lua").helptags()
end)

vim.keymap.set("n", "<leader>s.", function()
  require("fzf-lua").files(vim.tbl_extend("keep",
    opts, { cwd = vim.fn.stdpath "config" }))
end)

vim.keymap.set("n", "<leader>sn", function()
  require("fzf-lua").files(vim.tbl_extend("keep",
    opts, { cwd = "~/Documents/DataSci/" }))
end)

vim.keymap.set("n", "<leader>sp", function()
  require("fzf-lua").files(vim.tbl_extend("keep",
    opts, { cwd = "~/projects" }))
end)

vim.keymap.set("n", "<leader>sl", function()
  require("fzf-lua").files(vim.tbl_extend("keep",
    opts, { cwd = vim.fs.joinpath(vim.fn.stdpath "data", "/site/pack") }))
end)

vim.keymap.set("n", "<leader>sg", function()
  require("fzf-lua").live_grep_native()
end)

vim.keymap.set("n", "<leader>gn", function()
  require("fzf-lua").live_grep_native(vim.tbl_extend("keep",
    opts, { cwd = "~/Documents/DataSci/" }))
end)

vim.keymap.set("n", "<leader>gp", function()
  require("fzf-lua").live_grep_native(vim.tbl_extend("keep",
    opts, { cwd = "~/projects/" }))
end)

vim.keymap.set("n", "<leader>g.", function()
  require("fzf-lua").live_grep_native(vim.tbl_extend("keep",
    opts, { cwd = vim.fn.stdpath("config") }))
end)

vim.keymap.set("n", "<leader>gl", function()
  require("fzf-lua").live_grep_native(vim.tbl_extend("keep",
    opts, { cwd = vim.fs.joinpath(vim.fn.stdpath "data", "/site/pack") }))
end)
