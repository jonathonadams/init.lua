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


vim.diagnostic.config({
  --  virtual_lines = true,
  virtual_text = {
    spacing = 0,
    source = true,
    prefix = "",
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  -- float = {
  --    border = "rounded",
  --    source = true,
  --  },
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
