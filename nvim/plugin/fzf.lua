local opts = {
  git_icons   = false,
  file_icons  = false,
  color_icons = false,
  hidden      = false,
  winopts     = {
    backdrop    = 100,
    title       = false,
    title_flags = false,
    number      = false,
    split       = "botright 12new",
    preview     = {
      hidden = "hidden",
      border = "rounded",
      title = false,
      winopts = { number = vim.o.number },
    },
    on_create   = function()
      vim.opt.cmdheight = 0
      vim.opt_local.laststatus = 0
    end,
    on_close    = function()
      vim.opt_local.cmdheight = 1
      vim.opt.laststatus = 2
    end
  },
  fzf_opts    = {
    ["--cycle"] = true,
  },
  keymap      = {
    builtin = {
      ["<M-p>"]      = "toggle-preview",
      ["<S-down>"]   = "preview-page-down",
      ["<S-up>"]     = "preview-page-up",
      ["<M-S-down>"] = "preview-down",
      ["<M-S-up>"]   = "preview-up",
    },
    fzf = {
      ["ctrl-q"] = "select-all+accept",
    },
  },
  fzf_colors  = {
    true,
    ["bg"] = { "bg", "FzfLuaNormal" }
  }
}

vim.schedule(function()
  vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" }, { load = false })
  require("fzf-lua").setup(opts)
end)

vim.keymap.set("n", "<leader>f", function() require("fzf-lua").files(opts) end, { desc = "Files" })
vim.keymap.set("n", "<C-Space>", function() require("fzf-lua").builtin(opts) end, { desc = "FzfLua builtins" })
vim.keymap.set("n", "<leader>b", function() require("fzf-lua").buffers(opts) end, { desc = "Buffers" })

vim.keymap.set("n", "<leader>/",
  function() require("fzf-lua").blines({ "ivy", winopts = { split = "botright 12new" } }) end,
  { desc = "Search buffer" })

vim.keymap.set("n", "<leader>sr", function()
  require("fzf-lua").oldfiles(
    vim.tbl_extend("keep", opts, {
      include_current_session = true
    })
  )
end, { desc = "Recent" })

vim.keymap.set("n", "gS", function()
  require("fzf-lua").git_status()
end, { desc = "Git status" })

vim.keymap.set("n", "<leader>sh", function()
  require("fzf-lua").helptags()
end, { desc = "Help" })

vim.keymap.set("n", "<leader>s.", function()
  require("fzf-lua").files(vim.tbl_extend("keep",
    opts, { cwd = vim.fn.stdpath "config" }))
end, { desc = "Config" })

vim.keymap.set("n", "<leader>sn", function()
  require("fzf-lua").files(vim.tbl_extend("keep",
    opts, { cwd = "~/Documents/DataSci/" }))
end, { desc = "Notes" })

vim.keymap.set("n", "<leader>sp", function()
  require("fzf-lua").files(vim.tbl_extend("keep",
    opts, { cwd = "~/projects" }))
end, { desc = "Projects" })

vim.keymap.set("n", "<leader>sl", function()
  require("fzf-lua").files(vim.tbl_extend("keep",
    opts, { cwd = vim.fs.joinpath(vim.fn.stdpath "data", "/site/pack") }))
end, { desc = "Plugins" })

vim.keymap.set("n", "<leader>sg", function()
  require("fzf-lua").live_grep_native()
end, { desc = "Live grep" })

vim.keymap.set("n", "<leader>gn", function()
  require("fzf-lua").live_grep_native(vim.tbl_extend("keep",
    opts, { cwd = "~/Documents/DataSci/" }))
end, { desc = "Grep notes" })

vim.keymap.set("n", "<leader>gp", function()
  require("fzf-lua").live_grep_native(vim.tbl_extend("keep",
    opts, { cwd = "~/projects/" }))
end, { desc = "Grep projects" })

vim.keymap.set("n", "<leader>g.", function()
  require("fzf-lua").live_grep_native(vim.tbl_extend("keep",
    opts, { cwd = vim.fn.stdpath("config") }))
end, { desc = "Grep config" })

vim.keymap.set("n", "<leader>gl", function()
  require("fzf-lua").live_grep_native(vim.tbl_extend("keep",
    opts, { cwd = vim.fs.joinpath(vim.fn.stdpath "data", "/site/pack") }))
end, { desc = "Grep plugins" })
