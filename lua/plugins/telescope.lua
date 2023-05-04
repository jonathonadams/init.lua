return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzf-native.nvim',
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons'
        },
        keys = {
            { "<leader>pf" },
            { "<leader>pb" },
            { "<C-p>" },
            { "<leader>pg" },
            { "<leader>ps" },
            { "<leader>gc" },
        },
        config = function()
            local telescope = require('telescope')

            telescope.setup({
                defaults = {
                    -- layout_strategy = 'horizontal',
                    layout_config = {
                        horizontal = {
                            -- height = vim.o.lines,      -- Maximally available lines
                            -- width = vim.o.columns,     -- Maximally available columns
                            -- prompt_position = "top",
                            preview_width = 0.6
                        },
                        -- other layout configuration here
                    },
                    -- other defaults configuration here
                },
                -- other configuration values here
            })
            telescope.load_extension('fzf')

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
            vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
            vim.keymap.set('n', '<C-p>', builtin.git_files, {})
            vim.keymap.set('n', '<leader>pg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})
            vim.keymap.set('n', '<leader>ps', function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") });
            end)
        end,
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
}
