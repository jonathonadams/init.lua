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

            -- VS Code Icons
            -- {'onsails/lspkind-nvim'},              -- Optional

        },
        config = function()
            local lsp = require('lsp-zero').preset({
                name = 'recommended',
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

            lsp.format_mapping('<leader>f', {
                format_opts = {
                    async = false,
                    timeout_ms = 10000,
                },
                servers = {
                    ['lua_ls'] = { 'lua' },
                    ['rust_analyzer'] = { 'rust' },
                    ['null-ls'] = { 'javascript', 'typescript', 'svelte', 'html', 'css', 'json', 'yaml', 'scss' },
                    ['pyright'] = { 'python' },
                }
            })

            -- (Optional) Configure lua language server for neovim
            require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

            lsp.setup()


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
