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
  relativenumber = true, -- sets signcolumn numbers to be relative to the cursor
  -- line wrapping
  breakindent = true, -- wraps are visually indented
  linebreak = true, -- don't split words on wrap search settings
  wrap = true,
  -- searching
  ignorecase = true, -- searching is not case sensitive
  smartcase = true, -- if search is cased, then matches only with case sensitive
  -- editor margins
  scrolloff = 8, -- min num of lines to keep above/below cursor
  sidescrolloff = 8, -- min num of chars to keep to right of cursor (only when wrap is false)
  -- cmp and other pop ups
  pumheight = 8, -- height limit of a pop up

  -- shell
  sh = "nu", -- set shell
  shellcmdflag = "-c nu", -- execute shell flags
  -- Indenting
  fillchars = { eob = " " },
}

-- global-Local options
local o = {
  laststatus = 3,
  showmode = false,
  clipboard = "unnamedplus",
  cursorline = true,
  cursorlineopt = "both",
  -- Indenting
  expandtab = true,
  shiftwidth = 2,
  smartindent = true,
  tabstop = 2,
  softtabstop = 2,
  mouse = "a",
  -- Numbers
  number = true,
  numberwidth = 2,
  ruler = false,
  signcolumn = "yes",
  splitbelow = true,
  splitright = true,
  timeoutlen = 400,
  undofile = true,
  -- Swap file save interval
  updatetime = 250,
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

vim.lsp.set_log_level "debug"
vim.opt.shortmess:append "sI"
vim.opt.whichwrap:append "<>[]hl"

local is_windows = vim.fn.has("win32") ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({vim.fn.stdpath "data", "mason", "bin"},sep) .. delim ..vim.env.PATH
