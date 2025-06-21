local M = {}

M.on_attach = function(_, bufnr)
  require("mappings").lspconfig_attach(bufnr)
end

M.on_init = function(client, _)
  if client.supports_method("textDocument/semanticTokens") then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = {1}},
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits"
    }
  }
}

M.defaults = function()
  dofile(vim.g.base46_cache .. "lsp")
  require("nvchad.lsp").diagnostic_config()

  require("lspconfig").lua_ls.setup({
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    on_init = M.on_init,
    settings = {
      Lua = {
        diagnostics = {
          globals = {"vim"},
        },
        workspace = {
          library = {
            vim.fn.expand("$VIMRUNTIME/lua"),
            vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
            vim.fn.stdpath("data").."/lazy/ui/nvchad_types",
            vim.fn.stdpath("data").."/lazy/lazy.nvim/lua/lazy"
          },
          maxPreload = 100000,
          preloadFileSize = 10000
        }
      }
    }
  })
end

local on_attach = M.on_attach
local on_init = M.on_init
local capabilities = M.capabilities

local lspconfig = require("lspconfig")
local root_pattern = lspconfig.util.root_pattern
local servers = {
  "html",
  "eslint",
  "cssls",
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
    completeUnimported = false,
    semanticHighlighting = true,
  },
}

local default_diagnostic_config = {
  virtual_text = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
  signs = {
    active = true
  }
}

vim.diagnostic.config(default_diagnostic_config)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
require("lspconfig.ui.windows").default_options.border = "rounded"

return M
