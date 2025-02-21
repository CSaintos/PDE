pcall(function()
  dofile(vim.g.base46_cache .. "syntax")
  dofile(vim.g.base46_cache .. "treesitter")
end)

local options = {
  ensure_installed = {
    "lua",
    "luadoc",
    "printf",
    "vim",
    "vimdoc",
    "html",
    "css",
    "c_sharp",
    "vue",
    "javascript",
    "java",
    "groovy",
    "cpp",
  },
  highlight = {
    enable = true,
    use_languagetree = true
  },
  indent = {enable = true }
}

return options
