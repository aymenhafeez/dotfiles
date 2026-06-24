vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python", "lua", "rust", "c", "vim", "markdown", "tex", "diff", "cpp", "css" },
  callback = function(args)
    vim.treesitter.language.register("latex", "tex")
    vim.treesitter.start(args.buf)

    -- re-enable syntax for tex files to keep native conceals
    if vim.bo[args.buf].filetype == 'tex' then
      vim.bo[args.buf].syntax = 'ON'
    end
  end,
})

require("utils").lazy_load("BufReadPre",
  function()
    vim.pack.add({
      { src = "https://github.com/nvim-treesitter/nvim-treesitter",             version = "main" },
      { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
      "https://github.com/nvim-treesitter/nvim-treesitter-context",
    }, { load = true })

    local writing_ft = { tex = true, markdown = true, text = true }
    local is_writing = writing_ft[vim.bo.filetype]
    require("treesitter-context").setup {
      enable = true,
      separator = "─",
      multiwindow = true,
      max_lines = is_writing and 0 or 0,
      trim_scope = is_writing and "outer" or "outer",
      disable_all_ft = { "help", "lua" },
      on_attach = function(bufnr)
        local ft = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
        return ft ~= 'help'
      end,
    }

    require("nvim-treesitter-textobjects").setup {
      select = {
        lookahead = true,
        selection_modes = {
          ["@parameter.outer"] = "v",
          ["@function.outer"] = "V",
          ["@class.outer"] = "<c-v>",
        },
        include_surrounding_whitespace = false,
      },
      move = {
        set_jumps = true,
      },
    }
  end)

vim.keymap.set({ "x", "o" }, "af", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
end, { desc = "Select outer function" })

vim.keymap.set({ "x", "o" }, "if", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
end, { desc = "Select inner function" })

vim.keymap.set({ "x", "o" }, "ac", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
end, { desc = "Select outer class" })

vim.keymap.set({ "x", "o" }, "ic", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
end, { desc = "Select inner class" })

-- You can also use captures from other query groups like `locals.scm`
vim.keymap.set({ "x", "o" }, "as", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@local.scope", "locals")
end, { desc = "Select scope" })

vim.keymap.set({ "n", "x", "o" }, "]f", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
end, { desc = "Next function start" })

vim.keymap.set({ "n", "x", "o" }, "[f", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
end, { desc = "Previous function start" })

vim.keymap.set({ "n", "x", "o" }, "]F", function()
  require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
end, { desc = "Next function end" })

vim.keymap.set({ "n", "x", "o" }, "[F", function()
  require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
end, { desc = "Previous function end" })
