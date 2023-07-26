-- Markdown override default runtime settings
-- Options already taken care of in lua/core
local opt = {
--  expandtab = true,
--  tabstop = 2,
--  shiftwidth = 2,
}
for setting, value in pairs(opt) do
  vim.opt[setting] = value
end
