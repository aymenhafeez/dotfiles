return {
	{
		"nvim-mini/mini.nvim",
		enabled = true,
		version = "*",
		config = function()
			require("mini.notify").setup {
				lsp_progress = { enable = false },
				window = {
					config = function()
						local has_statusline = vim.o.laststatus > 0
						local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
						return { anchor = "SE", col = vim.o.columns, row = vim.o.lines - pad }
					end,
				},
			}

			local pick = require "mini.pick"
			pick.setup {
				mappings = {
					move_down = "<C-p>",
					move_up = "<C-n>",
				},
				options = {
					content_from_bottom = true,
				},
			}

			-- Helper functions for custom pickers
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

			-- File search keymaps
			vim.keymap.set("n", "<leader>sf", pick.builtin.files)
			vim.keymap.set("n", "<leader>sh", pick.builtin.help)
			vim.keymap.set("n", "<leader>sb", pick.builtin.buffers)
			vim.keymap.set("n", "<leader>s:", "<cmd>Pick history<CR>")
			vim.keymap.set("n", "<leader>sd", function()
				require("mini.extra").pickers.diagnostic { scope = "current" }
			end)
			vim.keymap.set("n", "<leader>sD", "<cmd>Pick diagnostic<CR>")

			vim.keymap.set("n", "<leader>sr", function()
				require("mini.extra").pickers.oldfiles()
			end)

			vim.keymap.set("n", "<leader>/", function()
				require("mini.extra").pickers.buf_lines { scope = "current" }
			end)

			vim.keymap.set("n", "<leader>gs", function()
				pick.builtin.cli { command = { "git", "status", "--short" } }
			end, { desc = "Git status" })

			vim.keymap.set("n", "<leader>gf", function()
				pick.builtin.files { tool = "rg" }
			end, { desc = "Git files" })

			vim.keymap.set("n", "<leader>s=", function()
				require("mini.extra").pickers.spellsuggest { n_suggestions = 25 }
			end)

			-- Grep keymaps

			vim.keymap.set("n", "<leader>sg", pick.builtin.grep_live, { desc = "Live grep" })
			vim.keymap.set("n", "<leader>sw", function()
				local word = vim.fn.expand "<cword>"
				pick.builtin.grep { pattern = word }
			end, { desc = "Grep word under cursor" })
			vim.keymap.set("n", "<leader>g/", function()
				-- Get open buffers' paths
				local buffers = vim.tbl_filter(function(buf)
					return vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted
				end, vim.api.nvim_list_bufs())

				local files = {}
				for _, buf in ipairs(buffers) do
					local name = vim.api.nvim_buf_get_name(buf)
					if name ~= "" then
						table.insert(files, name)
					end
				end

				pick.builtin.grep_live({}, {
					source = {
						name = "Grep Open Files",
						items = files,
					},
				})
			end, { desc = "Grep open files" })

			-- Search in specific directories
			vim.keymap.set(
				"n",
				"<leader>s.",
				pick_files_in_cwd(vim.fn.stdpath "config", "Config"),
				{ desc = "Search config" }
			)
			vim.keymap.set(
				"n",
				"<leader>sl",
				pick_files_in_cwd(vim.fn.stdpath "data" .. "/lazy", "Plugins"),
				{ desc = "Search plugins" }
			)
			vim.keymap.set("n", "<leader>sn", pick_files_in_cwd("~/Documents/DataSci/", "Notes"), { desc = "Search notes" })
			vim.keymap.set("n", "<leader>sp", pick_files_in_cwd("~/projects/", "Projects"), { desc = "Search projects" })

			-- Grep in specific directories
			vim.keymap.set("n", "<leader>g.", pick_grep_in_cwd(vim.fn.stdpath "config", "Config"), { desc = "Grep config" })
			vim.keymap.set(
				"n",
				"<leader>gl",
				pick_grep_in_cwd(vim.fn.stdpath "data" .. "/lazy", "Plugins"),
				{ desc = "Grep plugins" }
			)
			vim.keymap.set("n", "<leader>gn", pick_grep_in_cwd("~/Documents/DataSci/", "Notes"), { desc = "Grep notes" })
			vim.keymap.set("n", "<leader>gp", pick_grep_in_cwd("~/projects/", "Projects"), { desc = "Grep projects" })

			vim.keymap.set("n", "<leader>ds", function()
				vim.lsp.buf.document_symbol()
			end, { desc = "Document symbols" })

			-- -- Spell suggest
			-- vim.keymap.set("n", "<leader>s=", function()
			-- 	local word = vim.fn.expand "<cword>"
			-- 	local suggestions = vim.fn.spellsuggest(word)
			-- 	pick.start {
			-- 		source = {
			-- 			items = suggestions,
			-- 			name = "Spell Suggestions",
			-- 			choose = function(item)
			-- 				local pos = vim.fn.getpos "."
			-- 				vim.cmd("normal! ciw" .. item)
			-- 				vim.fn.setpos(".", pos)
			-- 			end,
			-- 		},
			-- 	}
			-- end, { desc = "Spell suggest" })

			-- Quickfix
			vim.keymap.set("n", "<leader>tq", function()
				local qf_lists = {}
				local qf_nr = vim.fn.getqflist({ nr = "$" }).nr
				for i = 1, qf_nr do
					local qf = vim.fn.getqflist { nr = i, title = 1 }
					table.insert(qf_lists, {
						text = string.format("[%d] %s", i, qf.title or ""),
						nr = i,
					})
				end

				pick.start {
					source = {
						items = qf_lists,
						name = "Quickfix History",
						choose = function(item)
							vim.cmd(item.nr .. "chistory")
							vim.cmd "copen"
						end,
					},
				}
			end, { desc = "Quickfix history" })

			-- Custom pickers for TODO and LaTeX headings
			vim.keymap.set("n", "<leader>st", function()
				local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
				local todo_items = {}
				for lnum, line in ipairs(lines) do
					if line:find "TODO" then
						table.insert(todo_items, {
							text = string.format("%d: %s", lnum, line),
							lnum = lnum,
						})
					end
				end

				pick.start {
					source = {
						items = todo_items,
						name = "TODO Comments",
						choose = function(item)
							vim.api.nvim_win_set_cursor(0, { item.lnum, 0 })
						end,
					},
				}
			end, { desc = "TODO comments" })

			vim.keymap.set("n", "<leader>lh", function()
				local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
				local headings = {}
				for lnum, line in ipairs(lines) do
					if line:find "section" then
						table.insert(headings, {
							text = string.format("%d: %s", lnum, line),
							lnum = lnum,
						})
					end
				end

				pick.start {
					source = {
						items = headings,
						name = "LaTeX Headings",
						choose = function(item)
							vim.api.nvim_win_set_cursor(0, { item.lnum, 0 })
						end,
					},
				}
			end, { desc = "LaTeX headings" })

			require("mini.extra").setup()

			require("mini.files").setup()
			vim.keymap.set("n", "<leader>-", "<cmd>lua MiniFiles.open()<CR>")
		end,
	},
}
