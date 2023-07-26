-- lua_ls
return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          -- make language server aware of runtime files
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config").."/lua"] = true,
        },
      },
    },
  },
}
