vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- https://vi.stackexchange.com/questions/46485/how-to-fix-undefined-field-fs-stat-warning-in-lua-language-server-for-neovim-0
if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "autocmds"
require "options"

vim.schedule(function()
  require "mappings"
end)
-- does what mason-lspconfig would do but better
vim.schedule(function()
  local ei = require("configs.mason").ensure_installed
  local ii = require("mason-registry").is_installed
  if not ii(ei[math.random(#ei)]) then
    vim.cmd("MasonInstallAll")
  end
end)
