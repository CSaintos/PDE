-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that syncs nvim plugins when file saved
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
--   augroup end
-- ]])

-- import packer
local setup, packer = pcall(require, "packer")
if not setup then
  return
end

-- List of plugins
return packer.startup(function(use)
  use("wbthomason/packer.nvim") -- packer
  use("nvim-lua/plenary.nvim") -- plugin dependency for other plugins
  use("xiyaowong/transparent.nvim") -- transparent background
  use("bluz71/vim-nightfly-guicolors") -- colorscheme
  use("christoomey/vim-tmux-navigator") -- tmux & split window nav
  use("szw/vim-maximizer") -- maximizes and restores current window
  use("tpope/vim-surround") -- surround string with any pair of chars
  use("vim-scripts/ReplaceWithRegister") -- copy and replace strings
  use("numToStr/Comment.nvim") -- comment and uncomment strings
  use("nvim-tree/nvim-tree.lua") -- file explorer
  use("kyazdani42/nvim-web-devicons") -- nvim icons
  use("nvim-lualine/lualine.nvim") -- status line
  use({"nvim-telescope/telescope-fzf-native.nvim",run="C:/MinGW/bin/mingw32-make.exe"}) -- telescope dependency
  use({"nvim-telescope/telescope.nvim",branch="0.1.x"}) -- fuzzy finder
  use("lewis6991/gitsigns.nvim") -- git signs
  use("goolord/alpha-nvim") -- nvim greeter
  use({"iamcco/markdown-preview.nvim",run=function()vim.fn["mkdp#util#install()"]() end,}) -- markdown preview
  use({"akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons"}) -- bufferline
  use("famiu/bufdelete.nvim") -- bufferline delete fix
  use("lukas-reineke/indent-blankline.nvim") -- tab lines
  -- code completion plugins
  use("nvim-telescope/telescope-ui-select.nvim") -- lsp code actions
  use("hrsh7th/nvim-cmp") -- General autocompletion
  use("hrsh7th/cmp-buffer") -- nvim-cmp tool to store autocompletions
  use("hrsh7th/cmp-path") -- nvim-cmp tool to store path autocompletions
  use("L3MON4D3/LuaSnip") -- code snippet engine
  use("saadparwaiz1/cmp_luasnip") -- add snippets to autocompletion
  use("rafamadriz/friendly-snippets") -- common code snippets for many languages
  -- lsp plugins
  use("williamboman/mason.nvim") -- managing & installing lsp servers, linters, & formatters
  use("williamboman/mason-lspconfig.nvim") -- nvim lsp wrapper
  use("neovim/nvim-lspconfig") -- configuring lsp servers
  use("hrsh7th/cmp-nvim-lsp") -- config lsp autocompletion
  use("onsails/lspkind.nvim") -- cmplsp extension adds icons
  use("jose-elias-alvarez/typescript.nvim") -- typescript lsp extension
  use("mfussenegger/nvim-jdtls") -- java lsp extension
  use("RRethy/vim-illuminate") -- highlight other uses of word
  -- formatting and linting plugins
  use("jose-elias-alvarez/null-ls.nvim") -- config formatters and linters
  use("jay-babu/mason-null-ls.nvim") -- format and lint with mason
  use({"nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({with_sync=true})
      ts_update()
    end,
  })
  use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc.
  use({"windwp/nvim-ts-autotag", after = "nvim-treesitter"}) -- autoclose tags

  -- Debugging
  use("mfussenegger/nvim-dap")
  use("rcarriga/nvim-dap-ui")
  use("mfussenegger/nvim-dap-python")


  if packer_bootstrap then
    require("packer").sync()
  end
end)
