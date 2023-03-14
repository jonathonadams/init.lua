return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    event = "VeryLazy",
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {'williamboman/mason.nvim'},           -- Optional
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},                  -- Required
      {'hrsh7th/cmp-nvim-lsp'},              -- Required
      {'L3MON4D3/LuaSnip'},                  -- Required
    },
    config = function()
      local lsp = require('lsp-zero')

      lsp.esnsure_instsalled({
        'pyright',
        'eslint',
        'rust_analyzer',
        'tsserver',
      })

      lsp.preset({})
      
      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({buffer = bufnr})
      end)
      
      -- (Optional) Configure lua language server for neovim
      require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
      
      lsp.setup()
    end
  }
}
