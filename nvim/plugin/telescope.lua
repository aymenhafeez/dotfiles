vim.schedule(function()
  vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
    "https://github.com/nvim-telescope/telescope-ui-select.nvim"
  })

  local telescope = require("telescope.builtin")
  local action = require("telescope.actions")
  local action_layout = require("telescope.actions.layout")
  local theme = require("telescope.themes")
  local action_state = require("telescope.actions.state")

  local ignore_patterns = {
    "%.ipynb",
    "%.pyx",
    "%.gif",
    "%.GIF",
    "%.log",
    "%.aux",
    "%.out",
    "%.png",
    "%.fdb_latexmk",
    "%.fls",
    "%.tex~",
    "%.texl1#",
    "%.dvi",
    "%.jpg",
    "%.jpeg",
    "%.json",
    "%_region_",
    "%.mat",
    "%.listing",
    "%lazy-lock.json",
  }

  local options = {
    defaults = {
      multi_icon = "<>",

      path_display = {
        truncate = 3,
      },

      layout_strategy = "flex",
      -- layout_strategy = "bottom_pane",
      results_title = "",
      prompt_title = "",
      layout_config = {
        -- width = 0.9,
        -- height = 0.9,
        -- prompt_position = "bottom",

        horizontal = {
          preview_width = 0.45,
          preview_cutoff = 150,
        },

        vertical = {
          width = 0.9,
          height = 0.85,
          preview_height = 0.6,
        },

        -- flex = {
        --   horizontal = {
        --     preview_width = 0.9,
        --   },
        -- },
      },

      sorting_strategy = "descending",

      dynamic_preview_title = true,
      mappings = {
        i = {
          ["<C-e>"] = action.results_scrolling_down,
          ["<C-y>"] = action.results_scrolling_up,
          ["<C-s>"] = action.select_horizontal,
          ["<M-p>"] = action_layout.toggle_preview,
          ["<M-t>"] = action_layout.toggle_prompt_position,
          ["<C-o>"] = function()
            local entry = action_state.get_selected_entry()
            local path = vim.fs.joinpath(entry.cwd, entry.value)
            vim.ui.open(path)
          end,
          ["<C-BS>"] = function()
            -- re-send as <C-w> (the insert-mode delete-word-prev), non-remappable so it can't loop
            vim.api.nvim_feedkeys(
              vim.api.nvim_replace_termcodes("<C-w>", true, false, true),
              "in", true
            )
          end,
        },
      },
    },
    pickers = {
      diagnostics = {
        theme = "ivy",
        layout_config = {
          prompt_position = "top",
          height = 0.4
        }
      },
      find_files = {
        layout_config = {
          flip_columns = 180,
          flip_lines = 30,
        },
        --   theme = "dropdown",
        --   sorting_strategy = "descending",
        --   previewer = false,
        --   layout_config = {
        --     prompt_position = "bottom",
        --     height = 0.75,
        --     width = width(),
        --   },
        --   -- attach_mappings = function(_, map)
        --   -- 	map("i", "<C-n>", action.move_selection_next)
        --   -- 	map("i", "<C-p>", action.move_selection_previous)
        --   -- 	return true
        --   -- end,
      },
    },
    extensions = {
      file_browser = {
        layout_strategy = "bottom_pane",
        hijack_netrw = true,
        sorting_strategy = "descending",
        mappings = {
          i = {
            ["<C-n>"] = action.move_selection_previous,
            ["<C-p>"] = action.move_selection_next,
          },
        },
        layout_config = {
          prompt_position = "bottom",
          height = 0.65,
          preview_width = 0.6,
        },
      },
      ["ui-select"] = {
        theme.get_dropdown({
          layout_config = {
            prompt_position = "top",
          }
        }),
      },
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  }

  local live_grep_opts = {
    path_display = { "shorten" },
    sorting_strategy = "ascending",
    layout_strategy = "flex",
    layout_config = {
      prompt_position = "top",
      width = 0.9,
      height = 0.8,
    },
  }

  require("telescope").setup(options)
  pcall(require("telescope").load_extension, "fzf")
  pcall(require("telescope").load_extension, "ui-select")

  vim.keymap.set("n", "<leader>gs", function() telescope.git_status() end)
  vim.keymap.set("n", "<leader>f", function() telescope.find_files() end)
  vim.keymap.set("n", "<leader>sr", function() telescope.oldfiles() end)
  vim.keymap.set("n", "<leader>h", function() telescope.help_tags() end)
  vim.keymap.set("n", "<leader>sD", function() telescope.diagnostics() end)
  vim.keymap.set("n", "<leader>sd", function() telescope.diagnostics({ bufnr = 0 }) end)
  vim.keymap.set("n", "<leader>gw", function() telescope.lsp_document_symbols() end)
  vim.keymap.set("n", "<leader>gW", function() telescope.lsp_workspace_symbols() end)
  vim.keymap.set("n", "gd", function() telescope.lsp_definitions() end)
  vim.keymap.set("n", "grr", function() telescope.lsp_references() end)

  vim.keymap.set("n", "<leader>gf", function() telescope.git_files() end)
  vim.keymap.set("n", "<leader>s=", function()
    telescope.spell_suggest(
      theme.get_cursor {
        layout_config = {
          height = 0.25,
          width = 0.25,
        },
      }
    )
  end)
  vim.keymap.set("n", "<leader>/", function()
    telescope.current_buffer_fuzzy_find(theme.get_dropdown({
      sorting_strategy = "descending",
      previewer = false,
      layout_config = {
        prompt_position = "bottom",
        height = 0.75,
        width = 0.75,
      },
    }))
  end)
  vim.keymap.set("n", "<leader>b", function()
    telescope.buffers({
      -- layout_strategy = "bottom_pane",
      sorting_strategy = "ascending",
      previewer = false,
      layout_config = {
        prompt_position = "top",
        height = 0.35,
        width = 0.5
        -- preview_width = 0.6,
      },
    })
  end)

  vim.keymap.set("n", "<leader>sp", function()
    telescope.find_files({
      cwd = "~/projects/"
    })
  end)

  vim.keymap.set("n", "<leader>g/", function()
    telescope.live_grep({
      grep_open_files = true,
      path_display = { "shorten" }
    })
  end)

  vim.keymap.set("n", "<leader>sw", function() telescope.grep_string() end)
  vim.keymap.set("n", "<leader>sg", function() telescope.live_grep() end)
  vim.keymap.set("n", "<leader>gn", function()
    telescope.live_grep(vim.tbl_extend("keep", live_grep_opts, {
      cwd = "~/Downloads/Backup/home/aymen/Documents/DataSci/",
      prompt_title = "Notes",
      file_ignore_patterns = ignore_patterns
    }))
  end)

  vim.keymap.set("n", "<leader>gp", function()
    telescope.live_grep(vim.tbl_extend("keep", live_grep_opts, {
      cwd = "~/projects/",
      prompt_title = "Projects",
      file_ignore_patterns = ignore_patterns
    }))
  end)

  vim.keymap.set("n", "<leader>s.", function()
    telescope.find_files({
      cwd = vim.fn.stdpath "config",
      file_ignore_patterns = ignore_patterns,
      prompt_title = "Config",
    })
  end)

  vim.keymap.set("n", "<leader>sn", function()
    telescope.find_files({
      cwd = "~/Downloads/Backup/home/aymen/Documents/DataSci/",
      file_ignore_patterns = ignore_patterns,
      path_display = { "shorten" },
      prompt_title = "Notes",
    })
  end)

  vim.keymap.set("n", "<leader>tq", function()
    telescope.quickfixhistory(theme.get_dropdown({
      sorting_strategy = "ascending",
      previewer = false,
      layout_config = {
        prompt_position = "top",
      },
    }))
  end)

  vim.keymap.set("n", "<C-Space>", function() telescope.builtin(theme.get_ivy()) end)
  vim.keymap.set("n", "<leader>vo", function() telescope.vim_options(theme.get_ivy()) end)

  vim.keymap.set("n", "<leader>:", function() telescope.command_history() end)
  vim.keymap.set(
    "c",
    "<C-r><C-r>",
    "<C-\\>e \"lua require('telescope.builtin').command_history "
    .. '{ default_text = [=[" . escape(getcmdline(), \'"\') . "]=] }"<CR><CR>'
  )
end)
