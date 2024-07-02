-- Mason

require("mason").setup()
require("mason-lspconfig").setup({
  -- note: automatic_installation doesn't seem to work, so we manually add LSPs to ensure_installed
  ensure_installed = {
    -- refer to https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
    "typos_lsp", "ltex",
    "marksman",
    "texlab",
    "gopls", "golangci_lint_ls",
    "rust_analyzer",
    "ruff",
    "sqlls",
    "regols",
    "tsserver", "biome", "stimulus_ls", "svelte",
    "html", "htmx",
    "cssls", "stylelint_lsp", "somesass_ls", "tailwindcss",
    "dockerls", "docker_compose_language_service",
    "terraformls", "tflint",
    "bashls",
    "lua_ls",
    "autotools_ls",
    "yamlls", "taplo",
  },
  automatic_installation = true,
})

-- Language servers

local lspconfig = require("lspconfig")
local on_attach = function(_, bufnr)
  vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", {})

  -- Mappings.
  local opts = { buffer = bufnr, noremap = true, silent = true }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n","<Enter>",vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
end

-- prose
lspconfig.typos_lsp.setup({})
lspconfig.ltex.setup({})

-- Markdown
lspconfig.marksman.setup({})

-- LaTeX
lspconfig.texlab.setup({
  settings = {
    build = {
      executable = "tectonic",
      args = {
        "-X",
        "compile",
        "%f",
        "--synctex",
        "--keep-logs",
        "--keep-intermediates"
      },
    },
  },
})

-- Go
lspconfig.gopls.setup({
  settings = {
    gopls = {
      gofumpt = true,
    },
  },
  on_attach=on_attach,
})
lspconfig.golangci_lint_ls.setup({
  root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
  init_options = {
    command = {
      "golangci-lint", "run", "--out-format", "json", "--issues-exit-code=1",
    };
  },
  filetypes = { "go", "gomod" },
})

-- Rust
lspconfig.rust_analyzer.setup({})

-- Python
lspconfig.ruff.setup({})

-- SQL
lspconfig.sqlls.setup({})

-- Rego
lspconfig.regols.setup({})

-- JavaScript/TypeScript
lspconfig.tsserver.setup({})
lspconfig.biome.setup({
  single_file_support = true,
})
lspconfig.stimulus_ls.setup({})
lspconfig.svelte.setup({})

-- HTML
lspconfig.html.setup({})
lspconfig.htmx.setup({})

-- CSS
lspconfig.cssls.setup({})
lspconfig.stylelint_lsp.setup({})
lspconfig.somesass_ls.setup({})
lspconfig.tailwindcss.setup({})

-- Docker
lspconfig.dockerls.setup({})
lspconfig.docker_compose_language_service.setup({})

-- Terraform
lspconfig.terraformls.setup({})
lspconfig.tflint.setup({})

-- bash
lspconfig.bashls.setup({})

-- Lua
lspconfig.lua_ls.setup({
  settings = {
    Lua = {}
  },
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
      return
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          -- Depending on the usage, you might want to add additional paths here.
          "${3rd}/luv/library", -- see https://github.com/folke/lazy.nvim/discussions/1349
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
})

-- Make/etc.
lspconfig.autotools_ls.setup({})

-- JSON/YAML/TOML/etc.
lspconfig.yamlls.setup({})
lspconfig.taplo.setup({})
