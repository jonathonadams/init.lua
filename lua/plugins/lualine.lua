return {
  {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    event = 'VeryLazy',
    config = function()
      require('lualine').setup {
        options = {
          theme = "catppuccin"
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', { 'diagnostics', sources = { 'nvim_lsp' } } },
          lualine_c = { { 'filename', path = 1 } },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
      }
    end
  }
}
