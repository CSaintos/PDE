-- Neovim treesitter
local setup, treesitter = pcall(require, "nvim-treesitter.configs")
if not setup then
  return
end

treesitter.setup({
  highlight = { enable = true },
  indent = { enable = true },
  autotag = { enable = true },
  -- https://github.com/nvim-treesitter/nvim-treesitter
  ensure_installed = {
    "c",
    "c_sharp",
    "cmake",
    "cpp",
    "css",
    "dockerfile",
    "ebnf",
    "git_config",
    "gitattributes",
    "gitignore",
    "glsl",
    "html",
    "java",
    "javascript",
    "json",
    "kotlin",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "objc",
    "python",
    "ruby",
    "sql",
--    "swift",
    "toml",
--    "tree-sitter-query",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
  },
  -- auto install above language parsers
  auto_install = true
})
