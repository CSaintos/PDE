local autocmd = vim.api.nvim_create_autocmd

-- Display Nvdash when all buffers are deleted
autocmd("BufDelete", {
  callback = function()
    local bufs = vim.t.bufs
    if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
      vim.cmd("Nvdash")
    end
  end
})

-- Event which loads on UIEnter on a file buf
autocmd({"UIEnter", "BufReadPost", "BufNewFile"}, {
  group = vim.api.nvim_create_augroup("NvFilePost", {clear = true}),
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    local buftype = vim.api.nvim_get_option_value("buftype", {buf = args.buf})
    if not vim.g.ui_entered and args.event == "UIEnter" then
      vim.g.ui_entered = true
    end

    if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
      vim.api.nvim_exec_autocmds("User", {pattern="FilePost", modeline = false})
      vim.api.nvim_del_augroup_by_name("NvFilePost")

      vim.schedule(function()
        vim.api.nvim_exec_autocmds("Filetype", {})

        if vim.g.editorconfig then
          require("editorconfig").config(args.buf)
        end
      end)
    end
  end
})
