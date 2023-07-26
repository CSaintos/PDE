-- Neovim keymap
local M = {}

-- key options
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
-- Leader key
vim.keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- dependencies
local cmp_setup, cmp = pcall(require, "cmp")
local ta_setup, ta = pcall(require, "telescope.actions")
local dpy_setup, dpy = pcall(require, "dap-python")
local dap_setup, _ = pcall(require, "dap")

-- Normal Mode Lsp Keymaps
M.NLspKey = {
  {"gR", "<cmd>Telescope lsp_reference<CR>"}, -- show definition, references
  {"gD", vim.lsp.buf.declaration}, -- goto declaration
  {"gd", "<cmd>Telescope lsp_definitions<CR>"}, -- see definition and make edits in window
  {"gi", "<cmd>Telescope lsp_implementations<CR>"}, -- goto implementation
  {"gt", "<cmd>Telescope lsp_type_defintions<CR>"}, -- goto type definition
  {{"n", "v"}, "<leader>ca", vim.lsp.buf.code_action}, -- see available code actions
  {"<leader>rn", ":IncRename "}, -- smart rename
  {"<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>"}, -- show diagnostics for file
  {"<leader>d", vim.diagnostic.open_float}, -- view diagnostic cursor hover
  {"]d", vim.diagnostic.goto_prev}, -- jump to previous diagnostic in buffer
  {"[d", vim.diagnostic.goto_next}, -- jump to next diagnostic in buffer
  {"K", vim.lsp.buf.hover}, -- show documentation for what is under cursor
}

-- Code Completion keymaps
if cmp_setup then
  M.CmpKey = {
    ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
    ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
    ["<C-e>"] = cmp.mapping.abort(), -- close completion window
    ["<CR>"] = cmp.mapping.confirm({select=false}),
  }
end

-- Telescope Actions Keymaps
if ta_setup then
  M.TelKey = {
    ["<C-k>"] = ta.move_selection_previous, -- move to prev result
    ["<C-j>"] = ta.move_selection_next, -- move to next result
    ["<C-q>"] = ta.send_selected_to_qflist + ta.open_qflist, -- send selected to quickfixList
  }
end

-- dap keymaps
if dap_setup then
  local NDap = {
    {"<leader>db", "<cmd> DapToggleBreakpoint <CR>"} -- toggle break point
  }
end
if dpy_setup then
  local NDebugpy = {
    ["<leader>dpr"] = { -- debug python run
      function()
        dpy.test_method()
      end
    }
  }
end

-- bufferline keymaps
local NBufferline = {
  {"<leader>1", "<cmd>BufferLineGoToBuffer 1<CR>"},
  {"<leader>2", "<cmd>BufferLineGoToBuffer 2<CR>"},
  {"<leader>3", "<cmd>BufferLineGoToBuffer 3<CR>"},
  {"<leader>4", "<cmd>BufferLineGoToBuffer 4<CR>"},
  {"<leader>5", "<cmd>BufferLineGoToBuffer 5<CR>"},
  {"<leader>6", "<cmd>BufferLineGoToBuffer 6<CR>"},
  {"<leader>7", "<cmd>BufferLineGoToBuffer 7<CR>"},
  {"<leader>8", "<cmd>BufferLineGoToBuffer 8<CR>"},
  {"<leader>9", "<cmd>BufferLineGoToBuffer 9<CR>"},
  {"<S-h>", "<cmd>BufferLineCyclePrev<CR>"},
  {"<S-l>", "<cmd>BufferLineCycleNext<CR>"},
  {"<Tab><Tab>", "<cmd>BufferLineMoveNext<CR>"},
  {"<S-Tab><S-Tab>", "<cmd>BufferLineMovePrev<CR>"},
  {"<S-w>", "<cmd>lua require('bufdelete').bufdelete()<CR>"},
}

-- Normal Mode Keymaps
local Nkey = {
  -- Standard keymaps
  -- search
  {"<leader>nh", ":nohl<CR>"}, -- unhighlight search selection
  -- char edits
  {"x", '"_'}, -- del char without saving to clipboard
  -- digits
  {"<leader>+", "<C-a>"}, -- increment digit
  {"<leader>-", "<C-x>"}, -- decrement digit
  -- window splits
  {"<leader>sv", "<C-w>v"}, -- split window vertically
  {"<leader>sh", "<C-w>s"}, -- split window horizontally
  {"<leader>se", "<C-w>="}, -- Make split windows equal width
  {"<leader>sx", ":close<CR>"}, -- close current split window
  -- window resizing
  {"<C-Up>", ":resize -2<CR>"},
  {"<C-Down>", ":resize +2<CR>"},
  {"<C-Left>", ":vertical resize -2<CR>"},
  {"<C-Right>", ":vertical resize +2<CR>"},
  -- tabs
  {"<leader>to", ":tabnew<CR>"}, -- open new tab
  {"<leader>tx", ":tabclose<CR>"}, -- close current tab
  {"<leader>tn", ":tabn<CR>"}, -- goto next tab
  {"<leader>tp", ":tabp<CR>"}, -- goto previous tab
  {"j", "gj"}, -- do not skip over wrap lines
  {"k", "gk"}, -- do not skip over wrap lines

  -- Plugin keymaps
  -- vim-maximizer
  {"<leader>sm", ":MaximizerToggle<CR>"}, -- toggle window maximizer
  -- nvim-tree
  {"<leader>e", ":NvimTreeToggle<CR>"}, -- toggle explorer
  -- telescope
  {"<leader>ff", "<cmd>Telescope find_files<CR>"}, -- find files
  {"<leader>fs", "<cmd>Telescope live_grep<CR>"}, -- find text
  {"<leader>fc", "<cmd>Telescope grep_string<CR>"}, -- find text at cursor
  {"<leader>fb", "<cmd>Telescope buffers<CR>"}, -- show active buffers
  {"<leader>fh", "<cmd>Telescope help_tags<CR>"}, -- show help tags
  -- transparent
  {"<leader>tt", "<cmd>TransparentToggle<CR>"}, -- toggle transparency
  -- markdown preview
  {"<C-s>", "<cmd>MarkdownPreviewToggle<CR>"}, -- toggle markdown preview
}

-- Insert Mode Keymaps
local Ikey = {
  {"jj", "<ESC>"}, -- exit Insert Mode
}

-- Setting Keymaps from tables
  -- Normal keymaps
for _, key in ipairs(Nkey) do
  vim.keymap.set("n", key[1], key[2])
end
    -- bufferline
for _, key in ipairs(NBufferline) do 
  if #key == 2 then
    vim.keymap.set("n", key[1], key[2])
  elseif #key == 3 then
    vim.keymap.set("n", key[1], key[2], key[3])
  end
end
  -- Insert Keymaps
for _, key in ipairs(Ikey) do
  vim.keymap.set("i", key[1], key[2])
end

-- Export M 
return M
