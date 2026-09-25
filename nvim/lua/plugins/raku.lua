-- Raku language support
-- Provides syntax highlighting, filetype detection, and LSP integration
return {
  -- Raku syntax highlighting, indentation, and filetype detection
  -- https://github.com/Raku/vim-raku
  {
    "Raku/vim-raku",
    ft = { "raku", "rak", "rakudoc", "rakutest" },
    init = function()
      -- Ensure common Raku extensions are recognized
      vim.filetype.add({
        extension = {
          raku     = "raku",
          rak      = "rak",
          rakumod  = "raku",
          rakutest = "raku",
          rakudoc  = "raku",
          pm6      = "raku",
          pod6     = "raku",
          t        = "raku", -- May conflict with Perl .t files
        },
        filename = {
          ["META6.json"] = "json",
        },
        pattern = {
          [".*/.+\\.rakumod"] = "raku",
        },
      })
    end,
  },

  -- Raku Language Server (Raku Navigator)
  -- Requires manual installation (see instructions below)
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       raku_navigator = {
  --         mason = false, -- not available via mason, install manually
  --         -- cmd = { "node", "/path/to/RakuNavigator/server/out/server.js", "--stdio" },
  --         -- settings = {
  --         --   raku_navigator = {
  --         --     rakuPath = vim.fn.exepath("raku"),
  --         --   },
  --         -- },
  --       },
  --     },
  --   },
  -- },

  -- Optional: conform.nvim formatter config for Raku
  -- {
  --   "stevearc/conform.nvim",
  --   opts = {
  --     formatters_by_ft = {
  --       raku = { "raku_tidy" }, -- requires App::RakuTidy
  --     },
  --   },
  -- },
}