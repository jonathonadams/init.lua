return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').setup({
        install_dir = vim.fn.stdpath('data') .. '/site',
      })

      require('nvim-treesitter').install({
        'vimdoc', 'javascript', 'typescript', 'python', 'lua',
        'rust', 'go', 'sql', 'css', 'markdown', 'markdown_inline',
        'svelte', 'html', 'scss', 'regex', 'comment', 'jsdoc',
      })

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          local lang = vim.treesitter.language.get_lang(ft)
          if not lang then return end

          local nts = require('nvim-treesitter')
          if vim.list_contains(nts.get_installed('parsers'), lang) then
            pcall(vim.treesitter.start, args.buf, lang)
          elseif vim.list_contains(nts.get_available(), lang) then
            nts.install({ lang }):await(function()
              vim.schedule(function()
                pcall(vim.treesitter.start, args.buf, lang)
              end)
            end)
          end
        end,
      })
    end,
  },
}
