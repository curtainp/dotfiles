require('keymap.remap')
local map = require('core.keymap')
local cmd = map.cmd

map.n({
  -- Lspsaga
  -- ['[d'] = cmd('Lspsaga diagnostic_jump_next'),
  -- [']d'] = cmd('Lspsaga diagnostic_jump_prev'),
  -- ['K'] = cmd('Lspsaga hover_doc'),
  -- ['ga'] = cmd('Lspsaga code_action'),
  -- ['gr'] = cmd('Lspsaga rename'),
  -- ['gd'] = cmd('Lspsaga peek_definition'),
  -- ['gp'] = cmd('Lspsaga goto_definition'),
  -- ['gh'] = cmd('Lspsaga finder'),
  -- ['<Leader>o'] = cmd('Lspsaga outline'),
  -- ['<Leader>dw'] = cmd('Lspsaga show_workspace_diagnostics'),
  -- ['<Leader>db'] = cmd('Lspsaga show_buf_diagnostics'),
  -- FzfLua
  -- ['<Leader>b'] = cmd('FzfLua buffers'),
  -- ['<Leader>fa'] = cmd('FzfLua live_grep_native'),
  -- ['<Leader>fs'] = cmd('FzfLua grep_cword'),
  -- ['<Leader>ff'] = cmd('FzfLua files'),
  -- ['<Leader>fh'] = cmd('FzfLua helptags'),
  -- ['<Leader>fo'] = cmd('FzfLua oldfiles'),
  -- ['<Leader>fg'] = cmd('FzfLua git_files'),
  -- ['<Leader>gc'] = cmd('FzfLua git_commits'),
  -- ['<Leader>fc'] = cmd('FzfLua files cwd=$HOME/.config'),
  -- flybuf.nvim
  ['<Leader>j'] = cmd('FlyBuf'),
  -- telescope
  ['<space>fh'] = cmd('lua require("telescope.builtin").help_tags()'),
  ['<space>ff'] = cmd('lua require("telescope.builtin").find_files()'),
  ['<space>fb'] = cmd('lua require("telescope.builtin").buffers()'),
  ['<space>/'] = cmd('lua require("telescope.builtin").current_buffer_fuzzy_find()'),
  ['<space>vc'] = function()
    require('telescope.builtin').find_files({
      cwd = vim.fn.stdpath('config'),
    })
  end,
  ['<space>vp'] = function()
    require('telescope.builtin').find_files({
      ---@diagnostic disable-next-line: param-type-mismatch
      cwd = vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy'),
    })
  end,
  --gitsign
  [']g'] = cmd('lua require"gitsigns".next_hunk()<CR>'),
  ['[g'] = cmd('lua require"gitsigns".prev_hunk()<CR>'),
  -- cmake-tools
  -- ['cmr'] = cmd(
  --   "if luaeval('require\"cmake-tools\".is_cmake_project()')|call execute('CMakeRun')|else|call execute('TermExec cmd=./run.sh')|endif"
  -- ),
  -- ['cmb'] = cmd(
  --   "if luaeval('require\"cmake-tools\".is_cmake_project()')|call execute('CMakeBuild')|else|call execute('TermExec cmd=make')|endif"
  -- ),
  -- ['cmc'] = cmd(
  --   "if luaeval('require\"cmake-tools\".is_cmake_project()')|call execute('CMakeGenerate')|else|call execute('TermExec cmd=./configure')|endif"
  -- ),
  -- ['cms'] = cmd(
  --   "if luaeval('require\"cmake-tools\".is_cmake_project()')|call execute('CMakeStopRunner')|else|call execute('TermExec cmd=\\<C-c>')|endif"
  -- ),
  -- yazi
  ['S'] = cmd('Yazi'),
})
-- map.x('ga', cmd('Lspsaga code_action'))
-- map.nt('<M-j>', cmd('Lspsaga term_toggle'))
