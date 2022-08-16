local status, bufferline = pcall(require, "bufferline")
if (not status) then return end

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
local colors = require("config.colors")

keymap("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>", opts)
keymap("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>", opts)
keymap("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>", opts)
keymap("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>", opts)
keymap("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>", opts)
keymap("n", "<leader>6", ":BufferLineGoToBuffer 6<CR>", opts)
keymap("n", "<leader>7", ":BufferLineGoToBuffer 7<CR>", opts)

bufferline.setup{
    options = {
        offsets = {{filetype = "NvimTree", text="", padding=1}},
        show_buffer_close_icons = false,
        show_tab_indicators = true,
        enforce_regular_tabs = true,
        max_name_length = 30,
        max_prefix_length = 30,
        tab_size = 21,
        separator_style = "thin",
        buffer_close_icon = "",
		modified_icon = "●",
		close_icon = "",
		show_close_icon = true,
		left_trunc_marker = "",
		right_trunc_marker = "",
		indicator_icon = "▎",
    },
    highlights = {
		background = {
			fg = colors.grey_fg,
			bg = colors.black4,
		},

		-- buffers
		buffer_selected = {
			fg = colors.white,
			bg = colors.black,
			bold = true
		},
		buffer_visible = {
			fg = colors.light_grey,
			bg = colors.black4,
		},

        -- diagnostics = "nvim_lsp",
		error = {
			fg = colors.light_grey,
			bg = colors.black4,
		},
		error_diagnostic = {
			fg = colors.light_grey,
			bg = colors.black4,
		},

		-- close buttons
		close_button = {
			fg = colors.light_grey,
			bg = colors.black4,
		},
		close_button_visible = {
			fg = colors.light_grey,
			bg = colors.black4,
		},
		close_button_selected = {
			fg = colors.red,
			bg = colors.black,
		},
		fill = {
			fg = colors.grey_fg,
			bg = colors.black4,
		},
		indicator_selected = {
			fg = colors.blue,
			bg = colors.black,
		},
		indicator_visible = {
			fg = colors.light_grey,
			bg = colors.black4,
		},

		-- modified
		modified = {
			fg = colors.nord_blue,
			bg = colors.black4,
		},
		modified_visible = {
			fg = colors.nord_blue,
			bg = colors.black4,
		},
		modified_selected = {
			fg = colors.blue,
			bg = colors.black,
		},

		-- separators
		separator = {
			fg = colors.black4,
			bg = colors.black4,
		},
		separator_visible = {
			fg = colors.black4,
			bg = colors.black4,
		},
		separator_selected = {
			fg = colors.black4,
			bg = colors.black4,
		},

		-- tabs
		tab = {
			fg = colors.light_grey,
			bg = colors.one_bg3,
		},
		tab_selected = {
			fg = colors.black4,
			bg = colors.nord_blue,
		},
		tab_close = {
			fg = colors.red,
			bg = colors.black,
		},
	},
}
