local config = {}

function config.guard()
  local ft = require('guard.filetype')
  ft('c,cpp'):fmt({
    cmd = 'clang-format',
    stdin = true,
    ignore_patterns = { 'neovim', 'vim' },
  })

  ft('lua'):fmt({
    cmd = 'stylua',
    args = { '-' },
    stdin = true,
    ignore_patterns = 'functional/*/*_spec.lua',
  })
  ft('rust'):fmt('rustfmt')
  ft('typescript', 'javascript', 'typescriptreact', 'javascriptreact'):fmt('prettier')
  -- hack when save diagnostic is missing
  vim.api.nvim_create_autocmd('User', {
    pattern = 'GuardFmt',
    callback = function(args)
      if args.data.status == 'done' then
        vim.diagnostic.show()
      end
    end,
  })
end

return config
