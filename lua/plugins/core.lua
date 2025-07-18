return {
  {
    "vhyrro/luarocks.nvim", -- Lua package manager
    lazy = false,
    priority = 1000,        -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    config = true,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,   -- make sure we load this during startup if it is your main colorscheme
    priority = 999, -- make sure to load this before all the other start plugins
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        integrations = {
          harpoon = true,
          mason = true,
          telescope = true,
          neotree = true,
          treesitter = true,
          lsp_trouble = true,
          -- blink_cmp = {
          --   style = 'bordered',
          -- },
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
        }
      })

      -- load the colorscheme here
      vim.cmd.colorscheme "catppuccin" -- mocha
    end,
  }
}
