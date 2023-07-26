-- Neovim nvim-tree

local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
  return
end

local api_setup, api = pcall(require, "nvim-tree.api")
if not api_setup then
  return
end

-- recommended settings from nvim-tree docs
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

local function my_on_attach(bufnr)
  local function opts(desc)
    return {
      desc = "nvim-tree: " .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true,
    }
  end

  -- set default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Dir"))
  vim.keymap.del("n", "<BS>", {buffer = bufnr})
  vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
end

nvimtree.setup({
  renderer = {
    icons = {
      glyphs = {
        folder = {
          arrow_closed = " ", -- arrow when folder closed
          arrow_open = " ", -- arrow when folder open
        },
      },
    },
  },
  actions = {
    open_file = {
      window_picker = {
        enable = false, -- makes window splits work properly
      },
    },
  },
  on_attach = my_on_attach,
})
