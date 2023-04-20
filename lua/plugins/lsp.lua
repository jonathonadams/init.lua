return {
    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        event = "BufRead",
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

            -- Copilot
            { 'zbirenbaum/copilot-cmp' }, -- Optional

            -- Codicons
            { 'onsails/lspkind-nvim' }, -- Optional

        },
        config = function()
            local lsp = require('lsp-zero').preset({
                name = 'recommended',
                manage_nvim_cmp = {
                    set_sources = false
                }
            })


            lsp.ensure_installed({
                'lua_ls',
                'eslint',
                'tsserver',
                'rust_analyzer',
                'pyright',
                'svelte'
            })


            lsp.on_attach(function(client, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
            end)

            lsp.set_sign_icons({
                error = '✘',
                warn = '▲',
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
                    -- prettier
                    ['null-ls'] = { 'javascript', 'typescript', 'svelte', 'html', 'css', 'json', 'yaml', 'scss' },
                    ['pyright'] = { 'python' },
                }
            })

            local lspconfig = require('lspconfig')

            -- (Optional) Configure lua language server for neovim
            lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

            lsp.setup()

            local cmp = require('cmp')
            local lspkind = require('lspkind')

            cmp.setup({
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                sources = {
                    { name = "copilot" },
                    { name = 'path' },
                    { name = 'nvim_lsp' },
                    { name = 'buffer',  keyword_length = 3 },
                    -- { name = 'luasnip', keyword_length = 2 },
                },
                mapping = {
                    -- `Enter` key to confirm completion
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    -- Ctrl+Space to trigger completion menu
                    ['<C-Space>'] = cmp.mapping.complete(),
                },
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol_text",
                        menu = ({
                            buffer = "[Buffer]",
                            nvim_lsp = "[LSP]",
                            luasnip = "[LuaSnip]",
                            path  = "[Path]",
                            copilot = "[Copilot]",
                        }),
                        maxwidth = 80,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                        ellipsis_char = '...', --
                        symbol_map = { Copilot = "" }
                    })
                }
            })

            local null_ls = require('null-ls')

            null_ls.setup({
                sources = {
                    null_ls.builtins.diagnostics.eslint,
                    null_ls.builtins.formatting.prettier.with({
                        only_local = "node_modules/.bin",
                        extra_filetypes = { "svelte" }
                    })
                }
            })
        end
    }
}
