return {
  {
    'nvim-neorg/neorg',
    lazy = true,
    version = "*", -- Pin Neorg to the latest stable release
    dependencies = {
      "luarocks.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neorg/neorg-telescope"
    },
    config = function()
      local neorg = require('neorg')
      neorg.setup {
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/notes",
              },
              default_workspace = "notes",
            },
          },
        },
      }
    end
  },
}
