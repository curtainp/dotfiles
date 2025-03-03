local opt = vim.opt

opt.confirm = true -- confirm before unsaved buffer
opt.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}
opt.inccommand = 'nosplit' -- preview incremental substitute
opt.mouse = 'a'
opt.relativenumber = true
opt.termguicolors = true
opt.smoothscroll = true -- NOTE(curtain): experimental

opt.hidden = true
opt.magic = true
opt.virtualedit = 'block'
opt.clipboard = 'unnamedplus'
opt.wildignorecase = true
opt.swapfile = false

opt.history = 1000
opt.timeout = true
opt.ttimeout = true
opt.timeoutlen = 500
opt.ttimeoutlen = 10
opt.updatetime = 100
opt.redrawtime = 1500
opt.ignorecase = true
opt.smartcase = true
opt.smartindent = true
opt.infercase = true
opt.cursorline = true

opt.completeopt = 'menu,menuone,noinsert,popup'
opt.showmode = false
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.scrolloff = 4 -- minimal number of screen lines keep
opt.sidescrolloff = 5
opt.ruler = false -- disable default ruler
opt.showtabline = 0
opt.winwidth = 30
opt.pumheight = 15
opt.showcmd = false

opt.laststatus = 3 -- global statusline
opt.list = true

--eol:¬
opt.listchars = 'tab:» ,nbsp:+,trail:·,extends:→,precedes:←,'
opt.pumblend = 10
opt.winblend = 0
opt.undofile = true

opt.smarttab = true
opt.expandtab = true
opt.autoindent = true
opt.tabstop = 2
opt.shiftwidth = 2

opt.foldlevelstart = 99
opt.foldmethod = 'marker'

opt.splitright = true
opt.wrap = false

opt.number = true
opt.signcolumn = 'yes'
opt.spelloptions = 'camel'

opt.textwidth = 100
opt.colorcolumn = '+0'

if vim.uv.os_uname().sysname == 'Darwin' then
  vim.g.clipboard = {
    name = 'macOS-clipboard',
    copy = {
      ['+'] = 'pbcopy',
      ['*'] = 'pbcopy',
    },
    paste = {
      ['+'] = 'pbpaste',
      ['*'] = 'pbpaste',
    },
    cache_enabled = 0,
  }
end
