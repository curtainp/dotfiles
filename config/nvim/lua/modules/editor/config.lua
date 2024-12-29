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

---@param direction "backward"|"forward"
local super_tab = function(direction)
  local ret = {
    function(cmp)
      local ls = require('luasnip')
      local current_node = ls.session.current_nodes[vim.api.nvim_get_current_buf()]
      if not ls.session or not current_node or ls.session.jump_active then
        return false
      end
      local current_start, current_end = current_node:get_buf_position()
      current_start[1] = current_start[1] + 1 -- (1, 0) indexed
      current_end[1] = current_end[1] + 1 -- (1, 0) indexed
      local cursor = vim.api.nvim_win_get_cursor(0)
      if
        cursor[1] < current_start[1]
        or cursor[1] > current_end[1]
        or cursor[2] < current_start[2]
        or cursor[2] > current_end[2]
      then
        ls.unlink_current()
        return false
      end
      cmp.hide()
      if direction == 'backward' then
        return cmp.snippet_backward()
      elseif direction == 'forward' then
        return cmp.snippet_forward()
      end
    end,
    'select_next',
    'fallback',
  }
  if direction == 'backward' then
    ret[2] = 'select_prev'
  end
  return ret
end

function M.blink()
  require('blink.cmp').setup({
    keymap = {
      ['<Tab>'] = super_tab('forward'),
      ['<S-Tab>'] = super_tab('backward'),
      ['<CR>'] = { 'accept', 'fallback' },
      ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
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
      default = { 'lsp', 'path', 'luasnip', 'buffer', 'lazydev' },
      cmdline = {},
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
