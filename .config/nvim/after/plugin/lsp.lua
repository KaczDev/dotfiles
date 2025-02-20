-- local lsp = require("lsp-zero")
--
-- -- lsp.preset("recommended")
--
-- -- lsp.ensure_installed({
-- --     'tsserver',
-- --     'eslint',
-- --     'rust_analyzer',
-- --     'pyright'
-- -- })
--
-- -- Fix Undefined global 'vim'
-- -- lsp.configure('sumneko_lua', {
-- --     settings = {
-- --         Lua = {
-- --             diagnostics = {
-- --                 globals = { 'vim' }
-- --             }
-- --         }
-- --     }
-- -- })
--
--
-- local cmp = require('cmp')
-- local cmp_select = { behavior = cmp.SelectBehavior.Select }
-- local cmp_mappings = lsp.defaults.cmp_mappings({
--     ['<C-r>'] = cmp.mapping.select_prev_item(cmp_select),
--     ['<C-t>'] = cmp.mapping.select_next_item(cmp_select),
--     ['<C-y>'] = cmp.mapping.confirm({ select = true }),
--     -- Scroll up and down in the completion documentation
--     ['<C-u>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-d>'] = cmp.mapping.scroll_docs(4),
--     ["<C-Space>"] = cmp.mapping.complete(),
-- })
--
-- -- disable completion with tab
-- -- this helps with copilot setup
-- --cmp_mappings['<Tab>'] = nil
-- --cmp_mappings['<S-Tab>'] = nil
--
-- lsp.setup_nvim_cmp({
--     mapping = cmp_mappings
-- })
--
-- lsp.set_preferences({
--     suggest_lsp_servers = false,
--     sign_icons = {
--         error = 'E',
--         warn = 'W',
--         hint = 'H',
--         info = 'I'
--     }
--     ,
--     configure_diagnostics = true
-- })
--
-- lsp.on_attach(function(client, bufnr)
--     local opts = { buffer = bufnr, remap = false }
--
--     if client.name == "eslint" then
--         vim.cmd.LspStop('eslint')
--         return
--     end
--
--     vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
--     vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
--     vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
--     vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
--     vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
--     vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
--     vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
--     vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
--     vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
--     vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
-- end)
--
-- vim.diagnostic.config({
--     virtual_text = true,
-- })
--
-- vim.filetype.add({ extension = { templ = "templ" } })
--
-- lsp.setup()
--
-- local lspconfig = require('lspconfig')
--
-- lspconfig.html.setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
--     filetypes = { "html", "templ" },
-- })
--
-- lspconfig.htmx.setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
--     filetypes = { "html", "templ" },
-- })
--
--
--MASON CONFIG
require('mason').setup({})
require('mason-lspconfig').setup({
	-- Replace the language servers listed here
	-- with the ones you want to install
	ensure_installed = {
		"lua_ls",
		"rust_analyzer",
		"gopls",
		"goimports",
		"golangci-lint",
		"jqls",
		"jsonlint",
		"jsonls",
		"rubocop@1.62.1",
		"shellcheck",
		"yamlls",
	},
	handlers = {
		function(server_name)
			require('lspconfig')[server_name].setup({})
		end,
	}
})
-- Reserve a space in the gutter

vim.opt.signcolumn = 'yes'

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
	'force',
	lspconfig_defaults.capabilities,
	require('cmp_nvim_lsp').default_capabilities()
)

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP actions',
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
		vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
		vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
		vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
		vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
		vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
		vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
		vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
		vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
		vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
		vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
	end,
})

require('lspconfig').rust_analyzer.setup({})
-- Ruby
vim.env.SRB_SKIP_GEM_RBIS = 1
require("lspconfig")["sorbet"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

local cmp = require('cmp')
cmp.setup({
	sources = {
		{ name = 'nvim_lsp' },
	},
	snippet = {
		expand = function(args)
			-- You need Neovim v0.10 to use vim.snippet
			vim.snippet.expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({}),
})
