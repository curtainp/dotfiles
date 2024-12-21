local servers = {
  clangd = {
    capabilities = {
      textDocument = { completion = { completionItem = { snippetSupport = false } } },
    },
    cmd = {
      'clangd',
      '--background-index',
      '--header-insertion-decorators=false',
    },
    init_options = { fallbackFlags = { vim.bo.filetype == 'cpp' and '-std=c++23' or nil } },
    root_dir = function(fname)
      return require('lspconfig').util.root_pattern(unpack({
        'Makefile',
        'CMakeLists.txt',
        'compile_commands.json',
        '.clangd',
        '.clang-tidy',
        '.clang-format',
      }))(fname) or require('lspconfig').util.find_git_ancestor(fname)
    end,
  },
  lua_ls = {
    cmd = {
      'lua-language-server',
    },
    settings = {
      Lua = {
        diagnostics = {
          unusedLocalExclude = { '_*' },
          globals = { 'vim' },
          disable = {
            'luadoc-miss-see-name',
            'undefined-field',
          },
        },
        runtime = { version = 'LuaJIT' },
        workspace = {
          library = {
            vim.env.VIMRUNTIME .. '/lua',
            '${3rd}/busted/library',
            '${3rd}/luv/library',
          },
          checkThirdParty = false,
        },
        completion = { callSnippet = 'Replace' },
      },
    },
  },
  rust_analyzer = {
    settings = {
      ['rust-analyzer'] = {
        imports = {
          granularity = {
            group = 'module',
          },
          prefix = 'self',
        },
        cargo = {
          buildScripts = {
            enable = true,
          },
        },
        procMacro = {
          enable = true,
        },
      },
    },
  },
  pyright = {
    root_dir = function(fname)
      return require('lspconfig').util.root_pattern(unpack({
        '.pyproject.toml',
        'main.py',
        '.git',
      }))(fname) or require('lspconfig').util.find_git_ancestor(fname)
    end,
    single_file_support = true,
  },
  bashls = {},
  jsonls = {},
  marksman = {},
}

return servers
