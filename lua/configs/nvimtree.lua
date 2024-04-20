local options = require("nvchad.configs.nvimtree")
local nt_api_s, nt_api = pcall(require, "nvim-tree.api")
if not nt_api_s then
  return
end

local function my_on_attach(bufnr)
  nt_api.config.mappings.default_on_attach(bufnr)
  require("mappings").nvimtree_keys(nt_api, bufnr)
end

options.actions.open_file = {
  resize_window = true,
  window_picker = {
    enable = false
  }
}

options.on_attach = my_on_attach


return options
