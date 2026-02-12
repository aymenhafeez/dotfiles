vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" }, { load = true })

local opts = {
  git_icons = false,
  file_icons = false,
  color_icons = false,
  winopts = {
    height = 0.8,
    width  = 0.8,
    row    = 0.5,
  },
  fzf_opts = {
    ["--cycle"] = true
  },
  keymap = {
    builtin = {
      ["<M-p>"] = "toggle-preview",
      ["<C-d>"] = "preview-page-down",
      ["<C-u>"] = "preview-page-up",
    },
  },
  fzf_colors = {
    ["bg"] = { "bg", "Normal" }
  },
}

local nopts = vim.tbl_deep_extend("force", opts, {
  winopts = {
    height = 0.6,
    width = 0.7,
    preview = { hidden = "hidden" },
  },
})

vim.keymap.set("n", "<leader>sf", function() require("fzf-lua").files(nopts) end)
vim.keymap.set("n", "<leader>s=", function() require("fzf-lua").spell_suggest() end)
vim.keymap.set("n", "<leader>tq", function() require("fzf-lua").quickfix_stack(opts) end)
vim.keymap.set("n", "<leader>:", function() require("fzf-lua").command_history() end)
vim.keymap.set("n", "<C-Space>", function() require("fzf-lua").builtin() end)
vim.keymap.set("n", "<leader>cd", function() require("fzf-lua").zoxide(opts) end)


vim.keymap.set("n", "<leader>/", function() require("fzf-lua").blines(nopts) end)

vim.keymap.set("n", "<leader>sr", function()
  require("fzf-lua").oldfiles(vim.tbl_extend("keep", nopts, { include_current_session = true }))
end)

vim.keymap.set("n", "<leader>sb", function()
  require("fzf-lua").buffers(
    vim.tbl_deep_extend("force", opts, {
      winopts = {
        height = 0.3,
        width = 0.4,
        preview = { hidden = "hidden" },
      },
    })
  )
end)

vim.keymap.set("n", "<leader>gs", function()
  require("fzf-lua").git_status(opts)
end)

vim.keymap.set("n", "<leader>sh", function()
  require("fzf-lua").helptags(opts)
end)

vim.keymap.set("n", "<leader>s.", function()
  require("fzf-lua").files(vim.tbl_extend("keep",
    nopts, { cwd = vim.fn.stdpath "config" }))
end)

vim.keymap.set("n", "<leader>sn", function()
  require("fzf-lua").files(vim.tbl_extend("keep",
    nopts, { cwd = "~/Documents/DataSci/" }))
end)

vim.keymap.set("n", "<leader>sp", function()
  require("fzf-lua").files(vim.tbl_extend("keep",
    nopts, { cwd = "~/projects" }))
end)

vim.keymap.set("n", "<leader>sl", function()
  require("fzf-lua").files(vim.tbl_extend("keep",
    nopts, { cwd = vim.fs.joinpath(vim.fn.stdpath "data", "/site/pack") }))
end)

vim.keymap.set("n", "<leader>sg", function()
  require("fzf-lua").live_grep_native(opts)
end)

vim.keymap.set("n", "<leader>gn", function()
  require("fzf-lua").live_grep_native(vim.tbl_extend("keep",
    opts, vim.tbl_extend("keep", opts, { cwd = "~/Documents/DataSci/" })))
end)

vim.keymap.set("n", "<leader>gp", function()
  require("fzf-lua").live_grep_native(vim.tbl_extend("keep",
    opts, vim.tbl_extend("keep", opts, { cwd = "~/projects/" })))
end)

vim.keymap.set("n", "<leader>g.", function()
  require("fzf-lua").live_grep_native(vim.tbl_extend("keep",
    opts, vim.tbl_extend("keep", opts, { cwd = vim.fn.stdpath("config") })))
end)

vim.keymap.set("n", "<leader>gl", function()
  require("fzf-lua").live_grep_native(vim.tbl_extend("keep",
    opts, { cwd = vim.fs.joinpath(vim.fn.stdpath "data", "/site/pack") }))
end)
