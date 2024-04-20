require "nvchad.options"

-- For default options check https://github.com/NvChad/NvChad/blob/v2.5/lua/nvchad/options.lua 

-- standard options 
local opt = {
  -- line numbers
  relativenumber = true, -- sets signcolumn numbers to be relative to the cursor
  -- line wrapping
  breakindent = true, -- wraps are visually indented
  linebreak = true, -- don't split words on wrap search settings
  -- searching
  ignorecase = true, -- searching is not case sensitive
  smartcase = true, -- if search is cased, then matches only with case sensitive 
  -- editor margins
  scrolloff = 8, -- min num of lines to keep above/below cursor
  sidescrolloff = 8, -- min num of chars to keep to right of cursor (only when wrap is false)
  -- cmp and other pop ups
  pumheight = 8, -- height limit of a pop up

  -- shell
  sh = 'nu', -- set shell 
  shellcmdflag = '-c nu' -- execute shell flags
}

-- Local options
local o = {
}

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

for setting, value in pairs(o) do
  vim.o[setting] = value
end

for setting, value in pairs(opt) do
  vim.opt[setting] = value
end
