-- marksman
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt.shiftwidth=2
    vim.opt.tabstop=2
  end,
})
return {}
