return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    -- `keys` here (lazy.nvim spec field) lazy-loads the plugin on first
    -- press and sets the keymap -- this is what actually invokes conform
    -- (and therefore your clang-format Stroustrup style below), instead
    -- of vim.lsp.buf.format() which only ever talks to clangd.
    keys = {
      {
        "<leader>gf",
        function()
          local mode = vim.fn.mode()
          if mode == "v" or mode == "V" or mode == "\22" then
            -- exiting visual mode sets the '< and '> marks, letting
            -- conform format an arbitrary multi-line selection
            require("conform").format({
              async = true,
              range = {
                ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
                ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
              },
            })
          else
            require("conform").format({ async = true })
          end
        end,
        mode = { "n", "v" },
        desc = "Format buffer/selection (conform)",
      },
    },
    opts = {
      formatters_by_ft = {
        cpp = { "clang-format" },
        lua = { "stylua" },
      },
      -- Give clang-format an explicit style so it doesn't silently fall
      -- back to its own default (Attach) when no .clang-format file is
      -- found in the project. This mirrors the style previously set as
      -- clangd's --fallback-style, since conform.nvim -- not clangd --
      -- is what's actually running clang-format here.
      formatters = {
        ["clang-format"] = {
          prepend_args = {
            "--style={ BasedOnStyle: LLVM, BreakBeforeBraces: Stroustrup }",
          },
        },
      },
      format_on_save = false,
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = { cpp = { "clangtidy" } }
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
}
