return {
  {
    'folke/zen-mode.nvim',
    keys = {
      { '<leader>zz'},
    },
    config = function()  
      local zen = require("zen-mode")
      zen.setup {
        window = {
            heigth = 60,
            width = 90,
            --options = {
            --    number = true,
            --    relativenumber = true,
            --}
        },
        plugins = {
          tmux = { enabled = true },
          kitty = {
            enabled = true,
            font = "+0",  
          },
        },
        on_open = function(win)
          vim.fn.system({
            "yabai",
            "-m",
            "window",
            "--toggle",
            "native-fullscreen",
          })
        end,
        on_close = function()
          vim.fn.system({
            "yabai",
            "-m",
            "window",
            "--toggle",
            "native-fullscreen",
          })
        end,
      }

      vim.keymap.set("n", "<leader>zz", zen.toggle)
    end,
  },
  { 
    "folke/twilight.nvim",
    keys = {
      { '<leader>zz'},
    },
    config = function()
      require("twilight").setup {
        -- amount of lines we will try to show around the current line
        context = 15,
      }
    end
  } 
}