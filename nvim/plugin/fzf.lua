vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" }, { load = true })

local function get_dynamic_width()
  return vim.o.columns > 150 and 0.7 or 0.85
end

local opts = {
  git_icons = false,
  file_icons = false,
  color_icons = false,
  fzf_opts = {
    ["--cycle"] = true,
  },
  keymap = {
    builtin = {
      ["<M-p>"] = "toggle-preview",
      ["<C-d>"] = "preview-page-down",
      ["<C-u>"] = "preview-page-up",
    },
    fzf = {
      ["ctrl-q"] = "select-all+accept",
    },
  },
}

local function get_nopts()
  return vim.tbl_deep_extend("force", opts, {
    winopts = {
      height  = 0.6,
      width   = get_dynamic_width(),
      row     = 0.5,
      preview = { hidden = "hidden" }
    },
  })
end

vim.keymap.set("n", "<leader>sf", function() require("fzf-lua").files(get_nopts()) end)
vim.keymap.set("n", "<leader>s=", function() require("fzf-lua").spell_suggest() end)
vim.keymap.set("n", "<C-Space>", function() require("fzf-lua").builtin() end)

vim.keymap.set("n", "<leader>/", function() require("fzf-lua").blines(get_nopts()) end)

vim.keymap.set("n", "<leader>sr", function()
  require("fzf-lua").oldfiles(
    vim.tbl_extend("keep", get_nopts(), {
      include_current_session = true
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
    get_nopts(), { cwd = vim.fn.stdpath "config" }))
end)

vim.keymap.set("n", "<leader>sn", function()
  require("fzf-lua").files(vim.tbl_extend("keep",
    get_nopts(), { cwd = "~/Documents/DataSci/" }))
end)

vim.keymap.set("n", "<leader>sp", function()
  require("fzf-lua").files(vim.tbl_extend("keep",
    get_nopts(), { cwd = "~/projects" }))
end)

vim.keymap.set("n", "<leader>sl", function()
  require("fzf-lua").files(vim.tbl_extend("keep",
    get_nopts(), { cwd = vim.fs.joinpath(vim.fn.stdpath "data", "/site/pack") }))
end)

vim.keymap.set("n", "<leader>sg", function()
  require("fzf-lua").live_grep_native(opts)
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
