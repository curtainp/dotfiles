require('keymap.remap')
local map = require('core.keymap')
local cmd = map.cmd

map.n({
  -- Lspsaga
  ['[d'] = cmd('Lspsaga diagnostic_jump_next'),
  [']d'] = cmd('Lspsaga diagnostic_jump_prev'),
  ['K'] = cmd('Lspsaga hover_doc'),
  ['ga'] = cmd('Lspsaga code_action'),
  ['gr'] = cmd('Lspsaga rename'),
  ['gd'] = cmd('Lspsaga peek_definition'),
  ['gp'] = cmd('Lspsaga goto_definition'),
  ['gh'] = cmd('Lspsaga finder'),
  ['<Leader>o'] = cmd('Lspsaga outline'),
  ['<Leader>dw'] = cmd('Lspsaga show_workspace_diagnostics'),
  ['<Leader>db'] = cmd('Lspsaga show_buf_diagnostics'),
  -- FzfLua
  ['<Leader>b'] = cmd('FzfLua buffers'),
  ['<Leader>fa'] = cmd('FzfLua live_grep_native'),
  ['<Leader>fs'] = cmd('FzfLua grep_cword'),
  ['<Leader>ff'] = cmd('FzfLua files'),
  ['<Leader>fh'] = cmd('FzfLua helptags'),
  ['<Leader>fo'] = cmd('FzfLua oldfiles'),
  ['<Leader>fg'] = cmd('FzfLua git_files'),
  ['<Leader>gc'] = cmd('FzfLua git_commits'),
  ['<Leader>fc'] = cmd('FzfLua files cwd=$HOME/.config'),
  -- flybuf.nvim
  ['<Leader>j'] = cmd('FlyBuf'),
  --gitsign
  [']g'] = cmd('lua require"gitsigns".next_hunk()<CR>'),
  ['[g'] = cmd('lua require"gitsigns".prev_hunk()<CR>'),
  -- cmake-tools
  ['cmr'] = cmd(
    "if luaeval('require\"cmake-tools\".is_cmake_project()')|call execute('CMakeRun')|else|call execute('TermExec cmd=./run.sh')|endif"
  ),
  ['cmb'] = cmd(
    "if luaeval('require\"cmake-tools\".is_cmake_project()')|call execute('CMakeBuild')|else|call execute('TermExec cmd=make')|endif"
  ),
  ['cmc'] = cmd(
    "if luaeval('require\"cmake-tools\".is_cmake_project()')|call execute('CMakeGenerate')|else|call execute('TermExec cmd=./configure')|endif"
  ),
  ['cms'] = cmd(
    "if luaeval('require\"cmake-tools\".is_cmake_project()')|call execute('CMakeStopRunner')|else|call execute('TermExec cmd=\\<C-c>')|endif"
  ),
  -- yazi
  ['S'] = cmd('Yazi'),
})
map.nx('ga', cmd('Lspsaga code_action'))
map.nt('<M-j>', cmd('Lspsaga term_toggle'))
