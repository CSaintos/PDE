require "nvchad.mappings"

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
map("n", "<C-t>", function()
  require("nvim-tree.api").tree.change_root_to_parent()
end, { desc = "Nvimtree Set directory at cursor as root" })
map("n", "h", function()
  require("nvim-tree.api").node.navigate.parent_close()
end, { desc = "Nvimtree close directory at cursor" })
map("n", "l", function()
  require("nvim-tree.api").node.open.edit()
end, { desc = "Nvimtree open at cursor" })

