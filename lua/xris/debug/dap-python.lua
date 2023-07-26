-- Neovim dap-python
local setup, dap_py = pcall(require, "dap-python")
if not setup then
  print("dap-python not working")
  return
end

path = "C:/Users/xrist/AppData/Local/nvim-data/mason/packages/debugpy/venv/Scripts/python"
dap_py.setup(path)
