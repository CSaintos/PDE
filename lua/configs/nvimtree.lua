dofile(vim.g.base46_cache .. "nvimtree")

local options = {
  filters = {
    dotfiles = false,
  },
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  view = {
    adaptive_size = false,
    side = "left",
    width = 30,
    preserve_window_proportions = true,
  },
  git = {
    enable = true,
    ignore = true,
  },
  filesystem_watchers = {
    enable = true,
  },
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  renderer = {
    root_folder_label = function(_)
      return "Help: g?"
    end,
    highlight_git = true,
    highlight_opened_files = "none",
    indent_markers = {
      enable = true,
    },
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = false,
        git = true,
      },
      glyphs = {
        default = "󰈚",
        symlink = "",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
          symlink_open = "",
          arrow_open = "",
          arrow_closed = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
}
local nt_api_s, nt_api = pcall(require, "nvim-tree.api")
if not nt_api_s then
  return
end

local function my_on_attach(bufnr)
  nt_api.config.mappings.default_on_attach(bufnr)
  require("mappings").nvimtree_attach(nt_api, bufnr)
end

options.actions.open_file = {
  resize_window = true,
  window_picker = {
    enable = false,
  },
}

options.on_attach = my_on_attach

return options
