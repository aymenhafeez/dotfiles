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

require("bufferline").setup{
    options = {
        offsets = {{filetype = "NvimTree", text="", padding=1}},
        show_buffer_close_icons = true,
        show_tab_indicators = true,
        enforce_regular_tabs = true,
        max_name_length = 30,
        max_prefix_length = 30,
        tab_size = 21,
        -- diagnostics = "nvim_lsp",
        separator_style = "thin",
        buffer_close_icon = "",
		modified_icon = "",
		close_icon = "",
		show_close_icon = true,
		left_trunc_marker = "",
		right_trunc_marker = "",
		indicator_icon = "▎",
    },
    highlights = {
		background = {
			guifg = colors.grey_fg,
			guibg = colors.black2,
		},

		-- buffers
		buffer_selected = {
			guifg = colors.white,
			guibg = colors.black,
			gui = "bold",
		},
		buffer_visible = {
			guifg = colors.light_grey,
			guibg = colors.black2,
		},

		-- for diagnostics = "nvim_lsp"
		error = {
			guifg = colors.light_grey,
			guibg = colors.black2,
		},
		error_diagnostic = {
			guifg = colors.light_grey,
			guibg = colors.black2,
		},

		-- close buttons
		close_button = {
			guifg = colors.light_grey,
			guibg = colors.black2,
		},
		close_button_visible = {
			guifg = colors.light_grey,
			guibg = colors.black2,
		},
		close_button_selected = {
			guifg = colors.red,
			guibg = colors.black,
		},
		fill = {
			guifg = colors.grey_fg,
			guibg = colors.black2,
		},
		indicator_selected = {
			guifg = colors.blue,
			guibg = colors.black,
		},

		-- modified
		modified = {
			guifg = colors.red,
			guibg = colors.black2,
		},
		modified_visible = {
			guifg = colors.red,
			guibg = colors.black2,
		},
		modified_selected = {
			guifg = colors.green,
			guibg = colors.black,
		},

		-- separators
		separator = {
			guifg = colors.black2,
			guibg = colors.black2,
		},
		separator_visible = {
			guifg = colors.black2,
			guibg = colors.black2,
		},
		separator_selected = {
			guifg = colors.black2,
			guibg = colors.black2,
		},

		-- tabs
		tab = {
			guifg = colors.light_grey,
			guibg = colors.one_bg3,
		},
		tab_selected = {
			guifg = colors.black2,
			guibg = colors.nord_blue,
		},
		tab_close = {
			guifg = colors.red,
			guibg = colors.black,
		},
	},
}
-- 21252b
