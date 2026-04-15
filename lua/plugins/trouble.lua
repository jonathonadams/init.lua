return {
  {
    'folke/trouble.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { '<leader>xq' },
    },
    config = function()
      local trouble = require("trouble")

      trouble.setup {}

      vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix toggle<cr>",
        { silent = true, noremap = true }
      )
    end,
  }
}
