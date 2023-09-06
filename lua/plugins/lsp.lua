return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    event = "VeryLazy",
    cmd = { "Mason" },
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {
        -- Optional
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'L3MON4D3/LuaSnip' },     -- Required
    },
    config = function()
      vim.diagnostic.config({
        virtual_text = {
          spacing = 0,
          source = "always",
          prefix = "",
        },
      })


      local lsp = require('lsp-zero').preset({
        name = 'recommended',
        configure_diagnostics = false,
        manage_nvim_cmp = {
          set_sources = true
        }
      })

      lsp.ensure_installed({
        'lua_ls',
        'eslint',
        'tsserver',
        'rust_analyzer',
        'pyright',
        'ruff_lsp',
        'svelte',
        'gopls'
      })

      lsp.on_attach(function(_, bufnr)
        lsp.default_keymaps({ buffer = bufnr })
      end)

      lsp.set_sign_icons({
        error = '✘',
        warn = '',
        hint = '⚑',
        info = '»'
      })

      lsp.format_mapping('<leader>f', {
        format_opts = {
          async = false,
          timeout_ms = 10000,
        },
        servers = {
          ['lua_ls'] = { 'lua' },
          ['rust_analyzer'] = { 'rust' },
          ['gopls'] = { 'go' },
          ['null-ls'] = {
            -- prettier
            'javascript',
            'typescript',
            'svelte',
            'html',
            'css',
            'json',
            'yaml',
            'scss',
            -- Black
            'python'
          },
        }
      })

      local lspconfig = require('lspconfig')
      local utils = require('utils')

      lspconfig.tsserver.setup({
        single_file_support = false,
      })

      lspconfig.eslint.setup({
        single_file_support = false,
      })

      lspconfig.gopls.setup({
        settings = {
          gopls = {
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        }
      })

      -- See https://github.com/neovim/nvim-lspconfig/issues/726
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }

      lspconfig.pyright.setup({
        capabilities = capabilities,
        settings = {
          python = {
            analysis = { diagnosticMode = "off", typeCheckingMode = "off" },
          },
        },
        before_init = function(_, config)
          config.settings.python.pythonPath = utils.get_python_path(config.root_dir)
        end
      })

      -- (Optional) Configure lua language server for neovim
      lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

      lsp.setup()

      local cmp = require('cmp')

      -- These require the vs code codicons `https://microsoft.github.io/vscode-codicons`
      -- The trailisng space is required for formatting

      local cmp_kinds = {
        Text = ' ',
        Method = ' ',
        Function = ' ',
        Constructor = ' ',
        Field = ' ',
        Variable = ' ',
        Class = ' ',
        Interface = ' ',
        Module = ' ',
        Property = ' ',
        Unit = ' ',
        Value = ' ',
        Enum = ' ',
        Keyword = ' ',
        Snippet = ' ',
        Color = ' ',
        File = ' ',
        Reference = ' ',
        Folder = ' ',
        EnumMember = ' ',
        Constant = ' ',
        Struct = ' ',
        Event = ' ',
        Operator = ' ',
        TypeParameter = ' ',
        Copilot = ' ',
      }


      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = {
          -- `Enter` key to confirm completion
          ['<CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
          -- Ctrl+Space to trigger completion menu
          ['<C-Space>'] = cmp.mapping.complete(),
          ["<Tab>"] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and utils.has_words_before() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
              fallback()
            end
          end),
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          -- vim_item : see `h complete-items'
          format = function(entry, vim_item)
            vim_item.kind = cmp_kinds[vim_item.kind] or ''

            -- Import Path
            if entry.completion_item.detail ~= nil and entry.completion_item.detail ~= "" then
              vim_item.menu = entry.completion_item.detail
            else
              -- Source
              vim_item.menu = ({
                buffer   = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip  = "[LuaSnip]",
                path     = "[Path]",
                copilot  = "[Copilot]",
              })[entry.source.name]
            end

            return vim_item
          end,
        },
        -- sorting = {
        --   priority_weight = 2,
        -- },
      })

      local null_ls = require('null-ls')

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier.with({
            only_local = "node_modules/.bin",
            extra_filetypes = { "svelte" }
          }),
          null_ls.builtins.formatting.black.with({
            only_local = ".venv/bin",
          }),
        }
      })
    end
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    'lvimuser/lsp-inlayhints.nvim',
    ft = { 'rust', 'go' },
    config = function()
      local ih = require("lsp-inlayhints")
      ih.setup()

      vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
      vim.api.nvim_create_autocmd("LspAttach", {
        group = "LspAttach_inlayhints",
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end

          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          ih.on_attach(client, bufnr)
        end,
      })
    end
  }
}
