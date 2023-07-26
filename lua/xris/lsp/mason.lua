-- Neovim mason
-- dependencies
local m_setup, mason = pcall(require, "mason")
if not m_setup then
  return
end

-- refer to mason default configuration
local settings = {
  ui = {
    border = "none",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
			package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

mason.setup(settings)
