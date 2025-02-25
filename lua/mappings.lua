local M = {} -- keymap exports
local map = vim.keymap.set
local unmap = vim.keymap.del
-- local wka = require("which-key").add

--> Standard Keymaps
-- Insert Mode Keymaps
map("i", "jk", "<Esc>", { desc = "Insert: To Normal Mode" })
map("i", "<C-b>", "<Esc>^i", { desc = "Insert: goto beginning of line" })
map("i", "<C-e>", "<End>", { desc = "Insert: goto end of line" })
map("i", "<C-h>", "<Left>", { desc = "Insert: Left" })
map("i", "<C-l>", "<Right>", { desc = "Insert: Right" })
map("i", "<C-j>", "<Down>", { desc = "Insert: Down" })
map("i", "<C-k>", "<Up>", { desc = "Insert: Up" })
-- Normal Mode Keymaps
map("n", "<Esc>", "<cmd>noh<cr>", { desc = "Search: clear highlights" })
map("n", "<C-h>", "<C-w>h", { desc = "Window: switch left" })
map("n", "<C-l>", "<C-w>l", { desc = "Window: switch right" })
map("n", "<C-j>", "<C-w>j", { desc = "Window: switch down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window: switch up" })
map("n", "<C-s>", "<cmd>w<cr>", { desc = "File: save" })
map("n", "<C-c>", "<cmd>%y+<cr>", { desc = "File: copy" })
map("n", "<leader>n", "<cmd>set nu!<cr>", { desc = "Number: toggle line" })
map("n", "<leader>rn", "<cmd>set rnu!<cr>", { desc = "Number: toggle relative" })
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP: diagnostic loclist" })
map("n", "<leader>/", "gcc", { desc = "LSP: toggle comment", remap = true })
map("n", "j", "gj", { desc = "Navigate: Down" })
map("n", "k", "gk", { desc = "Navigate: Up" })
map("n", "<C-a>", "<C-a>", { desc = "LSP: Increment digit" })
map("n", "<C-x>", "<C-x>", { desc = "LSP: Decrement digit" })
map("n", "<leader>sv", "<C-w>v", { desc = "Window: Split vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Window: Split horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Window: even out windows" })
map("n", "<leader>sx", ":close<cr>", { desc = "Window: Close" })
map("n", "<C-Up>", "<cmd>resize -2<cr>", { desc = "Window: Resize upwards" })
map("n", "<C-Down>", "<cmd>resize +2<cr>", { desc = "Window: Resize downwards" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Window: Resize leftwards" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Window: Resize rightwards" })
map("n", "<leader>to", "<cmd>tabnew<cr>", { desc = "Tab: New" })
map("n", "<leader>tx", "<cmd>tabclose<cr>", { desc = "Tab: Close" })
map("n", "<leader>tn", "<cmd>tabn<cr>", { desc = "Tab: Next" })
map("n", "<leader>tp", "<cmd>tabp<cr>", { desc = "Tab: Prev" })
map("n", ";", ":", { desc = "cmd: enter command mode" })
-- Visual Mode Keymaps
map("v", "<leader>/", "gc", { desc = "LSP: toggle comment", remap = true })
map("v", "<", "<gv", { desc = "LSP: indent shift forward" })
map("v", ">", ">gv", { desc = "LSP: indent shift backward" })
-- Terminal Mode Keymaps
map("t", "<C-x>", "<C-\\><C-N>", { desc = "term: escape" })
-- x mode Keymaps
map("x", "p", [["_dP]], { desc = "LSP: paste again" })
map({ "n", "o", "x" }, "<S-h>", "^", { desc = "Navigate: beginning line (text)" })
map({ "n", "o", "x" }, "<S-l>", "g_", { desc = "Navigate: end line (text)" })

-- nvimtree
M.nvimtree_attach = function(nt_api, bufnr)
  map("n", "<C-p>", nt_api.tree.change_root_to_parent, { desc = "nvim-tree: Parent Directory", buffer = bufnr })
  map("n", "h", nt_api.node.navigate.parent_close, { desc = "nvim-tree: Close Directory", buffer = bufnr })
  map("n", "l", function()
    if nt_api.tree.get_node_under_cursor().name ~= ".." then
      nt_api.node.open.edit()
    end
  end, { desc = "nvim-tree: Open", buffer = bufnr })
  map("n", "<cr>", function()
    if nt_api.tree.get_node_under_cursor().name ~= ".." then
      nt_api.node.open.edit()
    else
      nt_api.tree.toggle_help()
    end
  end, { desc = "nvim-tree: Open", buffer = bufnr })
  unmap("n", "<Tab>", { desc = "Open Preview", buffer = bufnr })
  unmap("n", "o", { desc = "Open", buffer = bufnr })
  unmap("n", "O", { desc = "Open (No Window)", buffer = bufnr })
end

M.nvimtree = function()
  map("n", "<C-n>", "<cmd>NvimTreeToggle<cr>", { desc = "nvimtree: Toggle Window" })
  map("n", "<leader>e", "<cmd>NvimTreeFocus<cr>", { desc = "nvimtree: Focus Window" })
end

-- markdown-preview
M.mkpv = function()
  map("n", "<C-m>", "<cmd>MarkdownPreviewToggle<cr>", { desc = "MarkdownPreviewToggle" })
end

-- vimtex
M.vimtex = function()
  map("n", "<localleader>li", "<plug>(vimtex-info)", { desc = "Vimtex: Info" })
  map("n", "<localleader>ll", "<plug>(vimtex-compile)", { desc = "Vimtex: Compile" })
  map("n", "<localleader>lk", "<plug>(vimtex-stop)", { desc = "Vimtex: Stop" })
  map("n", "<localleader>lc", "<plug>(vimtex-clean)", { desc = "Vimtex: Clean" })
end

-- lspconfig
M.lspconfig_attach = function(bufnr)
  map("n", "gD", vim.lsp.buf.declaration, { desc = "LSP: goto declaration", buffer = bufnr })
  map("n", "gd", vim.lsp.buf.definition, { desc = "LSP: goto definition", buffer = bufnr })
  map("n", "gi", vim.lsp.buf.implementation, { desc = "LSP: goto implementation", buffer = bufnr })
  map("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "LSP: Show signature", buffer = bufnr })
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "LSP: Add workspace folder", buffer = bufnr })
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "LSP: Remove workspace folder", buffer = bufnr })
  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { desc = "LSP: List workspace folders", buffer = bufnr })
  map("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "LSP: goto type definition", buffer = bufnr })
  map("n", "<leader>ra", function()
    require "nvchad.lsp.renamer"()
  end, { desc = "LSP: Renamer", buffer = bufnr })
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: Code action", buffer = bufnr })
  map("n", "gr", vim.lsp.buf.references, { desc = "LSP: Show references", buffer = bufnr })
  map("n", "gl", vim.diagnostic.open_float, { desc = "LSP: Show diagnostics", buffer = bufnr})
end

-- dap
M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd>DapToggleBreakpoint<cr>",
      "DAP: add breakpoint at line",
    },
    ["<leader>dr"] = {
      "<cmd>DapContinue<cr>",
      "DAP: run or continue the debugger",
    },
  },
}

-- Base46
M.base46 = function(b46_api)
  map("n", "<leader>tt", b46_api.toggle_theme, { desc = "theme: toggle", remap = true })
end

-- NvCheatsheet
M.NvCheatsheet = function()
  map("n", "<leader>ch", "<cmd>NvCheatsheet<cr>", { desc = "nvcheatsheet: toggle" })
end

-- Conform
M.Conform = function(c_api)
  map("n", "<leader>fm", function()
    c_api.format { lsp_fallback = true }
  end, { desc = "format: files" })
end

-- Tabufline
M.Tabufline = function(tfl_api)
  map("n", "<leader>b", "<cmd>enew<cr>", { desc = "buffer: new" })
  map("n", "<tab>", function()
    tfl_api.next()
  end, { desc = "buffer: next" })
  map("n", "<S-tab>", function()
    tfl_api.prev()
  end, { desc = "buffer: prev" })
  map("n", "<leader>x", function()
    tfl_api.close_buffer()
  end, { desc = "buffer: close" })
  map("n", "x", function()
    tfl_api.close_buffer()
  end, { desc = "buffer: close" })
end

-- Telescope
M.telescope = function()
  map("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "telescope: live grep" })
  map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "telescope: find buffers" })
  map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "telescope: help page" })
  map("n", "<leader>ma", "<cmd>Telescope marks<cr>", { desc = "telescope: find marks" })
  map("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "telescope: find oldfiles" })
  map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "telescope: find in current buffer" })
  map("n", "<leader>cm", "<cmd>Telescope git_commits<cr>", { desc = "telescope: git commits" })
  map("n", "<leader>gt", "<cmd>Telescope git_status<cr>", { desc = "telescope: git status" })
  map("n", "<leader>pt", "<cmd>Telescope terms<cr>", { desc = "telescope: pick hidden term" })
  map("n", "<leader>th", "<cmd>Telescope themes<cr>", { desc = "telescope: nvchad themes" })
  map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope: find files" })
  map(
    "n",
    "<leader>fa",
    "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>",
    { desc = "telescope: find all files" }
  )
end

-- chadterm
M.chadterm = function(ct_api)
  map("n", "<leader>h", function()
    ct_api.new { pos = "sp" }
  end, { desc = "term: new horizontal" })
  map("n", "<leader>v", function()
    ct_api.new { pos = "vsp" }
  end, { desc = "term: new vertial" })
  map({ "n", "t" }, "<A-v>", function()
    ct_api.toggle { pos = "vsp", id = "vtoggleTerm" }
  end, { desc = "term: toggle vertical" })
  map({ "n", "t" }, "<A-b>", function()
    ct_api.toggle { pos = "sp", id = "htoggleTerm" }
  end, { desc = "term: toggle horizontal" })
  map({ "n", "t" }, "<A-i>", function()
    ct_api.toggle { pos = "float", id = "floatTerm" }
  end, { desc = "term: toggle float" })
end

-- whichkey
M.whichkey = function()
  map("n", "<leader>wk", function()
    vim.cmd("Whichkey " .. vim.fn.input "WhichKey: ")
  end, { desc = "whichkey: query lookup" })
  map("n", "<leader>wK", "<cmd>WhichKey <cr>", { desc = "whichkey: all keymaps" })
end

-- blankline
M.blankline = function(ibl_api)
  map("n", "<leader>cc", function()
    local config = { scope = {} }
    config.scope.exclude = { language = {}, node_type = {} }
    config.scope.include = { node_type = {} }
    local node = ibl_api.get(vim.api.nvim_get_current_buf(), config)

    if node then
      local start_row, _, end_row, _ = node:range()
      if start_row ~= end_row then
        vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start_row + 1, 0 })
        vim.api.nvim_feedkeys("_", "n", true)
      end
    end
  end, { desc = "blankline: jump to current context" })
end

-- gitsigns
M.gitsigns_attach = function(gs_api, bufnr)
  map("n", "<leader>rh", gs_api.reset_hunk, { desc = "git: Hunk Reset", buffer = bufnr })
  map("n", "<leader>ph", gs_api.preview_hunk, { desc = "git: Hunk Preview", buffer = bufnr })
  map("n", "<leader>gb", gs_api.blame_line, { desc = "git: Blame Line", buffer = bufnr })
end

-- cmp
M.cmp = function(cmp_api)
  return {
    ["<C-p>"] = cmp_api.mapping.select_prev_item(),
    ["<C-n>"] = cmp_api.mapping.select_next_item(),
    ["<C-d>"] = cmp_api.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp_api.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp_api.mapping.complete(),
    ["<C-e>"] = cmp_api.mapping.close(),
    ["<C-l>"] = cmp_api.mapping.confirm {
      behavior = cmp_api.ConfirmBehavior.Insert,
      select = true,
    },
    ["<Tab>"] = cmp_api.mapping(function(fallback)
      if cmp_api.visible() then
        cmp_api.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp_api.mapping(function(fallback)
      if cmp_api.visible() then
        cmp_api.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<CR>"] = cmp_api.mapping.confirm({select = false})
  }
end

return M
