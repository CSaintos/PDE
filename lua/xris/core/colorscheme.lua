-- Neovim Colorscheme

-- default colorscheme
local colorscheme = "nightfly"

-- colorscheme setup
local setup, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not setup then
  print("Colorscheme " .. colorscheme .. "not found!")
  return
end


