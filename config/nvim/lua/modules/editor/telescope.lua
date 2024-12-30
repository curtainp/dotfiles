local M = {}

M.setup = function()
  require('telescope').setup({
    pickers = {
      find_files = {
        theme = 'ivy',
      },
    },
    extensions = {
      -- use default, see https://github.com/nvim-telescope/telescope-fzf-native.nvim?tab=readme-ov-file#telescope-setup-and-configuration
      fzf = {},
    },
  })

  require('telescope').load_extension('fzf')
  vim.keymap.set('n', '<space>fg', require('modules.editor.multi-ripgrep'))
end

return M
