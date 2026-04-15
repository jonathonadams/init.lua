return {
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    vim.diagnostic.config({
      virtual_text = {
        spacing = 0,
        source = true,
        prefix = "",
      },
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "󰅚 ",
          [vim.diagnostic.severity.WARN] = "󰀪 ",
          [vim.diagnostic.severity.INFO] = "󰋽 ",
          [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
        numhl = {
          [vim.diagnostic.severity.ERROR] = "ErrorMsg",
          [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
      },
    })

    require('mason').setup({})
    require('mason-lspconfig').setup({
      ensure_installed = {
        'lua_ls',
        'eslint',
        'ts_ls',
        'pyright',
        'ruff',
        'svelte',
        'tailwindcss',
        'vue_ls',
        -- 'gopls',
        -- 'rust_analyzer',
      },
    })

    vim.lsp.enable({
      'lua_ls',
      'eslint',
      'ts_ls',
      'pyright',
      'ruff',
      'svelte',
      'tailwindcss',
    })

    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          diagnostics = { globals = { 'vim' } },
        },
      },
    })

    local utils = require('utils')

    vim.lsp.config('pyright', {
      settings = {
        python = {
          analysis = { diagnosticMode = "off", typeCheckingMode = "off" },
        },
      },
      before_init = function(_, config)
        config.settings.python.pythonPath = utils.get_python_path(config.root_dir)
      end
    })
  end
}
