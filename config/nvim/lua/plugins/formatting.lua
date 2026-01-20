return {
  {
    "stevearc/conform.nvim",
    -- event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "nvimtools/none-ls.nvim",
    ft = { "go", "c", "cpp" },
    opts = function()
      return require "configs.null-ls"
    end,
  },

  {
    "zapling/mason-conform.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "stevearc/conform.nvim",
    },
  },
}
