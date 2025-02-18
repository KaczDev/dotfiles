vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
require("outline").setup {
	-- Your setup opts here (leave empty to use defaults)
	outline_items = {
		show_symbol_lineno = true
	}
}
