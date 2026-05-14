return {
  {
    "OXY2DEV/markview.nvim",
    ft = { "markdown", "codecompanion" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      preview = {
        enable_hybrid_mode = true,
        modes = { "n" },
        icon_provider = "devicons",
        filetypes = { "markdown", "quarto", "rmd", "codecompanion" },
      },
    },
    keys = {
      { "<leader>m", "<cmd>Markview toggle<cr>", desc = "Toggle markdown preview" },
    },
  },
}
