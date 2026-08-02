return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main", -- "master" is frozen/incompatible with Neovim 0.12+
                    -- (crashes opening markdown files with fenced code
                    -- blocks: neovim/neovim#39032, nvim-treesitter#8618)
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  init = function()
    -- On `main`, ensure_installed no longer exists as a config option;
    -- you call the install API directly. Diff against what's already
    -- installed so this doesn't try to reinstall on every startup.
    local ensure_installed = { "cpp", "python", "lua", "markdown", "markdown_inline" }
    local already_installed = require("nvim-treesitter.config").get_installed()
    local to_install = vim.iter(ensure_installed)
      :filter(function(parser)
        return not vim.tbl_contains(already_installed, parser)
      end)
      :totable()

    -- `main` also dropped the highlight/indent module system -- enable
    -- them ourselves per-buffer instead.
    local function attach()
      pcall(vim.treesitter.start)
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end

    if #to_install > 0 then
      -- install() is async and returns immediately, so a buffer opened
      -- for one of these filetypes before its parser finishes compiling
      -- would hit the FileType autocmd below, fail vim.treesitter.start()
      -- silently (pcall), and never retry -- leaving that buffer on
      -- plain regex syntax highlighting (and therefore off-palette
      -- colors) until it was closed and reopened. Re-attach any
      -- already-open buffers once install() actually finishes.
      require("nvim-treesitter").install(to_install):await(function()
        vim.schedule(function()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(buf) and vim.tbl_contains(to_install, vim.bo[buf].filetype) then
              vim.api.nvim_buf_call(buf, attach)
            end
          end
        end)
      end)
    end

    vim.api.nvim_create_autocmd("FileType", {
      callback = attach,
    })
  end,
}
