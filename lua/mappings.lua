require "nvchad.mappings"
local M = {} -- keymap exports
local map = vim.keymap.set

--> Standard Keymaps
-- Insert Mode Keymaps
map("i", "jk", "<Esc>", { desc = "To Normal Mode" })
map("i", "<C-b>", "<Esc>^i", { desc = "goto beginning of line" })
map("i", "<C-e>", "<End>", { desc = "goto end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })
-- Normal Mode Keymaps
map("n", "<Esc>", "<cmd>noh<cr>", { desc = "clear general highlights" })
map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })
map("n", "<C-s>", "<cmd>w<cr>", { desc = "file save" })
map("n", "<C-c>", "<cmd>%y+<cr>", { desc = "file copy" })
map("n", "<leader>n", "<cmd>set nu!<cr>", { desc = "toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<cr>", { desc = "toggle relative number" })
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "lsp diagnostic loclist" })
map("n", "<leader>/", "gcc", { desc = "comment toggle", remap = true })
map("n", "j", "gj", { desc = "Do not skip over wrap lines (down)" })
map("n", "k", "gk", { desc = "Do not skip over wrap lines (up)" })
map("n", "x", '"_', { desc = "Delete char without saving to clipboard" })
map("n", "<C-a>", "<C-a>", { desc = "Increment digit" })
map("n", "<C-x>", "<C-x>", { desc = "Decrement digit" })
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Make split windows equal width" })
map("n", "<leader>sx", ":close<cr>", { desc = "Close current split window" })
map("n", "<C-Up>", "<cmd>resize -2<cr>", { desc = "Resize window upwards" })
map("n", "<C-Down>", "<cmd>resize +2<cr>", { desc = "Resize window downwards" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Resize window leftwards" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Resize window rightwards" })
map("n", "<leader>to", "<cmd>tabnew<cr>", { desc = "Open new tab" })
map("n", "<leader>tx", "<cmd>tabclose<cr>", { desc = "Close current tab" })
map("n", "<leader>tn", "<cmd>tabn<cr>", { desc = "Goto next tab" })
map("n", "<leader>tp", "<cmd>tabp<cr>", { desc = "Goto previous tab" })
map("n", ";", ":", { desc = "CMD enter command mode" })
-- Visual Mode Keymaps
map("v", "<leader>/", "gc", { desc = "comment toggle", remap = true })
-- Terminal Mode Keymaps
map("t", "<C-x>", "<C-\\><C-N>", { desc = "escape terminal mode", })

-- nvimtree
M.nvimtree_keys = function(nt_api, bufnr)
  map("n", "<C-p>", nt_api.tree.change_root_to_parent, { desc = "Nvimtree cd parent directory", buffer = bufnr })
  map("n", "h", nt_api.node.navigate.parent_close, { desc = "Nvimtree close directory at cursor", buffer = bufnr })
  map("n", "l", nt_api.node.open.edit, { desc = "Nvimtree open at cursor", buffer = bufnr })
  map("n", "<C-n>", "<cmd>NvimTreeToggle<cr>", { desc = "nvimtree toggle window" })
  map("n", "<leader>e", "<cmd>NvimTreeFocus<cr>", { desc = "nvimtree focus window" })
end

-- markdown-preview
M.mkpv_keys = function()
  map("n", "<C-s>", "<cmd>MarkdownPreviewToggle<cr>", { desc = "MarkdownPreviewToggle" })
end

-- vimtex
M.vimtex_keys = function()
  map("n", "<localleader>li", "<plug>(vimtex-info)", { desc = ":VimtexInfo" })
  map("n", "<localleader>ll", "<plug>(vimtex-compile)", { desc = ":VimtexCompile" })
  map("n", "<localleader>lk", "<plug>(vimtex-stop)", { desc = ":VimtexStop" })
  map("n", "<localleader>lc", "<plug>(vimtex-clean)", { desc = ":VimtexClean" })
end

-- lspconfig
M.lspconfig = function(bufnr)
  map("n", "gD", vim.lsp.buf.declaration, { desc = "LSP Go to declaration", buffer = bufnr})
  map("n", "gd", vim.lsp.buf.definition, { desc = "LSP Go to definition", buffer = bufnr})
  map("n", "gi", vim.lsp.buf.implementation, { desc = "LSP Go to implementation", buffer = bufnr})
  map("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "LSP Show signature", buffer = bufnr})
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "LSP Add workspace folder", buffer = bufnr})
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "LSP Remove workspace folder", buffer = bufnr})
  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { desc = "LSP List workspace folder", buffer = bufnr})
  map("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "LSP Go to type definition", buffer = bufnr})
  map("n", "<leader>ra", function()
    require("nvchad.lsp.renamer")()
  end, { desc = "LSP NvRenamer", buffer = bufnr})
  map({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code action", buffer = bufnr})
  map("n", "gr", vim.lsp.buf.references, { desc = "LSP Show references", buffer = bufnr})
end

-- dap 
M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd>DapToggleBreakpoint<cr>",
      "DAP add breakpoint at line"
    },
    ["<leader>dr"] = {
      "<cmd>DapContinue<cr>",
      "DAP run or continue the debugger"
    },
  }
}

-- NvCheatsheet
M.NvCheatsheet = function()
  map("n", "<leader>ch", "<cmd>NvCheatsheet<cr>", { desc = "toggle nvcheatsheet" })
end

-- Conform
M.Conform = function(c_api)
  map("n", "<leader>fm", c_api.format({ lsp_fallback = true }), { desc = "format files"})
end

-- Tabufline
M.Tabufline = function(tl_api)
  map("n", "<leader>b", "<cmd>enew<cr>", { desc = "buffer new" })
  map("n", "<tab>", tl_api.next(), { desc = "goto next buffer" })
  map("n", "<S-tab>", tl_api.prev(), { desc = "goto prev buffer" })
  map("n", "<leader>x", tl_api.close_buffer(), { desc = "close buffer" })
end

-- Telescope
M.telescope = function()
  map("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "telescope live grep" })
  map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "telescope find buffers" })
  map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "telescope help page" })
  map("n", "<leader>ma", "<cmd>Telescope marks<cr>", { desc = "telescope find marks" })
  map("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "telescope find oldfiles" })
  map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "telescope find in current buffer" })
  map("n", "<leader>cm", "<cmd>Telescope git_commits<cr>", { desc = "telescope git commits" })
  map("n", "<leader>gt", "<cmd>Telescope git_status<cr>", { desc = "telescope git status" })
  map("n", "<leader>pt", "<cmd>Telescope terms<cr>", { desc = "telescope pick hidden term" })
  map("n", "<leader>th", "<cmd>Telescope themes<cr>", { desc = "telescope nvchad themes" })
  map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
  map("n", "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>", { desc = "telescope find all files" })
end

-- chadterm
M.chadterm = function(ct_api)
  map("n", "<leader>h", ct_api.new({pos = "sp"}), { desc = "new horizontal term" })
  map("n", "<leader>v", ct_api.new({pos = "vsp"}), { desc = "new vertial term" })
  map({"n", "t"}, "<A-v>", ct_api.toggle({pos = "vsp", id = "vtoggleTerm"}), {desc = "toggle vertical term"})
  map({"n", "t"}, "<A-h>", ct_api.toggle({pos = "sp", id = "htoggleTerm"}), {desc = "toggle horizontal term"})
  map({"n", "t"}, "<A-i>", ct_api.toggle({pos = "float", id = "floatTerm"}), {desc = "toggle float term"})
end

-- whichkey
M.whichkey = function()
  map("n", "<leader>wk", function()
    vim.cmd("Whichkey " .. vim.fn.input("WhichKey: "))
  end, { desc = "whichkey query lookup" })
end

-- blankline
M.blankline = function(ibl_api)
  map("n", "<leader>cc", function()
    local config = { scope = {}}
    config.scope.exclude = { language = {}, node_type = {}}
    config.scope.include = { node_type = {}}
    local node = ibl_api.get(vim.api.nvim_get_current_buf(), config)

    if node then
      local start_row, _, end_row, _ = node:range()
      if start_row ~= end_row then
        vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), {start_row + 1, 0})
        vim.api.nvim_feedkeys("_", "n", true)
      end
    end
  end, { desc = "blankline jump to current context" })
end

-- gitsigns
M.gitsigns = function(gs_api, bufnr)
  map("n", "<leader>rh", gs_api.reset_hunk, { desc = "Reset Hunk", buffer = bufnr })
  map("n", "<leader>ph", gs_api.preview_hunk, { desc = "Preview Hunk", buffer = bufnr })
  map("n", "<leader>gb", gs_api.blame_line, { desc = "Blame Line", buffer = bufnr })
end

return M
