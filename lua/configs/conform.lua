local options = {
  formatters_by_ft = {
    -- ["*"] = {
    --   "trim_whitespace"
    -- },
    -- lua = { "stylua" },
    -- css = { "prettier" },
    -- html = { "prettier" },
  },
  format_on_save = {
    timeout_ms = 500,
    -- lsp_fallback = true,
  },
  format_after_save = {
    -- lsp_fallback = true,
  },
  log_level = vim.log.levels.ERROR,
}

return options
