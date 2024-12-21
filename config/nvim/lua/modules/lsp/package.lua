packadd({
  'neovim/nvim-lspconfig',
  ft = program_ft,
  config = function()
    require('modules.lsp.config')
  end,
})

packadd({
  'nvimdev/lspsaga.nvim',
  event = 'LspAttach',
  -- dev = true,
  config = function()
    require('lspsaga').setup({
      ui = { use_nerd = false },
      symbol_in_winbar = {
        enable = false,
      },
      lightbulb = {
        enable = false,
      },
      outline = {
        layout = 'float',
      },
    })
  end,
})
