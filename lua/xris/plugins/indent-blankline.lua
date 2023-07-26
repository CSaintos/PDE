-- Neovim indent-blankline
local setup, ib = pcall(require, "indent_blankline")
if not setup then
  return
end

local BlanklineColors = {
  {"IndentBlanklineIndent1", "#E06C75"},
  {"IndentBlanklineIndent2", "#E5C07B"},
  {"IndentBlanklineIndent3", "#98C379"},
  {"IndentBlanklineIndent4", "#56B6C2"},
  {"IndentBlanklineIndent5", "#61AFEF"},
  {"IndentBlanklineIndent6", "#C678DD"}
}

for _, color in ipairs(BlanklineColors) do
  vim.cmd("highlight " .. color[1] .. " guifg=" .. color[2] .. " gui=nocombine")
end

ib.setup({
  char_highlight_list = {
    "IndentBlankLineIndent1",
    "IndentBlankLineIndent2",
    "IndentBlankLineIndent3",
    "IndentBlankLineIndent4",
    "IndentBlankLineIndent5",
    "IndentBlankLineIndent6",
  }
})
