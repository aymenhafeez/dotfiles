vim.schedule(function()
  vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/neogitorg/neogit",
    "https://github.com/sindrets/diffview.nvim",
    "https://github.com/copilotlsp-nvim/copilot-lsp",
    "https://github.com/lewis6991/gitsigns.nvim"
  }, { load = true })

  require("gitsigns").setup {
    current_line_blame = true,
    current_line_blame_formatter = '     <author>, <author_time:%R> - <summary>',
  }

  vim.keymap.set("n", "gH", "<cmd>Gitsigns preview_hunk<CR>")
  vim.keymap.set("n", "gI", "<cmd>Gitsigns preview_hunk_inline<CR>")
  vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<CR>")
  vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<CR>")
  vim.keymap.set("n", "<leader>gd", "<cmd>Gitsigns diffthis<CR>")

  require("neogit").setup {
    graph_style = "unicode"
  }

  require("diffview").setup {
    use_icons = false
  }

  vim.g.copilot_nes_debounce = 250

  vim.keymap.set("n", "<Tab>", function()
    if not vim.b.nes_state then
      return "<C-i>"
    end

    local nes = require("copilot-lsp.nes")
    if not nes.walk_cursor_start_edit() and nes.apply_pending_nes() then
      nes.walk_cursor_end_edit()
    end
  end, { expr = true })

  vim.keymap.set("n", "<Esc>", function()
    if vim.b.nes_state then
      require("copilot-lsp.nes").clear()
    end
    return "<Esc>"
  end, { expr = true })
end)

local is_konsole = os.getenv("KONSOLE_VERSION") ~= nil
local original_background
local background_ready = not is_konsole

local function set_terminal_background(color)
  io.write("\027]11;" .. color .. "\027\\")
  io.flush()
end

local function match_editor_background()
  if not background_ready then return end
  local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
  if normal.bg then
    set_terminal_background(string.format("#%06x", normal.bg))
  end
end

vim.api.nvim_create_autocmd("UIEnter", {
  callback = function()
    if not is_konsole then
      match_editor_background()
      return
    end

    -- save Konsole's current background so it can be restored explicitly
    vim.tty.request("\027]11;?\027\\", {
      timeout = 500,
      on_timeout = function()
        background_ready = true
        match_editor_background()
      end,
    }, function(response)
      local r, g, b = response:match("^\027%]11;rgb:(%x+)/(%x+)/(%x+)")
      if not r then return end
      local function to_byte(component)
        return math.floor(tonumber(component, 16) * 255 / (16 ^ #component - 1) + 0.5)
      end
      original_background = string.format("#%02x%02x%02x", to_byte(r), to_byte(g), to_byte(b))
      background_ready = true
      match_editor_background()
      return true
    end)
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = match_editor_background,
})

vim.api.nvim_create_autocmd("UILeave", {
  callback = function()
    if original_background then
      set_terminal_background(original_background)
    else
      io.write("\027]111\027\\")
      io.flush()
    end
  end,
})
