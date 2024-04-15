-- Neovim alpha

local setup, alpha = pcall(require, "alpha")
if not setup then
  return
end

local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
"███╗░░██╗███████╗░█████╗░██╗░░░██╗██╗██████╗░███████╗",
"████╗░██║██╔════╝██╔══██╗██║░░░██║██║██╔══██╗██╔════╝",
"██╔██╗██║█████╗░░██║░░██║╚██╗░██╔╝██║██║░░██║█████╗░░",
"██║╚████║██╔══╝░░██║░░██║░╚████╔╝░██║██║░░██║██╔══╝░░",
"██║░╚███║███████╗╚█████╔╝░░╚██╔╝░░██║██████╔╝███████╗",
"╚═╝░░╚══╝╚══════╝░╚════╝░░░░╚═╝░░░╚═╝╚═════╝░╚══════╝",
}

-- dashboard.section.buttons.val = {
--   dashboard.button
-- }
