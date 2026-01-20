require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  "gopls",
  "ts_ls",
  "clangd",
  "texlab",
  "jdtls",
  "rust_analyzer",
}
vim.lsp.enable(servers)

local on_attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = vim.lsp.config
local util = require "lspconfig/util"

lspconfig("gopls", {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedParams = true,
        QF1007 = true,
        S1005 = true,
        S1021 = true,
      },
    },
  },
})

lspconfig("ts_ls", {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
})

-- Configure clangd for C/C++ with Google style
lspconfig("clangd", {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=Google",
    "--std=c++23",
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  root_dir = util.root_pattern(
    ".clangd",
    ".clang-tidy",
    ".clang-format",
    "compile_commands.json",
    "compile_flags.txt",
    "configure.ac",
    ".git"
  ),
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
    fallbackFlags = { "--std=c++23" },
  },
})

-- Configure rust-analyzer for Rust
lspconfig("rust_analyzer", {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_dir = util.root_pattern("Cargo.toml", "rust-project.json", ".git"),
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy",
      },
    },
  },
})

-- read :h vim.lsp.config for changing options of lsp server
