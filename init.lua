-- Plugin Manager import
require("xris.plugins-setup")
-- Core imports
require("xris.core.options")
require("xris.core.keymaps")
require("xris.core.colorscheme")
-- Plugin imports
require("xris.plugins.comment")
require("xris.plugins.nvim-tree")
require("xris.plugins.lualine")
require("xris.plugins.telescope")
require("xris.plugins.nvim-cmp")
require("xris.plugins.autopairs")
require("xris.plugins.treesitter")
require("xris.plugins.gitsigns")
require("xris.plugins.transparent")
require("xris.plugins.alpha")
require("xris.plugins.bufferline")
require("xris.plugins.indent-blankline")
-- LSP imports
require("xris.lsp.mason")
require("xris.lsp.masonlsp")
require("xris.lsp.handlers").setup()
require("xris.lsp.null-ls")
-- Debug imports
require("xris.debug.dap_ui")
require("xris.debug.dap-python")
