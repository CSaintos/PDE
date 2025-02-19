-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local root_pattern = lspconfig.util.root_pattern
local servers = {
  "html",
  "cssls",
  "eslint",
  "vuels",
  "nushell"
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
  cmd = { vim.fn.stdpath "data" .. "/mason/bin/omnisharp.cmd" },
  root_dir = function()
    return vim.loop.cwd()
  end,
  enable_import_completion = true,
  organize_imports_on_format = true,
  enable_roslyn_analyzers = true,
  filetypes = { "cs", "vb" },
  settings = {
    FormattingOptions = {
      EnableEditorConfigSupport = true,
    },
    MsBuild = {},
    RoslynExtensionsOptions = {},
    Sdk = {
      IncludePrereleases = true,
    },
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
    },
  },
}

-- groovy
lspconfig.groovyls.setup {
  cmd = { vim.fn.stdpath "data" .. "/mason/bin/groovy-language-server.cmd" },
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = on_init,
  root_dir = root_pattern("settings.gradle", ".git", "build.gradle", "gradlew"),
}

-- java
lspconfig.jdtls.setup {
  cmd = { vim.fn.stdpath "data" .. "/mason/bin/jdtls.cmd" },
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = on_init,
}

-- cpp
lspconfig.clangd.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = on_init,
  cmd = {
    -- see clangd --help-hidden
    "clangd",
    "--clang-tidy",
    "--background-index",
    "--completion-style=detailed",
    "--enable-config",
    '--query-driver="clang++.exe"',
  },
  init_options = {
    clangdFileStatus = true, -- Provides info about activity on clangd's per-file worker thread
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  },
}
