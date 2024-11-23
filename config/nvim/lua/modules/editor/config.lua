local M = {}
local api = vim.api

function M.nvim_treesitter()
  vim.opt.foldmethod = 'expr'
  vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      'c',
      'cpp',
      'bash',
      'rust',
      'lua',
      'python',
      'typescript',
      'javascript',
      'tsx',
      'css',
      'scss',
      'diff',
      'graphql',
      'html',
      'sql',
      'markdown',
      'markdown_inline',
      'dart',
      'json',
      'jsonc',
      'vimdoc',
      'vim',
    },
    highlight = {
      enable = true,
      disable = function(_, buf)
        local bufname = vim.api.nvim_buf_get_name(buf)
        local max_filesize = 300 * 1024
        local ok, stats = pcall(vim.uv.fs_stat, bufname)
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
      additional_vim_regex_highlighting = false,
    },
  })
end

return M
