-- defaults
-- This file is not an included configuration, but rather a condensed example of lspconfig.txt (:h lspconfig-setup) options
-- All lsps will have these options; however, each individual lsp will have additional exclusive options.
return {
  -- default additionals
  root_dir = function(filename, bufnr)
    return "filepath"
  end,
  name = "default",
  filetypes = {},
  autostart = true,
  single_file_support = nil,
  on_new_config = function(new_config, new_root_dir)
  end,
  -- default overrides
  capabilities = {},
  cmd = {
    "foo",
    "--bar",
    "baz"
  },
  handlers = {},
  init_options = {},
  on_attach = function(client, bufnr)
  end,
  settings = {},
}
