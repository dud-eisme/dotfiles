return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    -- Per-server settings. Anything not listed here just gets `capabilities`
    -- merged in below (empty table = "use defaults, just add capabilities").
    -- NOTE: "sage" was requested but there is no server by that name in
    -- Mason/nvim-lspconfig's registry (SageMath doesn't ship an official
    -- language server) -- see chat reply for options, then add a real
    -- entry here once confirmed.
    local servers = {
      clangd = {
        cmd = { "clangd", "--background-index", "--clang-tidy" },
      },
      rust_analyzer = {
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = { command = "clippy" },
          },
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            -- recognize the `vim` global so lua_ls doesn't flag it as undefined
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
          },
        },
      },
      -- jdtls note: this generic setup gives you basic Java LSP features
      -- (hover, go-to-def, diagnostics), but jdtls' full feature set (debug
      -- integration, per-project workspace dirs, etc.) really wants its own
      -- ftplugin/java.lua with nvim-jdtls -- worth doing separately if you
      -- lean on Java a lot.
      jdtls = {},
      ts_ls = {},
      qmlls = {},
      pyright = {},
    }

    -- 1. Setup Mason
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = vim.tbl_keys(servers),
    })

    -- 2. Setup nvim-cmp
    local cmp = require("cmp")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
      }),
    })

    -- 3. Configure and enable each server with its own settings + shared capabilities
    for name, opts in pairs(servers) do
      opts.capabilities = capabilities
      -- Disable semantic tokens: Neovim's LSP client applies its own
      -- @lsp.type.*/@lsp.mod.* highlight groups on top of treesitter's
      -- captures, and if the colorscheme doesn't fully style those groups
      -- they render unstyled/washed-out -- this only shows up on
      -- LSP-attached buffers (e.g. .cpp via clangd), not plain files like
      -- markdown or a Makefile, which matches what we're seeing. Turning
      -- this off leaves treesitter's own highlighting (which tokyonight
      -- fully supports) as the only source of truth.
      opts.on_init = function(client)
        client.server_capabilities.semanticTokensProvider = nil
      end
      vim.lsp.config(name, opts)
      vim.lsp.enable(name)
    end
  end,
}
