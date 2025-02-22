return {
  -- lua-neovim modules
  {
    "nvim-lua/plenary.nvim",
  },
  -- plugin disabler for large files
  {
    "LunarVim/bigfile.nvim",
    lazy = false,
  },
  -- file manager
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    init = function()
      vim.schedule(require("mappings").nvimtree)
    end,
    opts = function()
      return require "configs.nvimtree"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "nvimtree")
      require("nvim-tree").setup(opts)
    end,
  },
  -- file manager icons
  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      return { override = require "nvchad.icons.devicons" }
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "devicons")
      require("nvim-web-devicons").setup(opts)
    end,
  },
  -- shortcuts helper ui
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    init = function()
      vim.schedule(require("mappings").whichkey)
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "whichkey")
      require("which-key").setup(opts)
    end,
  },
  -- fuzzy file finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    init = function()
      vim.schedule(require("mappings").telescope)
    end,
    opts = function()
      return require "configs.telescope"
    end,
    config = function(_, opts)
      local telescope = require "telescope"
      telescope.setup(opts)

      -- load extensions
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
    end,
  },
  -- highlighter for other uses of a word
  {
    "RRethy/vim-illuminate",
    lazy = false,
  },
  -- git ui indicators
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      return require "configs.gitsigns"
    end,
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end,
  },
  -- Indentation guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    opts = {
      indent = { char = "│", highlight = "IblChar" },
      scope = { char = "│", highlight = "IblScopeChar" },
    },
    init = function()
      vim.schedule(function()
        local ibl_api = require "ibl.scope"
        require("mappings").blankline(ibl_api)
      end)
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "blankline")

      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      require("ibl").setup(opts)
      require "configs.indent-blankline"

      dofile(vim.g.base46_cache .. "blankline")
    end,
  },
  {
    "NvChad/base46",
    branch = "v2.5",
    build = function()
      require("base46").load_all_highlights()
    end,
  },
  {
    "NvChad/ui",
    branch = "v2.5",
    lazy = false,
    init = function()
      vim.schedule(function()
        local tfl_api = require "nvchad.tabufline"
        require("mappings").Tabufline(tfl_api)
        require("mappings").NvCheatsheet()
        local ct_api = require "nvchad.term"
        require("mappings").chadterm(ct_api)
      end)
    end,
    config = function()
      require "nvchad"
    end,
  },
  -- RGB hexcode coloring
  {
    "norcalli/nvim-colorizer.lua",
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "User FilePost",
    opts = { user_default_options = { names = false } },
    config = function(_, opts)
      require("colorizer").setup(opts)
      -- execute colorizer asap
      vim.defer_fn(function()
        require("colorizer").attach_to_buffer(0)
      end, 0)
    end,
  },
  -- REPL for markdown in browser
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function(plugin)
      if vim.fn.executable "npx" then
        vim.cmd("!cd" .. plugin.dir .. " && cd app && npx --yes yarn install")
      else
        vim.cmd [[Lazy load markdown-preview.nvim]]
        vim.fn["mkdp#util#install"]()
      end
    end,
    init = function()
      vim.schedule(require("mappings").mkpv)
      if vim.fn.executable "npx" then
        vim.g.mkdp_filetypes = { "markdown" }
      end
    end,
    config = function()
      require "configs.markdown-preview"
    end,
  },
  -- code formatter
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
    },
    init = function()
      vim.schedule(function()
        local c_api = require "conform"
        require("mappings").Conform(c_api)
      end)
    end,
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function(_, opts)
      local options = require("utils").concat_kv_tables(opts, require "configs.conform")
      require("conform").setup(options)
    end,
  },
  -- language parsers (typically used for syntax highlighting)
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require "configs.treesitter"
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  -- code completions
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- code snippets
      {
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged, TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require "configs.luasnip"
          require "snippets"
        end,
      },
      -- autopairing of (){}[]<>
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },
      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    opts = function()
      return require "configs.cmp"
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },
  -- lsp servers package manager
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    opts = function()
      return require "configs.mason"
    end,
    config = function(_, opts)
      require("mason").setup(opts)

      vim.api.nvim_create_user_command("MasonInstallAll", function()
        require("nvchad.mason").install_all(opts.ensure_installed)
      end, {})
    end,
  },
  -- lsp servers additional configs
  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    config = function()
      require("configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  -- code linter ui for errors and warnings - etc.
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require "configs.lint"
    end,
  },
  -- java plugin
  {
    "nvim-java/nvim-java",
    dependencies = {
      "nvim-java/lua-async-await",
      "nvim-java/nvim-java-refactor",
      "nvim-java/nvim-java-core",
      "nvim-java/nvim-java-test",
      "nvim-java/nvim-java-dap",
      "MunifTanjim/nui.nvim",
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      {
        "williamboman/mason.nvim",
        opts = {
          registries = {
            "github:nvim-java/mason-registry",
            "github:mason-org/mason-registry",
          },
        },
      },
    },
    config = function()
      require("java").setup()
    end,
  },
  -- latex plugin
  {
    "lervag/vimtex",
    lazy = false, -- vimtex is already lazy loaded by default
    init = function()
      require "configs.vimtex"
      vim.schedule(require("mappings").vimtex)
    end,
  },
  -- debug adapter server manager
  {
    "mfussenegger/nvim-dap",
    config = function()
      -- require "configs.dap"
      -- require("core.utils").load_mappings("dap")
    end,
  },
  -- debugger ui
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
    enabled = false,
  },
}
