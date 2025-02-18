require('lint').linters_by_ft = {
  yaml = {'actionlint'},
  yml = {'actionlint'},
  sh = {'shellcheck'},
  json = {'jsonlint'},
}
vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter"}, {
  callback = function()
    -- try_lint without arguments runs the linters defined in `linters_by_ft`
    -- for the current filetype
    require("lint").try_lint()
  end,
})
