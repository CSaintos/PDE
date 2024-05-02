-- EXAMPLE 
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers =
{
  "html",
  "cssls",
  "vuels",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- csharp
lspconfig.omnisharp.setup {
  cmd = {vim.fn.stdpath "data" .. "/mason/bin/omnisharp.cmd"},
  root_dir = function()
    return vim.loop.cwd()
  end,
  enable_import_completion = true,
  organize_imports_on_format = true,
  enable_roslyn_analyzers = true,
  filetypes = {"cs", "vb"},
  settings = {
    FormattingOptions = {
      EnableEditorConfigSupport = true
    },
    MsBuild = {},
    RoslynExtensionsOptions = {},
    Sdk = {
      IncludePrereleases = true
    }
  },
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

-- javascript / typescript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
    }
  }
}
