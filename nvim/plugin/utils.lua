P = function(v)
	print(vim.inspect(v))
	return v
end

RELOAD = function(...)
	return require("plenary.reload").reload_module(...)
end

R = function(name)
	RELOAD(name)
	return require(name)
end

-- local M = {}
--
-- -- helper function to set highlights
-- M.hi = function(group, opts)
--   local cmd = "highlight " .. group
--   if opts.fg then
--     cmd = cmd .. " guifg=" .. opts.fg
--   end
--   if opts.bg then
--     cmd = cmd .. " guibg=" .. opts.bg
--   end
--   if opts.sp then
--     cmd = cmd .. " guisp=" .. opts.sp
--   end
--   if opts.style then
--     cmd = cmd .. " gui=" .. opts.style
--   end
--   vim.cmd(cmd)
-- end
--
-- return M
