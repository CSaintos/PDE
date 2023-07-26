-- Neovim Lsp handlers
local M = {}
-- dependencies
local cmplsp_setup, cmplsp = pcall(require, "cmp_nvim_lsp")
if not cmplsp_setup then
  return
end

-- capabilities
M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmplsp.default_capabilities(M.capabilities)

-- diagnostics and signatures
M.setup = function()
  local signs = {
    Error = "",
    Warn = "",
    Hint = "",
    Info = ""
  }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text=icon,texthl=hl,numhl=""})
  end

  local config = {
    virtual_text = false, -- disable virtual text
    signs = {
      active = signs, -- show signs
    },
    update_in_insert = true,
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
  }
  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

-- attach
local keymapTable = require("xris.core.keymaps").NLspKey
M.on_attach = function(client, bufnr)
  -- keybinds
  local keymap = vim.keymap
  local opts = { noremap = true, silent = true, buffer = bufnr }
  for _, key in ipairs(keymapTable) do
    if #key == 2 then
      keymap.set("n", key[1], key[2], opts)
    elseif #key == 3 then
      keymap.set(key[1], key[2], key[3], opts)
    elseif #key == 4 then
      keymap.set(key[1], key[2], key[3], key[4])
    end
  end
  -- weirdly placed options
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
    keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
    keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports
    keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables
  end
  if client.name == "sumneko_lua" then
    client.server_capabilities.documentFormattingProvider = false
  end
  -- illuminate reference highlighting
  local i_setup, illuminate = pcall(require, "illuminate")
  if not i_setup then return end
  illuminate.on_attach(client)
end

return M
