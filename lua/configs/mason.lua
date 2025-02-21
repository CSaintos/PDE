dofile(vim.g.base46_cache .. "mason")

local options = {
  PATH = "skip",
  ui = {
    icons = {
      package_pending = " ",
      package_installed = "󰄳 ",
      package_uninstalled = " 󰚌",
    },
    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
      cancel_installation = "<C-c>",
    },
  },
  max_concurrent_installers = 10,
  ensure_installed = {
    "lua-language-server", -- lua lsp
    "stylua", -- lua format
    "omnisharp", -- csharp lsp
    "vue-language-server", -- vue lsp
    "typescript-language-server", -- javascript / typescript lsp
    "eslint-lsp", -- javascript / typescript lint
    "js-debug-adapter", -- javascript / typescript debug adapter
    "groovy-language-server", -- groovy lsp
    "jdtls", -- java lsp
    "clangd", -- cpp lsp
  }
}

return options
