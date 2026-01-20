return {
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
  },

  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.cmd "filetype plugin indent on"
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexrun = {
        callback = 1,
        continuous = 1,
        executable = "latexmk",
      }

      vim.g.vimtex_quickfix_open_on_warning = 0
    end,
  },
}
