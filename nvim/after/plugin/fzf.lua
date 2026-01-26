local ignore_patterns = {
  "*.ipynb",
  "*.pyx",
  "*.gif",
  "*.GIF",
  "*.log",
  "*.aux",
  "*.out",
  "*.png",
  "*.fdb_latexmk",
  "*.fls",
  "*.tex~",
  "*.texl1#",
  "*.dvi",
  "*.jpg",
  "*.jpeg",
  "*.json",
  "*_region_*",
  "*.mat",
  "*.listing",
  "lazy-lock.json",
  "*.git/",
}

local fd_excludes = {}
local rg_excludes = {}
for _, glob in ipairs(ignore_patterns) do
  table.insert(fd_excludes, "--exclude")
  table.insert(fd_excludes, glob)
  table.insert(rg_excludes, "--glob")
  table.insert(rg_excludes, "!" .. glob)
end

local fd_opts = "--color=never --type f --hidden --follow " .. table.concat(fd_excludes, " ")
local rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 "
    .. table.concat(rg_excludes, " ")

require("fzf-lua").setup {
  fd_opts = fd_opts,
  winopts = {
    backdrop = 100,
    preview = { hidden = "hidden" },
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
    -- fzf = {
    -- 	["ctrl-n"] = "up",
    -- 	["ctrl-p"] = "down",
    -- },
  },
  fzf = { cursorline = "CursorLine" },
  live_grep = {
    rg_opts = rg_opts,
  },
  grep_cword = {
    rg_opts = rg_opts,
  },
}

vim.keymap.set({ "t" }, "<C-n>", function()
  if vim.bo.filetype == "fzf" then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Up>", true, false, true), "t", false)
    return ""
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Down>", true, false, true), "t", false)
    return ""
  end
end)

vim.keymap.set({ "t" }, "<C-p>", function()
  if vim.bo.filetype == "fzf" then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Down>", true, false, true), "t", false)
    return ""
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Up>", true, false, true), "t", false)
    return ""
  end
end)

vim.keymap.set("n", "<leader>sf", function() require("fzf-lua").files() end)
vim.keymap.set("n", "<leader>sr", function() require("fzf-lua").oldfiles() end)
vim.keymap.set("n", "<leader>sD", function() require("fzf-lua").diagnostics_workspace() end)
vim.keymap.set("n", "<leader>ds", function() require("fzf-lua").lsp_document_symbols() end)
vim.keymap.set("n", "<leader>gf", function() require("fzf-lua").git_files() end)
vim.keymap.set("n", "<leader>s=", function() require("fzf-lua").spell_suggest() end)
vim.keymap.set("n", "<leader>sb", function() require("fzf-lua").buffers() end)
vim.keymap.set("n", "<leader>sd", function() require("fzf-lua").diagnostics_document() end)
vim.keymap.set("n", "<leader>sw", function() require("fzf-lua").grep_cword() end)
vim.keymap.set("n", "<leader>sg", function() require("fzf-lua").live_grep() end)
vim.keymap.set("n", "<leader>tq", function() require("fzf-lua").quickfix_stack() end)
vim.keymap.set("n", "<leader>:", function() require("fzf-lua").command_history() end)

vim.keymap.set("n", "<leader>/", function()
  require("fzf-lua").blines { winopts = { preview = { hidden = "hidden" } } }
end)

vim.keymap.set("n", "<leader>gs", function()
  require("fzf-lua").git_status { winopts = { preview = { hidden = false }, height = 0.8, width = 0.7 } }
end)

vim.keymap.set("n", "<leader>sh", function()
  require("fzf-lua").helptags { winopts = { preview = { hidden = false }, height = 0.8, width = 0.75 } }
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
      height = 0.85,
      width = 0.8,
    },
    cwd = "~/Documents/DataSci/",
  }
end)

vim.keymap.set("n", "<leader>gp", function()
  require("fzf-lua").live_grep {
    winopts = {
      preview = { hidden = false },
      height = 0.85,
      width = 0.8,
    },
    cwd = "~/projects/",
  }
end)

vim.keymap.set("n", "<leader>g.", function()
  require("fzf-lua").live_grep {
    winopts = {
      preview = { hidden = false },
      height = 0.85,
      width = 0.8,
    },
    cwd = vim.fn.stdpath "config",
  }
end)

vim.keymap.set("n", "<leader>gl", function()
  require("fzf-lua").live_grep {
    winopts = {
      preview = { hidden = false },
      height = 0.85,
      width = 0.8,
    },
    cwd = vim.fs.joinpath(vim.fn.stdpath "data", "lazy"),
  }
end)
