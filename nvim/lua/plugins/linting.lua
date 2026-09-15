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
      -- Give clang-format an explicit style. conform's built-in
      -- "clang-format" formatter (lua/conform/formatters/clang-format.lua)
      -- passes no -style flag of its own, so without this clang-format
      -- falls back to its own default of `-style=file`, which walks up
      -- the directory tree looking for a .clang-format/_clang-format
      -- file and only uses LLVM if none is found. If you're still seeing
      -- Allman-style braces (brace on its own line after `if`/`else` too)
      -- after this, run :ConformInfo on a .cpp buffer to confirm
      -- clang-format is the formatter actually running (not clangd's
      -- LSP-based formatting) and check for a stray .clang-format file
      -- up the tree -- an explicit --style string like this one always
      -- wins over that file as long as it parses.
      --
      -- Stroustrup = Attach (braces stay on the `if`/`else`/function
      -- line) + a forced line break before `else`/`catch`/function
      -- bodies, i.e. exactly:
      --   if (x) {
      --   }
      --   else {
      --   }
      formatters = {
        ["clang-format"] = {
          prepend_args = {
            "--style={BasedOnStyle: LLVM, BreakBeforeBraces: Custom, BraceWrapping: {AfterFunction: false, AfterControlStatement: false, AfterClass: false, AfterStruct: false, AfterUnion: false, AfterEnum: false, AfterNamespace: false, BeforeElse: true, BeforeCatch: true, IndentBraces: false, SplitEmptyFunction: true, SplitEmptyRecord: true, SplitEmptyNamespace: true}}",
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
