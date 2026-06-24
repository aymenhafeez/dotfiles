vim.schedule(function()
  vim.pack.add({
    "https://github.com/folke/snacks.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/neogitorg/neogit",
    "https://github.com/sindrets/diffview.nvim",
    -- "https://github.com/akinsho/bufferline.nvim",
    "https://github.com/mcauley-penney/visual-whitespace.nvim",
    { src = "https://github.com/aymenhafeez/doric-themes.nvim", version = "add-extras" },
  }, { load = true })

  require("neogit").setup {
    -- graph_style = "kitty",
  }

  -- require("bufferline").setup {
  --   options = {
  --     indicator = {
  --       -- icon = "▎",
  --       style = "none"
  --     },
  --     offsets = {
  --       {
  --         filetype = "snacks_layout_box",
  --         text = "󰙅  Explorer",
  --         separator = true,
  --         padding = 0,
  --         highlight = "BufferLineOffsetExplorer",
  --       },
  --       {
  --         filetype = "DiffviewFiles",
  --         text = "  Diffview",
  --         separator = true,
  --         padding = 0,
  --         highlight = "BufferLineOffsetExplorer",
  --       },
  --       {
  --         filetype = "DiffviewFileHistory",
  --         text = "  Diffview",
  --         separator = true,
  --         padding = 0,
  --         highlight = "BufferLineOffsetExplorer",
  --       },
  --       {
  --         filetype = "dbui",
  --         text = "󰆼  DBUI",
  --         separator = true,
  --         padding = 0,
  --         highlight = "BufferLineOffset",
  --       },
  --       {
  --         filetype = "terminal",
  --         separator = true,
  --         highlight = "BufferLineOffset"
  --       },
  --       -- {
  --       --   filetype = "help",
  --       --   separator = true,
  --       --   highlight = "BufferLineOffsetHelp"
  --       -- },
  --       -- {
  --       --   filetype = "man",
  --       --   separator = true,
  --       --   highlight = "BufferLineOffsetHelp"
  --       -- }
  --     },
  --     custom_filter = function(bufnr)
  --       local ignore_ft = { terminal = true, man = true }
  --       if ignore_ft[vim.bo[bufnr].filetype] then
  --         return false
  --       else
  --         return true
  --       end
  --     end
  --   }
  -- }

  -- vim.keymap.set("n", "<M-C-l>", "<cmd>BufferLineMoveNext<CR>", { desc = "Move buffer next" })
  -- vim.keymap.set("n", "<M-C-h>", "<cmd>BufferLineMovePrev<CR>", { desc = "Move buffer previous" })
  -- vim.keymap.set("n", "L", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
  -- vim.keymap.set("n", "H", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
  -- vim.keymap.set("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<CR>", { desc = "Go to buffer 1" })
  -- vim.keymap.set("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<CR>", { desc = "Go to buffer 2" })
  -- vim.keymap.set("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<CR>", { desc = "Go to buffer 3" })
  -- vim.keymap.set("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<CR>", { desc = "Go to buffer 4" })
  -- vim.keymap.set("n", "<leader>5", "<cmd>BufferLineGoToBuffer 5<CR>", { desc = "Go to buffer 5" })
  -- vim.keymap.set("n", "<leader>6", "<cmd>BufferLineGoToBuffer 6<CR>", { desc = "Go to buffer 6" })
  -- vim.keymap.set("n", "<leader>7", "<cmd>BufferLineGoToBuffer 7<CR>", { desc = "Go to buffer 7" })

  require("snacks").setup({
    -- statuscolumn = {
    --   enabled = true
    -- },
    -- scroll = {
    --   enabled = true,
    --   animate = {
    --     duration = { step = 10, total = 150 },
    --     easing = "outQuad",
    --   },
    -- },
    -- indent = {
    --   enabled = true,
    --   char = "▏",
    -- },
    dim = { enabled = true, animate = { enabled = true } }, -- Focus dimming animations
    -- image = {
    --   enabled = true,
    --   math = {
    --     latex = {
    --       font_size = "normalsize"
    --     }
    --   }
    -- },
    explorer = {
      replace_netrw = false,
      trash = true,
    },
    picker = {
      icons = {
        files = {
          dir = " ",
          dir_open = " ",
        },
        tree = {
          vertical = "│ ",
          middle   = "│ ",
          last     = "│ ",
        },
        diagnostics = {
          Error = " ",
          Warn  = " ",
          Hint  = " ",
          Info  = " ",
        },
      },
      sources = {
        explorer = {
          layout = {
            preset = "sidebar",
            preview = false,
            layout = {
              width = 35,
              min_width = 35,
              height = 0,
              position = "left",
              border = "none",
              box = "vertical",
              { win = "list", border = "none" },
              {
                win = "input",
                height = 1,
                border = "rounded",
              },
            },
          },
          win = {
            input = {
              title = "",
            },
          },
        },
      },
    },
    zen = {
      enabled = true,
      toggles = {
        dim = false,
        show = { signcolumn = false }
      },
      on_open = function(win)
        vim.cmd("hi clear SnacksBackdrop_0a0b0c")
        vim.cmd("hi clear SnacksBackdrop_1a1c1f")
        vim.cmd("hi clear SnacksBackdrop_12151a")
        vim.cmd("hi clear SnacksBackdrop_222838")
        vim.cmd("hi clear SnacksBackdrop_06060A")
        vim.cmd("hi clear SnacksBackdrop_12161b")
        vim.cmd("hi clear SnacksBackdrop_08090b")
      end,
    },
    styles = {
      -- snacks_image = { focusable = true },
      zen = {
        enter = true,
        fixbuf = false,
        minimal = false,
        width = 88,
        -- height = 0,
        backdrop = { transparent = false },
        keys = { q = false },
        zindex = 40,
        wo = {
          winhighlight = "NormalFloat:Normal",
        },
        w = {
          snacks_main = true,
        },
      }
    },
  })

  do
    local fmt = require("snacks.picker.format")
    local orig_filename = fmt.filename

    fmt.filename = function(item, picker)
      local ret = orig_filename(item, picker)
      if item and item.dir and not item.open and ret and ret[1] and type(ret[1][1]) == "string" then
        ret[1][1] = picker.opts.icons.files.dir
      end
      return ret
    end
  end

  vim.keymap.set("n", ";-", function()
    require("snacks").explorer.open()
  end, { desc = "Explorer" })

  vim.keymap.set("n", "<leader>zz", function() require("snacks").zen() end)

  -- vim.keymap.set("n", "<leader>im", function() require("snacks").image.hover() end)
end)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "snacks_picker_input",
  callback = function()
    vim.b.minicompletion_disable = true
  end,
})
