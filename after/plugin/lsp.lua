local lsp = require("lsp-zero")
local util = require('lspconfig/util')

local path = util.path

lsp.preset("recommended")

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

lsp.ensure_installed({
    'eslint',
    'tsserver',
    'svelte',
    'pyright',
    'rust_analyzer'
})


-- 'pylint',
-- 'black',
--

-- https://github.com/VonHeikemen/lsp-zero.nvim#configurename-opts
-- :help lspconfig-setup


lsp.configure('tsserver', {
    filetypes = { "typescript" },
})

lsp.configure('pyright', {
    exclude = { "./.venv"},
    venvPath = ".",
    venv = ".venv",
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

-- disable completion with tab
-- this helps with copilot setup
-- cmp_mappings['<Tab>'] = nil
-- cmp_mappings['<S-Tab>'] = nil


lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})


-- Thse remaps only exist for the lifetime of the popup buffer
lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)

-- Configure lua language server for Neovim specify
lsp.nvim_workspace()

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})

