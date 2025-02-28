local dap = require("dap")

-- dap.adapter["pwa-node"] = {
--   type = "server",
--   host = "127.0.0.1",
--   port = 8123,
--   executable = {
--     command = "js-debug-adapter",
--   }
-- }

dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
}

local languages = {
  "typescript",
  "javascript"
}

for _, language in ipairs(languages) do
  dap.configurations[language] = {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
    runtimeExecutable = "node",
  }
end

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "gdb",
    request = "launch",
    program = function()
      local path = vim.fn.input({
        prompt = "Path to executable: ",
        -- default = vim.fn.getcwd() .. "/",
        default = "./",
        completion = "file"
      })
      return (path and path ~= "") and path or dap.ABORT
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false
  },
  -- {
  --   name = "Select and attach to process",
  --   type = "gdb",
  --   request = "attach",
  --   program = function()
  --      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
  --   end,
  --   pid = function()
  --      local name = vim.fn.input('Executable name (filter): ')
  --      return require("dap.utils").pick_process({ filter = name })
  --   end,
  --   cwd = '${workspaceFolder}'
  -- },
  -- {
  --   name = 'Attach to gdbserver :1234',
  --   type = 'gdb',
  --   request = 'attach',
  --   target = 'localhost:1234',
  --   program = function()
  --      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
  --   end,
  --   cwd = '${workspaceFolder}'
  -- }
}

vim.fn.sign_define("DapBreakpoint", {text = "", texthl = "DevIconD"})
vim.fn.sign_define("DapStopped", {text = "", texthl = "@ibl.indent.char.2"})
