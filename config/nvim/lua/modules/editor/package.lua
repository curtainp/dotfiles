local conf = require('modules.editor.config')
local conf_telescope = require('modules.editor.telescope')

-- app list
-- vim.split(vim.fn.globpath('/Applications/', '*.app'), '\n')
packadd({
  'ibhagwan/fzf-lua',
  enabled = false,
  cmd = 'FzfLua',
  config = function()
    require('fzf-lua').setup({ 'max-perf' })
  end,
})

packadd({
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = conf_telescope.setup,
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
  event = 'BufEnter */*',
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
      paths = { vim.fn.stdpath('config') .. '/lua/snippets' },
    })
    require('luasnip.loaders.from_vscode').lazy_load({ paths = { './snippets' } })
  end,
})

packadd({
  'TwIStOy/luasnip-snippets',
  event = 'BufEnter */*',
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
      ---@diagnostic disable-next-line: missing-fields
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
  event = { 'BufRead', 'BufNewFile' },
  opts = {},
})

packadd({
  'folke/todo-comments.nvim',
  event = 'BufEnter */*',
  opts = {
    signs = false,
    search = { pattern = [[\b(KEYWORDS)(\([^\)]*\))?:]] },
    highlight = { pattern = [[.*<((KEYWORDS)%(\(.{-1,}\))?):]] },
  },
})

packadd({
  'folke/lazydev.nvim',
  dependencies = { 'Bilal2453/luvit-meta' },
  ft = 'lua',
  event = 'LspAttach',
  opts = {
    library = {
      { path = 'luvit-meta/library', words = { 'vim%.uv', 'vim%.loop' } },
      { path = 'lazy.nvim', words = { 'LazyPluginSpec' } },
    },
  },
})
