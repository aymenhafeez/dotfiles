local check_path_length = function(path)
	local parts = vim.split(path, "/")
	if #parts > 5 then
		return vim.fn.pathshorten(path)
	else
		return path
	end
end

vim.print(check_path_length "/home/aymen/Documents/DataSci/")
