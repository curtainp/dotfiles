local api = vim.api
local map = require('core.keymap')
local cmd = map.cmd
map.n({
  ['j'] = 'gj',
  ['k'] = 'gk',
  ['<C-s>'] = cmd('write'),
  ['<A-j>'] = "<cmd>execute 'move .+' . v:count1<cr>==",
  ['<A-k>'] = "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==",
  ['<S-h>'] = cmd('bp'),
  ['<S-l>'] = cmd('bn'),
  ['<C-q>'] = cmd('qa!'),
  --window
  ['<C-h>'] = '<C-w>h',
  ['<C-l>'] = '<C-w>l',
  ['<C-j>'] = '<C-w>j',
  ['<C-k>'] = '<C-w>k',
  ['<A-[>'] = cmd('vertical resize -5'),
  ['<A-]>'] = cmd('vertical resize +5'),
  ['[t'] = cmd('vs | vertical resize -5 | terminal'),
  [']t'] = cmd('set splitbelow | sp | set nosplitbelow | resize -5 | terminal'),
  ['<C-x>t'] = cmd('tabnew | terminal'),
})

map.i({
  ['<C-d>'] = '<C-o>diw',
  ['<C-b>'] = '<Left>',
  ['<C-f>'] = '<Right>',
  ['<C-a>'] = '<Esc>^i',
  ['<C-e>'] = '<End>',
  ['<C-k>'] = '<C-o>d$',
  ['<C-s>'] = '<ESC>:w<CR>',
  ['<C-n>'] = '<Down>',
  ['<C-p>'] = '<Up>',
  --down/up
  ['<C-j>'] = '<C-o>o',
  ['<A-j>'] = '<esc><cmd>m .+1<cr>==gi',
  ['<A-k>'] = '<esc><cmd>m .-2<cr>==gi',
  ['<C-l>'] = '<C-o>O',
  --@see https://github.com/neovim/neovim/issues/16416
  ['<C-C>'] = '<C-C>',
})

map.v({
  ['<A-j>'] = ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv",
  ['<A-k>'] = ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv",
})

map.nis('<esc>', function()
  vim.cmd('noh')
  return '<esc>'
end, { expr = true, desc = 'Escape and Clear hlsearch' })

map.c({
  ['<C-b>'] = '<Left>',
  ['<C-f>'] = '<Right>',
  ['<C-a>'] = '<Home>',
  ['<C-e>'] = '<End>',
  ['<C-d>'] = '<Del>',
  ['<C-h>'] = '<BS>',
})

map.t({
  ['<Esc>'] = [[<C-\><C-n>]],
  ['<C-x>k'] = cmd('quit'),
})
