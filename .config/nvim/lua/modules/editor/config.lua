local M = {}

function M.nvim_treesitter()
  vim.opt.foldmethod = 'expr'
  vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
  ---@diagnostic disable-next-line: missing-fields
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

function M.blink()
  require('blink.cmp').setup({
    keymap = {
      ['<Tab>'] = { 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
    },
    snippets = {
      expand = function(snippet)
        require('luasnip').lsp_expand(snippet)
      end,
      active = function(filter)
        if filter and filter.direction then
          return require('luasnip').locally_jumpable()
        end
        return require('luasnip').in_snippet()
      end,
      jump = function(direction)
        require('luasnip').jump(direction)
      end,
    },
    appearance = { kind_icons = _G.kind_icons },
    completion = {
      menu = {
        border = 'rounded',
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 50,
        window = {
          border = 'rounded',
        },
      },
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      ghost_text = {
        enabled = true,
      },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
      -- cmdline = {},
      providers = {
        lazydev = {
          name = 'development',
          module = 'lazydev.integrations.blink',
        },
      },
    },
    signature = {
      enabled = true, -- NOTE: this is experimental, see @https://cmp.saghen.dev/configuration/signature.html
      window = { border = 'rounded' },
    },
  })
end

return M
