local M = {}

function M.setup()
	require("mini.notify").setup {
		lsp_progress = { enable = true },
		window = {
			config = function()
				local has_statusline = vim.o.laststatus > 0
				local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
				return { anchor = "SE", col = vim.o.columns, row = vim.o.lines - pad }
			end,
		},
	}
	vim.keymap.set("n", "<leader>tn", function()
		require("mini.notify").show_history()
	end)

	require("mini.files").setup()
	vim.keymap.set("n", "<leader>-", "<cmd>lua MiniFiles.open()<CR>")

	local pick = require("mini.pick")
	pick.setup {
		mappings = {
			move_down = "<C-p>",
			move_up = "<C-n>",
		},
		options = {
			content_from_bottom = true,
		},
	}

	local function pick_files_in_cwd(cwd, prompt_title)
		return function()
			pick.builtin.files({
				tool = "rg",
			}, {
				source = {
					cwd = vim.fn.expand(cwd),
					name = prompt_title or cwd,
				},
			})
		end
	end

	local function pick_grep_in_cwd(cwd, prompt_title)
		return function()
			pick.builtin.grep_live({ tool = "rg" }, {
				source = {
					cwd = vim.fn.expand(cwd),
					name = prompt_title or cwd,
				},
			})
		end
	end

	vim.keymap.set("n", "<leader>sf", pick.builtin.files)
	vim.keymap.set("n", "<leader>sh", pick.builtin.help)
	vim.keymap.set("n", "<leader>sb", pick.builtin.buffers)
	vim.keymap.set("n", "<leader>:", "<cmd>Pick history<CR>")
	vim.keymap.set("n", "<leader>sD", "<cmd>Pick diagnostic<CR>")

	vim.keymap.set("n", "<leader>sd", function()
		require("mini.extra").pickers.diagnostic { scope = "current" }
	end)

	vim.keymap.set("n", "<leader>sr", function()
		require("mini.extra").pickers.oldfiles()
	end)

	vim.keymap.set("n", "<leader>/", function()
		require("mini.extra").pickers.buf_lines { scope = "current" }
	end)

	vim.keymap.set("n", "<leader>gs", function()
		pick.builtin.cli { command = { "git", "status", "--short" } }
	end)

	vim.keymap.set("n", "<leader>gf", function()
		pick.builtin.files { tool = "rg" }
	end)

	vim.keymap.set("n", "<leader>s=", function()
		require("mini.extra").pickers.spellsuggest({ n_suggestions = 25 },
			{
				mappings = {
					move_down = "<C-n>",
					move_up = "<C-p>",
				},
				options = {
					content_from_bottom = false,
				},
				window = {
					config = {
						relative = "cursor",
						anchor = "NW",
						row = 0,
						col = 0,
						width = 40,
						height = 10,
					}
				}
			}
		)
	end)

	vim.keymap.set("n", "<leader>sg", pick.builtin.grep_live)

	vim.keymap.set("n", "<leader>sw", function()
		local word = vim.fn.expand("<cword>")
		pick.builtin.grep { pattern = word }
	end)

	vim.keymap.set(
		"n",
		"<leader>s.",
		pick_files_in_cwd(vim.fn.stdpath("config"), "Config")
	)

	vim.keymap.set(
		"n",
		"<leader>sl",
		pick_files_in_cwd(vim.fn.stdpath("data") .. "/site/pack", "Plugins")
	)

	vim.keymap.set("n", "<leader>sn", pick_files_in_cwd("~/Documents/DataSci/", "Notes"))
	vim.keymap.set("n", "<leader>sp", pick_files_in_cwd("~/projects/", "Projects"))
	vim.keymap.set("n", "<leader>g.", pick_grep_in_cwd(vim.fn.stdpath("config"), "Config"))

	vim.keymap.set(
		"n",
		"<leader>gl",
		pick_grep_in_cwd(vim.fn.stdpath("data") .. "/site/pack", "Plugins")
	)

	vim.keymap.set("n", "<leader>gn", pick_grep_in_cwd("~/Documents/DataSci/", "Notes"))
	vim.keymap.set("n", "<leader>gp", pick_grep_in_cwd("~/projects/", "Projects"))
	vim.keymap.set("n", "<leader>ds", function()
		vim.lsp.buf.document_symbol()
	end)

	-- :h MiniSurround-vim-surround-config
	vim.api.nvim_create_autocmd("InsertEnter", {
		once = true,
		callback = function()
			require("mini.surround").setup {
				mappings = {
					add = "ys",
					delete = "ds",
					find = "",
					find_left = "",
					highlight = "",
					replace = "cs",

					suffix_last = "",
					suffix_next = "",
				},
				search_method = "cover_or_next",
			}
			require("mini.pairs").setup()
		end
	})

	require("mini.extra").setup()
	require("mini.icons").setup()
end

return M
