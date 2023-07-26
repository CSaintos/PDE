-- Neovim null-ls
-- dependencies
local m_null_setup, m_null = pcall(require, "mason-null-ls")
local null_setup, null_ls = pcall(require, "null-ls")
if not (m_null_setup and null_setup) then
  return
end

-- https://github.com/jay-babu/mason-null-ls.nvim#setup
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
m_null.setup({
  ensure_installed = {
    -- Linters
    "ruff", -- python linting
    "mypy", -- python static typing
    -- Formatters
    --"prettier",
    --"stylua",
    --"eslint_d",
    "debugpy", -- python debugger
  },
  automatic_installation = true
})

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local format = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diag = null_ls.builtins.diagnostics
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  debug = false,
  sources = {
    --format.prettier.with({extra_args = {"--no-semi", "--single-quote", "--jsz-single-quote"}}),
    --format.black.with({extra_args = {"--fast"}}),
    --format.stylua,
    -- diag.eslint_d.with({
    --   -- only enable eslint if root has .eslintrc.js
    --   condition = function(utils)
    --     return utils.root_has_file(".eslintrc.js") -- file extension
    --   end,
    -- }),
    diag.ruff,
    diag.mypy,
  },
  -- configure format on save
  on_attach = function(current_client, bufnr)
    if current_client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({group=augroup,buffer=bufnr})
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer= bufnr,
        callback = function()
          vim.lsp.format({
            filter = function(client)
            -- only use null-ls for formatting instead of lsp
      -- server
              return client.name == "null-ls"
            end,
            bufnr=bufnr,
          })
        end,
      })
    end
  end,
  ft = { "python" },
})
