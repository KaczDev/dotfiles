function Check(file)
	if vim.g.vscode then
		print(file .. " VSCODE")
	else
		print(file .. " NORMAL")
	end
end

require("kacz")
