-- Neovim autopairs
local ap_setup, ap = pcall(require, "nvim-autopairs")
if not ap_setup then
  return
end

local cmp_ap_setup, cmp_ap = pcall(require, "nvim-autopairs.completion.cmp")
if not cmp_ap_setup then
  return
end

local cmp_setup, cmp = pcall(require, "cmp")
if not cmp_setup then
  return
end

ap.setup({
  check_ts = true, -- enable treesitter
  ts_config = {
    lua = { "string" }, -- don't add pairs in lua string treesitter nodes
    javascript = { "template_string" }, -- don't add pairs in js template_string treesitter nodes
    java = false, -- don't check treesitter on java
  },
})

-- make autopairs and completion work together
cmp.event:on("confirm_done", cmp_ap.on_confirm_done())
