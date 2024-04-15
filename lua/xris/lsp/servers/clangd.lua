-- clangd
return {
  filetypes = {
    "c",
    "cpp",
    "objc",
    "objcpp",
    "cuda",
    "proto",
  },
  -- on_attach = function(client, bufnr)
  --   client.server_capabilities.signatureHelpProvider = false
  --   require("xris.lsp.handlers").on_attach(client, bufnr)
  -- end,
  cmd = {
    "clangd",
    "--query-driver=\"C:\\MinGW\\bin\\g++.exe\"",
    "--enable-config",
    "--log=verbose",
    "--completion-style=detailed",
    "--header-insertion=iwyu",
  },
  root_dir = require("lspconfig.util").root_pattern('.git'),
  single_file_support = false,
}
