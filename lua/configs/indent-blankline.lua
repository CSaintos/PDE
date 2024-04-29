local hooks = require "ibl.hooks"

local hook_options = {
  -- hooks.type.WHITESPACE,
  -- hooks.builtin.hide_first_space_indent_level
}

hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "RainbowRed", {fg = "#E06C75"})
  vim.api.nvim_set_hl(0, "RainbowOrange", {fg = "#E5C07B"})
  vim.api.nvim_set_hl(0, "RainbowGreen", {fg = "#98C379"})
  vim.api.nvim_set_hl(0, "RainbowCyan", {fg = "#56B6C2"})
  vim.api.nvim_set_hl(0, "RainbowBlue", {fg = "#61AFEF"})
  vim.api.nvim_set_hl(0, "RainbowPurple", {fg = "#C678DD"})
end)

local highlight = {
  "RainbowRed",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowCyan",
  "RainbowBlue",
  "RainbowPurple"
}

local options = {
  indent = {
    char = "│",
    highlight = highlight
  },
  scope = {
    enabled = false
  }
}

require("ibl").setup(options)

