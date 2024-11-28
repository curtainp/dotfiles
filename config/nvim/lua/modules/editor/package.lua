local conf = require('modules.editor.config')

-- app list
-- vim.split(vim.fn.globpath('/Applications/', '*.app'), '\n')
packadd({
  'ibhagwan/fzf-lua',
  cmd = 'FzfLua',
  config = function()
    require('fzf-lua').setup({ 'max-perf' })
  end,
})

packadd({
  'nvim-flutter/flutter-tools.nvim',
  ft = 'dart',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  -- default setup
  opts = {},
})

packadd({
  'saghen/blink.cmp',
  event = { 'LspAttach' },
  dependencies = 'rafamadriz/friendly-snippets',
  version = 'v0.*',
  opts = {
    keymap = {
      ['<TAB>'] = {
        'select_next',
        'snippet_forward',
        'fallback',
      },
      ['<S-TAB>'] = {
        'select_prev',
        'snippet_backward',
        'fallback',
      },
      ['<C-e>'] = {
        'hide',
        'fallback',
      },
      ['<CR>'] = {
        'accept',
        'fallback',
      },
      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    },
    appearance = {
      nerd_font_variant = 'mono',
    },
    windows = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 50,
      },
    },
  },
  opts_extend = { 'sources.completion.enabled_providers' },
})

packadd({
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufRead', 'BufNewFile' },
  build = ':TSUpdate',
  config = conf.nvim_treesitter,
})

--@see https://github.com/nvim-treesitter/nvim-treesitter-textobjects/issues/507
packadd({
  'nvim-treesitter/nvim-treesitter-textobjects',
  ft = { 'c', 'rust', 'lua', 'cpp' },
  config = function()
    vim.defer_fn(function()
      require('nvim-treesitter.configs').setup({
        textobjects = {
          select = {
            enable = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = { query = '@class.inner' },
            },
          },
        },
      })
    end, 0)
  end,
})
