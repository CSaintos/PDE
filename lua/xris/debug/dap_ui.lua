-- Neovim Dap
local ui_setup, dap_ui = pcall(require, "dapui")
if not ui_setup then
  print("dapui not working")
  return
end


dap_ui.config = function()
  dap_ui.setup()
  dap_ui.listeners.after.event_initialized["dapui_config"] = function()
    dap_ui.open()
  end
  dap_ui.listeners.before.event_termindated["dapui_config"] = function()
    dap_ui.close()
  end
  dap_ui.listeners.before.event_exited["dapui_config"] = function()
    dap_ui.close()
  end
end
