local api = vim.api
local au = api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup('CurtainGroup', {})

au('BufWritePre', {
  group = group,
  pattern = { '/tmp/*', 'COMMIT_EDITMSG', 'MERGE_MSG', '*.tmp', '*.bak' },
  command = 'setlocal noundofile',
})

au('TextYankPost', {
  group = group,
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 400 })
  end,
})

-- disable diagnostic when select mode
au('ModeChanged', {
  group = vim.api.nvim_create_augroup('diag_in_select', { clear = true }),
  pattern = '*:s',
  callback = function()
    vim.diagnostic.enable(false)
  end,
})
au('ModeChanged', {
  group = vim.api.nvim_create_augroup('diag_in_select', { clear = false }),
  pattern = '[is]:n',
  callback = function()
    vim.diagnostic.enable()
  end,
})

au('FileType', {
  group = group,
  pattern = {
    -- TODO: other type
    'checkhealth',
    'gitsigns-blame',
    'help',
    'lspinfo',
    'qf',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set('n', 'q', function()
        vim.cmd('close')
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = 'quit buffer',
      })
    end)
  end,
})

au('BufEnter', {
  group = group,
  once = true,
  callback = function()
    require('keymap')
    require('internal.cursor_word')
  end,
  desc = 'Lazy load my keymap and buffer relate commands and defaul opt plugins',
})

if vim.env.TERM == 'alacritty' then
  au('ExitPre', {
    group = group,
    command = 'set guicursor=a:ver90',
    desc = 'Set cursor back to beam when leaving Neovim.',
  })
end

au('TermOpen', {
  group = group,
  callback = function()
    vim.opt_local.stc = ''
    vim.wo.number = false
    vim.cmd.startinsert()
  end,
})

au('InsertEnter', {
  group = group,
  callback = function()
    require('internal.pairs').setup({})
  end,
})

local lsp_keymap = function(bufnr)
  -- lsp-builtin
  local set = function(keys, func, indesc)
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = indesc })
  end
  set('gr', vim.lsp.buf.references, '[R]eferences')
  set('gI', vim.lsp.buf.implementation, '[I]mplementations')
  set('K', function()
    vim.lsp.buf.hover({ border = 'rounded' })
  end, 'Hover')
  set('gk', function()
    vim.lsp.buf.signature_help({ border = 'rounded' })
  end, 'LSP Signature help')
  set('gD', '<cmd>FzfLua lsp_document_symbols<CR>', '[D]oc symbols')
  set(
    'gd',
    "<cmd>lua require('fzf-lua').lsp_definitions{ jump_to_single_result = true }<CR>",
    'definition'
  )
  set('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  set('<leader>cn', vim.lsp.buf.rename, '[C]ode Item Re[N]ame')
  set('<leader>ct', vim.lsp.buf.type_definition, '[C]ode [T]ype definition')
  set('<leader>cd', vim.diagnostic.open_float, '[C]ode [D]iagnostic')
end

au('LspAttach', {
  callback = function(args)
    lsp_keymap(args.buf)
    -- inlay hints
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true)
    end
    if vim.bo[args.buf].filetype == 'lua' and api.nvim_buf_get_name(args.buf):find('_spec') then
      vim.diagnostic.enable(false, { bufnr = args.buf })
    end
  end,
})

local timer = nil --[[uv_timer_t]]
local function reset_timer()
  if timer then
    timer:stop()
    timer:close()
  end
  timer = nil
end

au('VimEnter', {
  callback = function()
    vim.fn.setreg('"0', '')
  end,
})

au('LspDetach', {
  callback = function(args)
    local client_id = args.data.client_id
    local client = vim.lsp.get_clients({ client_id = client_id })[1]
    if not vim.tbl_isempty(client.attached_buffers) then
      return
    end
    reset_timer()
    timer = assert(vim.uv.new_timer())
    timer:start(200, 0, function()
      reset_timer()
      vim.schedule(function()
        vim.lsp.stop_client(client_id, true)
      end)
    end)
  end,
  desc = 'Auto stop client when no buffer atttached',
})

au('InsertLeave', {
  callback = function()
    if vim.fn.executable('iswitch') == 0 then
      return
    end
    vim.system({ 'iswitch', '-s', 'com.apple.keylayout.ABC' }, nil, function(proc)
      if proc.code ~= 0 then
        api.nvim_err_writeln('Failed to switch input source: ' .. proc.stderr)
      end
    end)
  end,
  desc = 'auto switch to abc input',
})
