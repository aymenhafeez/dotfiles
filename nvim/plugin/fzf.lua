vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" }, { load = true })

require("fzf-lua").setup {
  winopts = {
    backdrop = 100,
    preview  = { hidden = "hidden" },
  },
  fzf_opts = {
    ["--layout"] = "default",
    ["--cycle"] = true,
    ["--highlight-line"] = true,
  },
  keymap = {
    builtin = {
      ["<M-p>"] = "toggle-preview",
    },
    fzf = {
      ["ctrl-n"] = "up",
      ["ctrl-p"] = "down",
    }
  },
  fzf = { cursorline = "CursorLine" },
}

vim.keymap.set("n", "<leader>sf", function() require("fzf-lua").files() end)
vim.keymap.set("n", "<leader>sr", function() require("fzf-lua").oldfiles() end)
vim.keymap.set("n", "<leader>sD", function() require("fzf-lua").diagnostics_workspace() end)
vim.keymap.set("n", "<leader>ds", function() require("fzf-lua").lsp_document_symbols() end)
vim.keymap.set("n", "<leader>gf", function() require("fzf-lua").git_files() end)
vim.keymap.set("n", "<leader>s=", function() require("fzf-lua").spell_suggest() end)
vim.keymap.set("n", "<leader>sd", function() require("fzf-lua").diagnostics_document() end)
vim.keymap.set("n", "<leader>sw", function() require("fzf-lua").grep_cword() end)
vim.keymap.set("n", "<leader>sg", function() require("fzf-lua").live_grep() end)
vim.keymap.set("n", "<leader>tq", function() require("fzf-lua").quickfix_stack() end)
vim.keymap.set("n", "<leader>:", function() require("fzf-lua").command_history() end)

vim.keymap.set("n", "<leader>sb", function()
  require("fzf-lua").buffers {
    winopts = {
      height = 0.4,
      width = 0.5
    }
  }
end)

vim.keymap.set("n", "<leader>/", function()
  require("fzf-lua").blines { winopts = { preview = { hidden = "hidden" } } }
end)

vim.keymap.set("n", "<leader>gs", function()
  require("fzf-lua").git_status { winopts = { preview = { hidden = false } } }
end)

vim.keymap.set("n", "<leader>sh", function()
  require("fzf-lua").helptags { winopts = { preview = { hidden = false } } }
end)

vim.keymap.set("n", "<leader>s.", function()
  require("fzf-lua").files { cwd = vim.fn.stdpath "config" }
end)

vim.keymap.set("n", "<leader>sn", function()
  require("fzf-lua").files { cwd = "~/Documents/DataSci/" }
end)

vim.keymap.set("n", "<leader>sp", function()
  require("fzf-lua").files { cwd = "~/projects" }
end)

vim.keymap.set("n", "<leader>sl", function()
  require("fzf-lua").files { cwd = vim.fs.joinpath(vim.fn.stdpath "data", "/site/pack") }
end)

vim.keymap.set("n", "<leader>gn", function()
  require("fzf-lua").live_grep {
    winopts = {
      preview = { hidden = false },
    },
    cwd = "~/Documents/DataSci/",
  }
end)

vim.keymap.set("n", "<leader>gp", function()
  require("fzf-lua").live_grep {
    winopts = {
      preview = { hidden = false },
    },
    cwd = "~/projects/",
  }
end)

vim.keymap.set("n", "<leader>g.", function()
  require("fzf-lua").live_grep {
    winopts = {
      preview = { hidden = false },
    },
    cwd = vim.fn.stdpath "config",
  }
end)

vim.keymap.set("n", "<leader>gl", function()
  require("fzf-lua").live_grep {
    winopts = {
      preview = { hidden = false },
    },
    cwd = vim.fs.joinpath(vim.fn.stdpath "data", "lazy"),
  }
end)
