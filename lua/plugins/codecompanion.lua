-- return {}

return {
  "olimorris/codecompanion.nvim",
  event = 'VeryLazy',
  --    keys = {
  --      {
  --        -- Customize or remove this keymap to your liking
  --        "<leader>f",
  --        function()
  --          require("conform").format({ async = true })
  --          if not err then
  --            local mode = vim.api.nvim_get_mode().mode
  --            if vim.startswith(string.lower(mode), "v") then
  --              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
  --            end
  --          end
  --        end,
  --        mode = "",
  --        desc = "Format buffer",
  --      },
  --    },
  opts = {},
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      opts = {
        send_code = false,
      },
      strategies = {
        chat = {
          adapter = "anthropic",
        },
        inline = {
          adapter = "anthropic",
        },
      },
      display = {
        chat = {
          window = {
            position = 'right',
            width = 0.45,
          }
        }
      }
    })
  end
}
