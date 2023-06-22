return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    tag = "2.43",
    lazy = false,
    priority = 999,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      {
        -- only needed if you want to use the commands with "_with_window_picker" suffix
        's1n7ax/nvim-window-picker',
        version = 'v1.*',
        config = function()
          require 'window-picker'.setup({
            autoselect_one = true,
            include_current = false,
            filter_rules = {
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { 'neo-tree', "neo-tree-popup", "notify" },

                -- if the buffer type is one of following, the window will be ignored
                buftype = { 'terminal', "quickfix" },
              },
            },
            other_win_hl_color = '#e35e4f',
          })
        end,
      }
    },
    config = function()
      -- Unless you are still migrating, remove the deprecated commands from v1.x
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

      require("neo-tree").setup({
        window = {
          position = "current",
          mapping_options = {
            noremap = true,
            nowait = true,
          },
        },
        source_selector = {
          winbar = true,
          statusline = false,
          sources = {
            { source = "filesystem", display_name = " 󰉓 Files " },
            { source = "git_status", display_name = " 󰊢 Git " },
            { source = "buffers",    display_name = " 󰈙 Buffers " }
          },
        },
        filesystem = {
          filtered_items = {
            visible = true, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_by_name = { -- The default includes .DS_Store, su must define it
              --"node_modules"
            },
          },
          follow_current_file = true, -- this will find and focus the file in the active buffer every
          -- time the current file is changed while the tree is open.
          group_empty_dirs = false,

          use_libuv_file_watcher = true, -- this will use the os level file watchers to detect changes
          -- instead of relying on nvim autocmd events.
        },

        default_component_configs = {
          indent = {
            with_markers = false,
          },
          icon = {
            folder_empty = "󰜌",
            folder_empty_open = "󰜌",
          },
          git_status = {
            symbols = {
              renamed  = "󰁕",
              unstaged = "󰄱",
            },
          },
          document_symbols = {
            kinds = {
              File = { icon = "󰈙", hl = "Tag" },
              Namespace = { icon = "󰌗", hl = "Include" },
              Package = { icon = "󰏖", hl = "Label" },
              Class = { icon = "󰌗", hl = "Include" },
              Property = { icon = "󰆧", hl = "@property" },
              Enum = { icon = "󰒻", hl = "@number" },
              Function = { icon = "󰊕", hl = "Function" },
              String = { icon = "󰀬", hl = "String" },
              Number = { icon = "󰎠", hl = "Number" },
              Array = { icon = "󰅪", hl = "Type" },
              Object = { icon = "󰅩", hl = "Type" },
              Key = { icon = "󰌋", hl = "" },
              Struct = { icon = "󰌗", hl = "Type" },
              Operator = { icon = "󰆕", hl = "Operator" },
              TypeParameter = { icon = "󰊄", hl = "Type" },
              StaticMethod = { icon = '󰠄 ', hl = 'Function' },
            }
          },
        },

        buffers = {
          group_empty_dirs = false, -- when true, empty folders will be grouped together
          show_unloaded = true,
        },
      })
    end
  }
}
