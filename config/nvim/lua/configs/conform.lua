local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettierd" },
    html = { "prettierd" },
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    c = { "clang_format" },
    cpp = { "clang_format" },
    java = { "google_java_format" },
    rust = { "rustfmt" },
    sh = { "shfmt" },
    json = { "dprint" },
    tex = { "latexindent" },
    latex = { "latexindent" },
  },
  formatters = {
    google_java_format = {
      command = "google-java-format",
      args = { "-", "-aosp" }, 
      stdin = true,
    },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
