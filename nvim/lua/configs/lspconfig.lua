require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "gopls" }
vim.lsp.enable(servers)

local on_attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local util = require "lspconfig/util"

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {"gopls"},
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
      }
    }
  }
}

-- read :h vim.lsp.config for changing options of lsp server
