return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = { 'rafamadriz/friendly-snippets' },
  event = "VeryLazy",
  -- use a release tag to download pre-built binaries
  version = '1.*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap

    keymap = {
      -- set to 'none' to disable the 'default' preset
      preset = 'default',
      ['<CR>'] = { 'select_and_accept', 'fallback' },
    },

    appearance = {
      highlight_ns = vim.api.nvim_create_namespace('blink_cmp'),
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = false,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',

      -- These require the vs code codicons `https://microsoft.github.io/vscode-codicons`
      -- The trailisng space is required for formatting
      kind_icons = {
        Text = ' ',
        Method = ' ',
        Function = ' ',
        Constructor = ' ',
        Field = ' ',
        Variable = ' ',
        Class = ' ',
        Interface = ' ',
        Module = ' ',
        Property = ' ',
        Unit = ' ',
        Value = ' ',
        Enum = ' ',
        Keyword = ' ',
        Snippet = ' ',
        Color = ' ',
        File = ' ',
        Reference = ' ',
        Folder = ' ',
        EnumMember = ' ',
        Constant = ' ',
        Struct = ' ',
        Event = ' ',
        Operator = ' ',
        TypeParameter = ' ',
        Copilot = ' ',
      },
    },


    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" },

    completion = {
      -- 'prefix' will fuzzy match on the text before the cursor
      -- 'full' will fuzzy match on the text before _and_ after the cursor
      -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
      keyword = { range = 'full' },

      -- Disable auto brackets
      -- NOTE: some LSPs may add auto brackets themselves anyway
      accept = { auto_brackets = { enabled = false }, },

      -- Don't select by default, auto insert on selection
      list = { selection = { preselect = false, auto_insert = true } },

      menu = {
        auto_show = true,
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",

        -- nvim-cmp style menu
        draw = {
          padding = 1,
          gap = 2,
          columns = {
            { 'kind_icon' },
            { "label" },
            { "label_description" },
            { "source_name", }
          },
          components = {
            source_name = {
              width = { max = 30 },
              text = function(ctx)
                -- get the import package if it's available
                if ctx.item.detail ~= nil and ctx.item.detail ~= "" then
                  return ctx.item.detail
                end
                return "[" .. ctx.source_name .. "]"
              end,
            },
          }
        },


        min_width = 15,
        max_height = 10,
        winblend = 0,
        -- winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
        -- Keep the cursor X lines away from the top/bottom of the window
        scrolloff = 2,
        -- Note that the gutter will be disabled when border ~= 'none'
        scrollbar = true,
        -- Which directions to show the window,
        -- falling back to the next direction when there's not enough space
      },



      -- Show documentation when selecting a completion item
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 100,
        treesitter_highlighting = true,

        -- draw = function(opts) opts.default_implementation() end,
        window = {
          min_width = 10,
          max_width = 80,
          max_height = 20,
          winblend = 0,
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
          -- Note that the gutter will be disabled when border ~= 'none'
          --
          scrollbar = true,
        },
      },

      -- Display a preview of the selected item on the current line
      ghost_text = { enabled = true },
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },

      providers = {
        path = {
          opts = {
            get_cwd = function(_)
              return vim.fn.getcwd()
            end,
          },
        },
      },
    },

    -- Use a preset for snippets, check the snippets documentation for more information
    -- snippets = { preset = 'default' | 'luasnip' | 'mini_snippets' },

    -- Experimental signature help support
    signature = { enabled = true }

  },
  opts_extend = { "sources.default" }
}
