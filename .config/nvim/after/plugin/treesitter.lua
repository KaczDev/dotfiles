	require 'nvim-treesitter.configs'.setup {
		-- A list of parser names, or "all"
		ensure_installed = { "vimdoc", "javascript", "typescript", "lua", "rust", "ruby", "bash" },
		sync_install = false,
		auto_install = true,

		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
	}
	vim.keymap.set("n", "[c", function()
		require("treesitter-context").go_to_context(vim.v.count1)
	end, { silent = true })

-- require'nvim-treesitter.configs'.setup {
--   -- A list of parser names, or "all"
--     ensure_installed = "all",
--   -- Install parsers synchronously (only applied to `ensure_installed`)
--   sync_install = false,
--   -- Automatically install missing parsers when entering buffer
--   -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
--   auto_install = true,
--
--   highlight = {
--     -- `false` will disable the whole extension
--     enable = true,
--
--     additional_vim_regex_highlighting = false,
--   },
--   autotag = {
--       enable = true,
--   }
-- }
--
