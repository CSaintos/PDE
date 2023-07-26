-- Neovim mason lsp
-- dependencies
local m_setup, mason_lsp = pcall(require, "mason-lspconfig")
local l_setup, lspconf = pcall(require, "lspconfig")
if not (m_setup and l_setup) then
  return
end

-- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
local servers = {
  "clangd", -- C, C++
  -- "csharp_ls", -- C#
  "cmake", -- CMake
  "cssls", -- CSS
  "dockerls", -- Docker
  -- "fsautocomplete", -- F#
  "gradle_ls", -- Gradle
  -- "groovyls", -- Groovy
  "html", -- HTML
  "jsonls", -- JSON
  "tsserver", -- Javascript, Typescript
  "kotlin_language_server", -- Kotlin
  "lua_ls", -- Lua
  "marksman", -- Markdown
  "powershell_es", -- Powershell
  "pyright", -- Python
  "ruby_ls", -- Ruby
  "sqlls", -- SQL
  "taplo", -- TOML
  "lemminx", -- XML
  "yamlls", -- YAML
}

mason_lsp.setup({
  ensure_installed = servers,
  automatic_installation = true,
})

local opts = {}
for _, server in pairs(servers) do
  opts = {
    on_attach = require("xris.lsp.handlers").on_attach,
    capabilities = require("xris.lsp.handlers").capabilities,
  }
  local s_setup, conf_opts = pcall(require, "user.lsp.settings."..server)
  if s_setup then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
  end

  lspconf[server].setup(opts)
end
