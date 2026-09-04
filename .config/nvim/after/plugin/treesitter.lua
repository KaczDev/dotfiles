-- Treesitter highlighting is enabled automatically for supported filetypes.
-- Use vim.treesitter.start() in an autocmd if you need it for additional filetypes.
--
vim.api.nvim_create_autocmd("FileType", {
    pattern = { '<filetype>' },
    group = config_augroup,
    callback = function(args)
        local treesitter = require('nvim-treesitter')
        local lang = vim.treesitter.language.get_lang(args.match)
        if vim.list_contains(treesitter.get_available(), lang) then
            if not vim.list_contains(treesitter.get_installed(), lang) then
                treesitter.install(lang):wait()
            end
            vim.treesitter.start(args.buf)
        end
    end,
    desc = "Enable nvim-treesitter and install parser if not installed"
})
