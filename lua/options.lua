-- global options
local g = {
  toggle_theme_icon = "   ",
  -- disable default providers
  loaded_node_provider = 0,
  loaded_python3_provider = 0,
  loaded_perl_provider = 0,
  loaded_ruby_provider = 0,
}

-- standard options
local opt = {
  -- line numbers
  relativenumber = true, -- set numbers relative to cursor in signcolumn
  number = true, -- show number of each line in signcolumn
  numberwidth = 2, -- number column width
  signcolumn = "yes", -- enable signcolumn
  -- line wrapping
  breakindent = true, -- wraps are visually indented
  linebreak = true, -- don't split words on wrap search settings
  wrap = true,
  -- line cursor
  cursorline = true, -- highlight current line
  -- searching
  ignorecase = true, -- searching is not case sensitive
  smartcase = true, -- if search is cased, then matches only with case sensitive
  -- editor margins
  scrolloff = 8, -- min num of lines to keep above/below cursor
  sidescrolloff = 8, -- min num of chars to keep to right of cursor (only when wrap is false)
  -- cmp and other pop ups
  pumheight = 8, -- height limit of a pop up
  timeoutlen = 400, -- wait time for mapped sequence to complete (ms)
  -- completeopt = {"menuone", "noselect"},
  -- shell
  sh = "nu", -- set shell
  shellcmdflag = "-c nu", -- execute shell flags
  -- Indenting
  fillchars = { eob = " " },
  smartindent = true,
  expandtab = true, -- converts tabs to spaces
  shiftwidth = 2, -- num of spaces for each indentation
  tabstop = 2, -- insert 2 spaces for a <tab>
  softtabstop = 2,
  -- clipboard
  clipboard = "unnamedplus",
  -- backup
  backup = false, -- creates backup file
  swapfile = false, -- create a swap file
  updatetime = 250, -- swap file save interval (ms)
  undofile = true, -- enable persistent undo
  -- mouse
  mouse = "a", -- allow mouse use in Neovim
  -- editor mode
  showmode = false, -- default Neovim mode (INSERT/NORMAL/VISUAL/..) status experience
  -- windows
  splitbelow = true, -- force horizontal splits below current window
  splitright = true, -- force vertical splits right of current window
  laststatus = 3,
  ruler = false,
}

-- global-Local options
local o = {
  cursorlineopt = "both",
}

for setting, value in pairs(o) do
  vim.o[setting] = value
end

for setting, value in pairs(opt) do
  vim.opt[setting] = value
end

for setting, value in pairs(g) do
  vim.g[setting] = value
end

vim.lsp.set_log_level "off"
vim.opt.shortmess:append "sI"
vim.opt.whichwrap:append "<>[]hl"

local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH
