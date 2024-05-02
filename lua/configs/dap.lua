local dap = require("dap")

dap.adapter["pwa-node"] = {
  type = "server",
  host = "127.0.0.1",
  port = 8123,
  executable = {
    command = "js-debug-adapter",
  }
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
