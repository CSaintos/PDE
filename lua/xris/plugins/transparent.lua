-- Neovim transparent

local setup, tp = pcall(require, "transparent")
if not setup then
  return 
end

tp.setup({
  extra_groups = { -- default groups
    "NormalFloat", -- float panel
    "NvimTreeNormal", -- NvimTree
  },
})

