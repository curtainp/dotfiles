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
  event = 'LspAttach',
  dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },
  version = 'v0.*',
  config = conf.blink,
  opts_extend = { 'sources.completion.enabled_providers' },
})

packadd({
  'L3MON4D3/LuaSnip',
  keys = {
    { '<C-f>', "<cmd>lua require('luasnip').expand()<CR>", desc = 'snippets trigger' },
  },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'TwIStOy/luasnip-snippets',
  },
  build = 'make install_jsregexp',
  config = function()
    require('luasnip').config.setup({ enable_autosnippets = true })
    require('luasnip.loaders.from_lua').lazy_load({
      paths = vim.fn.stdpath('config') .. '/lua/snippets',
    })
    require('luasnip.loaders.from_vscode').lazy_load({ paths = { './snippets' } })
  end,
})

packadd({
  'TwIStOy/luasnip-snippets',
  dependencies = { 'L3MON4D3/LuaSnip' },
  opts = {
    user = {
      name = 'curtain',
    },
    disable_auto_expansion = {
      cpp = { 'i32', 'i64' },
    },
    disable_langs = {
      'nix',
    },
  },
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
              ['aa'] = { query = '@parameter.outer' },
              ['ia'] = { query = '@parameter.inner' },
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = { query = '@class.inner' },
              ['ai'] = '@conditional.outer',
              ['ii'] = '@conditional.inner',
            },
          },
        },
      })
    end, 0)
  end,
})

packadd({
  'kylechui/nvim-surround',
  opts = {},
})
