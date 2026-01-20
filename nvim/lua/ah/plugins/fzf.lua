---@diagnostic disable: missing-fields, assign-type-mismatch, undefined-global
return {
	{
		"ibhagwan/fzf-lua",
		enabled = false,
		config = function()
			-- Ignore patterns in glob format for fd and rg
			local ignore_globs = {
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
			for _, glob in ipairs(ignore_globs) do
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
					-- height = 0.65,
					-- width = 0.65,
					-- preview = { hidden = "hidden" },
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

			vim.keymap.set("n", "<leader>sf", "<cmd>FzfLua files<cr>")
			vim.keymap.set("n", "<leader>sr", "<cmd>FzfLua oldfiles<cr>")
			vim.keymap.set("n", "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>")
			vim.keymap.set("n", "<leader>ds", "<cmd>FzfLua lsp_document_symbols<cr>")
			vim.keymap.set("n", "<leader>gf", "<cmd>FzfLua git_files<cr>")
			vim.keymap.set("n", "<leader>s=", "<cmd>FzfLua spell_suggest<cr>")
			vim.keymap.set("n", "<leader>sb", "<cmd>FzfLua buffers<cr>")
			vim.keymap.set("n", "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>")
			vim.keymap.set("n", "<leader>sw", "<cmd>FzfLua grep_cword<cr>")
			vim.keymap.set("n", "<leader>sg", "<cmd>FzfLua live_grep<cr>")
			vim.keymap.set("n", "<leader>tq", "<cmd>FzfLua quickfix_stack<cr>")
			vim.keymap.set("n", "<leader>:", "<cmd>FzfLua command_history<cr>")

			vim.keymap.set("n", "<leader>/", function()
				FzfLua.blines { winopts = { preview = { hidden = "hidden" } } }
			end)

			vim.keymap.set("n", "<leader>gs", function()
				FzfLua.git_status { winopts = { preview = { hidden = false }, height = 0.8, width = 0.7 } }
			end)

			vim.keymap.set("n", "<leader>sh", function()
				FzfLua.helptags { winopts = { preview = { hidden = false }, height = 0.8, width = 0.75 } }
			end)

			vim.keymap.set("n", "<leader>s.", function()
				FzfLua.files { cwd = vim.fn.stdpath "config", fd_opts = fd_opts }
			end)

			vim.keymap.set("n", "<leader>sn", function()
				FzfLua.files { cwd = "~/Documents/DataSci/", fd_opts = fd_opts }
			end)

			vim.keymap.set("n", "<leader>sp", function()
				FzfLua.files { cwd = "~/projects", fd_opts = fd_opts }
			end)

			vim.keymap.set("n", "<leader>sl", function()
				FzfLua.files { cwd = vim.fs.joinpath(vim.fn.stdpath "data", "lazy") }
			end)

			vim.keymap.set("n", "<leader>gn", function()
				FzfLua.live_grep {
					winopts = {
						preview = { hidden = false },
						height = 0.85,
						width = 0.8,
					},
					cwd = "~/Documents/DataSci/",
					fd_opts = fd_opts,
					rg_opts = rg_opts,
				}
			end)

			vim.keymap.set("n", "<leader>gp", function()
				FzfLua.live_grep {
					winopts = {
						preview = { hidden = false },
						height = 0.85,
						width = 0.8,
					},
					cwd = "~/projects/",
					fd_opts = fd_opts,
					rg_opts = rg_opts,
				}
			end)

			vim.keymap.set("n", "<leader>g.", function()
				FzfLua.live_grep {
					winopts = {
						preview = { hidden = false },
						height = 0.85,
						width = 0.8,
					},
					cwd = vim.fn.stdpath "config",
					fd_opts = fd_opts,
					rg_opts = rg_opts,
				}
			end)

			vim.keymap.set("n", "<leader>gl", function()
				FzfLua.live_grep {
					winopts = {
						preview = { hidden = false },
						height = 0.85,
						width = 0.8,
					},
					cwd = vim.fs.joinpath(vim.fn.stdpath "data", "lazy"),
					fd_opts = fd_opts,
					rg_opts = rg_opts,
				}
			end)
		end,
	},
}
