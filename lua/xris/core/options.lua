-- Neovim Options

local opt = {
  -- line numbers
  number = true, -- sets number side bar
  relativenumber = true, -- sets number side bar to relative numbers. 
  -- Tabs & indentation
  tabstop = 2, -- number of spaces per tab
  shiftwidth = 2, -- number of spaces to use for each step of (auto)indent
  softtabstop = 2, -- joins tab-spaces together for backspacing
  smarttab = true, -- inserts blanks according to shiftwidth.
  expandtab = true, -- use spaces for tabs line wrapping
  smartindent = true, -- smart autoindenting when starting new line.
  shiftround = true, -- rounds indent to multiple of shiftwidth
  list = true, -- tabs lines enabled?
  -- line wrapping
  wrap = true, -- sets line wrapping
  breakindent = true, -- wraps are visually indented
  linebreak = true, -- don't split words on wrap search settings
  -- searching
  ignorecase = true, -- searching is not case sensitive
  smartcase = true, -- If search is cased, then matches only with case sensitive cursor
  cursorline = true, -- sets line underneath cursor
  scrolloff = 8, -- min num of lines to keep above/below cursor
  sidescrolloff = 8, -- min num of chars to keep to right of cursor (only when wrap is false)
  -- appearance
  termguicolors = true, -- provides more colors to nvim ported from terminal/shell.
  background = "dark", -- default colorscheme to dark
  signcolumn = "yes", -- enables sign column 
  -- backspace
  backspace = "indent,eol,start",
  -- window splits
  splitright = true, -- horizontal split
  splitbelow = true, -- vertical split
  -- cmp and other pop ups
  pumheight = 8,
  -- mouse
  mouse = "a",
  mousemoveevent = true,
  mousescroll = "ver:3,hor:3",
}

-- Setting options from table
for setting, value in pairs(opt) do
  vim.opt[setting] = value
end

-- Non-table options
local opt2 = vim.opt

-- clipboard
opt2.clipboard:append("unnamedplus")
-- keywords
opt2.iskeyword:append("-")

-- Override builtin plugin options
local glo = {
  -- ftplugin ft styles, default=1 (enabled)
  python_recommended_style = 0, 
  markdown_recommended_style = 0,
  --did_load_filetypes = 1 -- default=0, checks for ftplugin loaded
}
-- setting builtin plugin options
for setting, value in pairs(glo) do
  vim.g[setting] = value
end

-- default builtin plugin confs located at C:\Program Files\Neovim\share\nvim\runtime
