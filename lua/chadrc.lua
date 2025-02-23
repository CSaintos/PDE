-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "everforest",
  transparency = true,
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

M.ui = {
  statusline = {
    theme = "vscode_colored",
  },
}

M.nvdash = {
  load_on_startup = true,
  header = {
    "                            ",
    "   ▄▄▄▄▄▄ ▄▄▄▄▄  ▄▄▄▄▄▄▄    ",
    "  ████▀▀ ▀████  █████████▄  ",
    "   ▄▄▄▄▄██ █  █  ▄▄▄        ",
    "  ██████▀ ▄█  ██  █████▄    ",
    "  ███    ██▄▄▄███ ██        ",
    "  ██▀    ██████▀ ████████▄  ",
    "                            ",
    "     Powered By  eovim    ",
    "                            ",
  },
  buttons = {
    { txt = "  Toggle File Manager", keys = "<C-n>", cmd = "NvimTreeToggle" },
    { txt = "  Toggle Terminal", keys = "<A-b>", cmd = ":lua require('nvchad.term').toggle({pos='sp', id='htoggleTerm'})" },
    { txt = "󰈭  Find Word", keys = "fw", cmd = "Telescope live_grep" },
    { txt = "󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
    { txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "NvDashFooter",
      no_gap = true,
    },
    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
  },
}

return M
