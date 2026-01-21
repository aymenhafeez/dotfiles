local M = {}
function M.setup()
	-- ========================================================================
	-- Core Treesitter Configuration (NEW MAIN BRANCH API)
	-- ========================================================================

	-- -- Enable treesitter highlighting for supported filetypes
	-- -- This is the new API - no more require('nvim-treesitter.configs').setup()
	-- vim.api.nvim_create_autocmd("FileType", {
	-- 	pattern = "*",
	-- 	callback = function(args)
	-- 		local buf = args.buf
	-- 		-- Start treesitter for this buffer if parser is available
	-- 		pcall(vim.treesitter.start, buf)
	-- 	end,
	-- })

	-- Alternatively, you can enable for specific languages:
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "python", "lua", "rust", "c" },
		callback = function(args)
			vim.treesitter.start(args.buf)
		end,
	})

	-- ========================================================================
	-- Treesitter Textobjects Configuration
	-- ========================================================================
	require("nvim-treesitter-textobjects").setup {
		select = {
			lookahead = true,
			selection_modes = {
				["@parameter.outer"] = "v", -- charwise
				["@function.outer"] = "V", -- linewise
				["@class.outer"] = "<c-v>", -- blockwise
			},
			include_surrounding_whitespace = false,
		},
		move = {
			set_jumps = true, -- Set jumps in the jumplist
		},
	}
	-- ========================================================================
	-- Textobject Keymaps
	-- ========================================================================
	local map = vim.keymap.set

	-- Select textobjects
	map({ "x", "o" }, "af", function()
		require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
	end, { desc = "Select outer function" })
	map({ "x", "o" }, "if", function()
		require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
	end, { desc = "Select inner function" })
	map({ "x", "o" }, "ac", function()
		require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
	end, { desc = "Select outer class" })
	map({ "x", "o" }, "ic", function()
		require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
	end, { desc = "Select inner class" })

	-- Move to next/previous function/class start
	map({ "n", "x", "o" }, "]f", function()
		require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
	end, { desc = "Next function start" })
	map({ "n", "x", "o" }, "]]", function()
		require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
	end, { desc = "Next class start" })
	map({ "n", "x", "o" }, "[f", function()
		require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
	end, { desc = "Previous function start" })
	map({ "n", "x", "o" }, "[[", function()
		require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
	end, { desc = "Previous class start" })

	-- Move to next/previous function/class end
	map({ "n", "x", "o" }, "]F", function()
		require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
	end, { desc = "Next function end" })
	map({ "n", "x", "o" }, "][", function()
		require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
	end, { desc = "Next class end" })
	map({ "n", "x", "o" }, "[F", function()
		require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
	end, { desc = "Previous function end" })
	map({ "n", "x", "o" }, "[]", function()
		require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
	end, { desc = "Previous class end" })

	-- Swap parameters
	map("n", "<leader>a", function()
		require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
	end, { desc = "Swap with next parameter" })
	map("n", "<leader>A", function()
		require("nvim-treesitter-textobjects.swap").swap_previous "@parameter.inner"
	end, { desc = "Swap with previous parameter" })
end

return M
