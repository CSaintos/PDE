-- Neovim telescope

local t_setup, telescope = pcall(require, "telescope")
if not t_setup then
  return
end

local themes_setup, themes = pcall(require, "telescope.themes")
if not themes_setup then
  return
end

local telescope_keys = require("xris.core.keymaps").TelKey

telescope.setup({
  defaults = {
    mappings = {
      i = telescope_keys -- insert key maps
    },
  },
  extensions = {
    ["ui-select"] = {
      themes.get_dropdown({})
    }, 
  },
})

telescope.load_extension("fzf")
telescope.load_extension("ui-select")
