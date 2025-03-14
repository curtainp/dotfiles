local conf = require('modules.tools.config')

packadd({
  'nvimdev/flybuf.nvim',
  cmd = 'FlyBuf',
  config = function()
    require('flybuf').setup({})
  end,
})

packadd({
  'nvimdev/guard.nvim',
  ft = program_ft,
  config = conf.guard,
  dependencies = {
    { 'nvimdev/guard-collection' },
  },
})

packadd({
  'norcalli/nvim-colorizer.lua',
  ft = 'lua',
  config = function()
    vim.opt.termguicolors = true
    require('colorizer').setup()
  end,
})

packadd({
  'Civitasv/cmake-tools.nvim',
  enabled = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = conf.cmake,
})

packadd({
  'mikavilpas/yazi.nvim',
  event = 'VeryLazy',
  opts = {
    floating_window_scaling_factor = 1,
    open_for_directories = true,
    open_multiple_tabs = true,
  },
})
