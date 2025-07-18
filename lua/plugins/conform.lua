return {
  "stevearc/conform.nvim",
  event = { "VeryLazy" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>f",
      function()
        require("conform").format({ async = true })
        if not err then
          local mode = vim.api.nvim_get_mode().mode
          if vim.startswith(string.lower(mode), "v") then
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
          end
        end
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  opts = {
    --  format_on_save = {
    --    lsp_fallback = true,
    --    timeout_ms = 1000,
    --  },
    -- Set default options
    default_format_opts = {
      lsp_format = "fallback",
      stop_after_first = true
    },
    formatters_by_ft = {
      javascript = { "prettierd", "prettier" },
      typescript = { "prettierd", "prettier" },
      svelte = { "prettierd", "prettier" },
      vue = { "prettierd", "prettier" },
      html = { "prettierd", "prettier" },
      css = { "prettierd", "prettier" },
      json = { "prettierd", "prettier" },
      jsonc = { "prettierd", "prettier" },
      yaml = { "prettierd", "prettier" },
      scss = { "prettierd", "prettier" },
      markdown = { "prettierd", "prettier" },
      python = { "isort", "black" },
      lua = { "stylua" },
      --        go = { "gofumpt" },
      --        rust = { "rustfmt" },

      --        ['lua_ls'] = { 'lua' },
      --        ['rust_analyzer'] = { 'rust' },
      --        ['gopls'] = { 'go' },
    }
  },
}
