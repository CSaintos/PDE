require "nvchad.mappings"
local M = {} -- keymap exports
local map = vim.keymap.set

--> Standard Keymaps
-- Insert Mode Keymaps
map("i", "jk", "<ESC>")
-- Normal Mode Keymap
map("n", "j", "gj", { desc = "Do not skip over wrap lines (down)" })
map("n", "k", "gk", { desc = "Do not skip over wrap lines (up)" })
map("n", "x", '"_', { desc = "Delete char without saving to clipboard" })
map("n", "<C-a>", "<C-a>", { desc = "Increment digit" })
map("n", "<C-x>", "<C-x>", { desc = "Decrement digit" })
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Make split windows equal width" })
map("n", "<leader>sx", ":close<CR>", { desc = "Close current split window" })
map("n", "<C-Up>", "<cmd>resize -2<CR>", { desc = "Resize window upwards" })
map("n", "<C-Down>", "<cmd>resize +2<CR>", { desc = "Resize window downwards" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Resize window leftwards" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Resize window rightwards" })
map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
map("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Goto next tab" })
map("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Goto previous tab" })
map("n", ";", ":", { desc = "CMD enter command mode" })

-- nvimtree
M.nvimtree_keys = function(nt_api, bufnr)
  map("n", "<C-p>", nt_api.tree.change_root_to_parent, { desc = "Nvimtree cd parent directory", buffer = bufnr})
  map("n", "h", nt_api.node.navigate.parent_close, { desc = "Nvimtree close directory at cursor", buffer = bufnr})
  map("n", "l", nt_api.node.open.edit, { desc = "Nvimtree open at cursor", buffer = bufnr})
end

-- markdown-preview
M.mkpv_keys = function()
  map("n", "<C-s>", "<cmd>MarkdownPreviewToggle<CR>", { desc = "MarkdownPreviewToggle" })
end

-- vimtex
M.vimtex_keys = function()
  map("n", "<localleader>li", "<plug>(vimtex-info)", { desc = ":VimtexInfo" })
  map("n", "<localleader>ll", "<plug>(vimtex-compile)", { desc = ":VimtexCompile" })
  map("n", "<localleader>lk", "<plug>(vimtex-stop)", { desc = ":VimtexStop" })
  map("n", "<localleader>lc", "<plug>(vimtex-clean)", { desc = ":VimtexClean" })
end

-- dap 
M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd>DapToggleBreakpoint <CR>",
      "DAP add breakpoint at line"
    },
    ["<leader>dr"] = {
      "<cmd>DapContinue<CR>",
      "DAP run or continue the debugger"
    },
  }
}

return M
