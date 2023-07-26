-- Neovim cmp (completions)
local cmp_setup, cmp = pcall(require, "cmp")
if not cmp_setup then
  return
end

local luasnip_setup, luasnip = pcall(require, "luasnip")
if not luasnip_setup then
  return
end

local lspkind_setup, lspkind = pcall(require, "lspkind")
if not lspkind_setup then
  return
end

local cmp_keys = require("xris.core.keymaps").CmpKey

-- load snippets from plugins
require("luasnip/loaders/from_vscode").lazy_load()

vim.opt.completeopt = "menu,menuone,noselect"

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert(cmp_keys), -- add custom keybinds
  sources = cmp.config.sources({
    { name = "nvim_lsp" }, -- lsp 
    { name = "luasnip" }, -- snippets
    { name = "buffer" }, -- text within current buffer
    { name = "path" }, -- file system paths
  }),
  formatting = {
    format = lspkind.cmp_format({
      maxwidth = 50,
      ellipsis_char = "...",
    }),
  },
})
