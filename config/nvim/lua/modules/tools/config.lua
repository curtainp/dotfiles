local config = {}

function config.guard()
  local ft = require('guard.filetype')
  ft('c,cpp'):fmt({
    cmd = 'clang-format',
    stdin = true,
    ignore_patterns = { 'neovim', 'vim' },
  })
  ft('dart'):fmt({
    cmd = 'dart',
    args = { 'format' },
    stdin = true,
  })
  ft('lua'):fmt({
    cmd = 'stylua',
    args = { '-' },
    stdin = true,
    find = 'stylua.toml',
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

function config.cmake()
  require('cmake-tools').setup({
    cmake_command = 'cmake',
    cmake_regenerate_on_save = false,
    cmake_generate_options = { '-GNinja', '-DCMAKE_EXPORT_COMPILE_COMMANDS=1' },
    cmake_build_options = {},
    cmake_build_directory = 'build',
    cmake_soft_link_compile_commands = false,
    cmake_compile_commands_from_lsp = true,
    cmake_kits_path = nil,
    cmake_variants_message = {
      short = { show = true },
      long = { show = true, max_length = 80 },
    },
    cmake_dap_configuration = {
      name = 'cpp',
      type = 'codelldb',
      request = 'launch',
      stopOnEntry = false,
      runInTerminal = true,
      console = 'integrateTerminal',
    },
    cmake_executor = { -- executor to use
      name = 'quickfix', -- name of the executor
      opts = {}, -- the options the executor will get, possible values depend on the executor type. See `default_opts` for possible values.
      default_opts = { -- a list of default and possible values for executors
        quickfix = {
          show = 'always', -- "always", "only_on_error"
          position = 'botright', -- "bottom", "top", "belowright"
          size = 10,
          encoding = 'utf-8',
          auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
        },
        toggleterm = {
          direction = 'horizontal', -- 'vertical' | 'horizontal' | 'tab' | 'float'
          close_on_exit = true, -- whether close the terminal when exit
          auto_scroll = true, -- whether auto scroll to the bottom
        },
        overseer = {},
        terminal = {
          name = 'CMake Terminal',
          prefix_name = '[CMakeTools]: ', -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
          split_direction = 'horizontal', -- "horizontal", "vertical"
          split_size = 6,

          -- Window handling
          single_terminal_per_instance = true, -- Single viewport, multiple windows
          single_terminal_per_tab = true, -- Single viewport per tab
          keep_terminal_static_location = true, -- Static location of the viewport if avialable

          -- Running Tasks
          start_insert = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
          focus = false, -- Focus on terminal when cmake task is launched.
          do_not_add_newline = true, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
        },
      },
    },
    cmake_runner = {
      name = 'quickfix',
      -- name = 'toggleterm',
      opts = {},
      default_opts = { -- a list of default and possible values for runners
        quickfix = {
          show = 'always', -- "always", "only_on_error"
          position = 'belowright', -- "bottom", "top"
          size = 6,
          encoding = 'utf-8',
          auto_close_when_success = false, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
        },
        toggleterm = {
          -- direction = "horizontal", -- 'vertical' | 'horizontal' | 'tab' | 'float'
          -- direction = "tab", -- 'vertical' | 'horizontal' | 'tab' | 'float'
          -- close_on_exit = false, -- whether close the terminal when exit
          direction = 'vertical', -- 'vertical' | 'horizontal' | 'tab' | 'float'
          close_on_exit = true, -- whether close the terminal when exit
          singleton = false, -- single instance, autocloses the opened one, if present
          auto_scroll = false, -- whether auto scroll to the bottom
        },
        overseer = {},
        terminal = {
          name = 'CMake Terminal',
          prefix_name = '[CMakeTools]: ', -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
          split_direction = 'horizontal', -- "horizontal", "vertical"
          split_size = 6,

          -- Window handling
          single_terminal_per_instance = true, -- Single viewport, multiple windows
          single_terminal_per_tab = true, -- Single viewport per tab
          keep_terminal_static_location = true, -- Static location of the viewport if avialable

          -- Running Tasks
          start_insert = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
          focus = false, -- Focus on terminal when cmake task is launched.
          do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
        },
      },
    },
    cmake_notifications = {
      runner = { enabled = false },
      executor = { enabled = false },
      spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }, -- icons used for progress display
      refresh_rate_ms = 100, -- how often to iterate icons
    },
    cmake_virtual_text_support = false,
  })
end

return config
