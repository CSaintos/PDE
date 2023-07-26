-- Neovim bufferline
local setup, bl = pcall(require, "bufferline")
local c_setup, blc = pcall(require, "bufferline.config")
if not (setup and c_setup) then
  return
end

bl.setup({
  options = {
    mode = "buffers",
    style_preset = bl.style_preset.default,
    themable = true,
    indicator = {
      style = "underline"
    },
    separator_style = "slope",
    hover = {
      enabled = true,
      delay = 200, --ms
      reveal = {"close"}
    },
  }
})

vim.g.transparent_groups = vim.list_extend(
  vim.g.transparent_groups or {},
  vim.tbl_map(function(v)
    return v.hl_group
  end,
  vim.tbl_values(blc.highlights)
  )
)
