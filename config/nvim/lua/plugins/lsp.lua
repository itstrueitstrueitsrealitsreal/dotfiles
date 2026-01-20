return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "jdtls",
        "clangd",
        "clang-format",
        "cpplint",
        "typescript-language-server",
        "rust-analyzer",
        "rustfmt",
      },
    },
  },
}
