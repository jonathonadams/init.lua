return {
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    { "L3MON4D3/LuaSnip", keys = {} },
    --  {
    --    "saghen/blink.cmp",
    --    version = '1.*',
    --    dependencies = {
    --      "rafamadriz/friendly-snippets",
    --    },
    --  },
  },
  config = function()
    require('mason').setup({})
    require('mason-lspconfig').setup({
      ensure_installed = {
        'lua_ls',
        'eslint',
        'ts_ls',
        'rust_analyzer',
        'pyright',
        'ruff',
        'gopls',
        'svelte',
        'tailwindcss'
      },
    })

    vim.lsp.enable({
      "lua_ls",
      'eslint',
      'ts_ls',
      'rust_analyzer',
      'pyright',
      'ruff',
      'gopls',
      'svelte',
      'tailwindcss'
    })


    --    local blink = require("blink.cmp")
    --    blink.setup({})


    -- Uncomment the below if not using lsp-config

    --  local local_capabilities = {
    --    textDocument = {
    --      foldingRange = {
    --        dynamicRegistration = false,
    --        lineFoldingOnly = true
    --      },
    --      publishDiagnostics = {
    --        tagSupport = {
    --          valueSet = { 2 }
    --        }
    --      }
    --    }
    --  }


    --  -- See https://github.com/neovim/nvim-lspconfig/issues/726
    --  local capabilities = vim.tbl_deep_extend(
    --    "force",
    --    {},
    --    vim.lsp.protocol.make_client_capabilities(),
    --    blink.get_lsp_capabilities()
    --  )
    --
    --      capabilities.textDocument.foldingRange.dynamicRegistration = false
    --      capabilities.textDocument.foldingRange.lineFoldingOnly =true
    --
    --      capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }

    --  vim.lsp.config(
    --    "*",
    --    {
    --      capabilities = capabilities,
    --      root_markers = ".git"
    --    }
    --  )
  end
}
--return {
--  {
--    "neovim/nvim-lspconfig",
--    event = "VeryLazy",
--    dependencies = {
--      "williamboman/mason.nvim",
--      "williamboman/mason-lspconfig.nvim",
--      "hrsh7th/cmp-nvim-lsp",
--      "hrsh7th/cmp-buffer",
--      "hrsh7th/cmp-path",
--      "hrsh7th/cmp-cmdline",
--      "hrsh7th/nvim-cmp",
--      "L3MON4D3/LuaSnip",
--      "saadparwaiz1/cmp_luasnip",
--      --     "j-hui/fidget.nvim",
--    },
--    config = function()
--      vim.diagnostic.config({
--        virtual_text = {
--          spacing = 0,
--          source = true,
--          prefix = "",
--        },
--      })



--      local cmp = require('cmp')
--      local cmp_lsp = require("cmp_nvim_lsp")

--      -- See https://github.com/neovim/nvim-lspconfig/issues/726
--      local capabilities = vim.tbl_deep_extend(
--        "force",
--        {},
--        vim.lsp.protocol.make_client_capabilities(),
--        cmp_lsp.default_capabilities()
--      )


--      capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }


--      require('mason').setup({})
--      require('mason-lspconfig').setup({
--        ensure_installed = {
--          'lua_ls',
--          'eslint',
--          'ts_ls',
--          'rust_analyzer',
--          'pyright',
--          'ruff',
--          'gopls',
--          'svelte',
--          'tailwindcss'
--        },
--        handlers = {
--          function(server_name)   -- default handler (optional)
--            require("lspconfig")[server_name].setup {
--              capabilities = capabilities
--            }
--          end,
--        },
--      })

--      vim.lsp.config('gopls', {
--        settings = {
--          gopls = {
--            hints = {
--              assignVariableTypes = true,
--              compositeLiteralFields = true,
--              compositeLiteralTypes = true,
--              constantValues = true,
--              functionTypeParameters = true,
--              parameterNames = true,
--              rangeVariableTypes = true,
--            },
--          },
--        }
--      })


--      local utils = require('utils')

--      vim.lsp.config('pyright', {
--        capabilities = capabilities,
--        settings = {
--          python = {
--            analysis = { diagnosticMode = "off", typeCheckingMode = "off" },
--          },
--        },
--        before_init = function(_, config)
--          config.settings.python.pythonPath = utils.get_python_path(config.root_dir)
--        end
--      })

--      -- These require the vs code codicons `https://microsoft.github.io/vscode-codicons`
--      -- The trailisng space is required for formatting
--      local cmp_kinds = {
--        Text = ' ',
--        Method = ' ',
--        Function = ' ',
--        Constructor = ' ',
--        Field = ' ',
--        Variable = ' ',
--        Class = ' ',
--        Interface = ' ',
--        Module = ' ',
--        Property = ' ',
--        Unit = ' ',
--        Value = ' ',
--        Enum = ' ',
--        Keyword = ' ',
--        Snippet = ' ',
--        Color = ' ',
--        File = ' ',
--        Reference = ' ',
--        Folder = ' ',
--        EnumMember = ' ',
--        Constant = ' ',
--        Struct = ' ',
--        Event = ' ',
--        Operator = ' ',
--        TypeParameter = ' ',
--        Copilot = ' ',
--      }

--      cmp.setup({
--        snippet = {
--          expand = function(args)
--            -- You need Neovim v0.10 to use vim.snippet
--            vim.snippet.expand(args.body)
--          end,
--        },
--        window = {
--          completion = cmp.config.window.bordered(),
--          documentation = cmp.config.window.bordered(),
--        },
--        mapping = cmp.mapping.preset.insert({
--          -- scroll up and down the documentation window
--          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
--          ['<C-d>'] = cmp.mapping.scroll_docs(4),
--          -- `Enter` key to confirm completion
--          ['<CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
--          -- Ctrl+Space to trigger completion menu
--          ['<C-Space>'] = cmp.mapping.complete(),
--          ["<Tab>"] = vim.schedule_wrap(function(fallback)
--            if cmp.visible() and utils.has_words_before() then
--              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
--            else
--              fallback()
--            end
--          end),
--        }),
--        formatting = {
--          fields = { "kind", "abbr", "menu" },
--          -- vim_item : see `h complete-items'
--          format = function(entry, vim_item)
--            vim_item.kind = cmp_kinds[vim_item.kind] or ''

--            -- Import Path
--            if entry.completion_item.detail ~= nil and entry.completion_item.detail ~= "" then
--              vim_item.menu = entry.completion_item.detail
--            else
--              -- Source
--              vim_item.menu = ({
--                buffer   = "[Buffer]",
--                nvim_lsp = "[LSP]",
--                luasnip  = "[LuaSnip]",
--                path     = "[Path]",
--                copilot  = "[Copilot]",
--              })[entry.source.name]
--            end

--            return vim_item
--          end,
--        },
--      })
--    end
--  },
--}
