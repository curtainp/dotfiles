local conf = require('modules.ui.config')

packadd({
  'nvimdev/modeline.nvim',
  event = { 'BufReadPost */*' },
  config = function()
    require('modeline').setup()
  end,
})

packadd({
  'lewis6991/gitsigns.nvim',
  event = 'BufEnter */*',
  config = conf.gitsigns,
})

packadd({
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000
})

packadd({
  'nvimdev/indentmini.nvim',
  event = 'BufEnter */*',
  config = function()
    vim.opt.listchars:append({ tab = '  ' })
    require('indentmini').setup({
      only_current = true,
    })
  end,
})
