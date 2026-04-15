return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'BufReadPre',
    build = ':TSUpdate',
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = { "vimdoc", "javascript", "typescript", "python", "lua", "rust", "go", "sql", "css" },
        auto_install = true,
      })
    end,
  },
}
