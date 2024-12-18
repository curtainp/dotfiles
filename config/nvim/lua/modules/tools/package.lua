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
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = conf.cmake,
})

-- packadd({
--   'nvimdev/dbsession.nvim',
--   cmd = { 'SessionSave', 'SessionLoad', 'SessionDelete' },
--   opts = true,
-- })
