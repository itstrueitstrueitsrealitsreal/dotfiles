local jdtls = require "jdtls"

local root_markers = { "gradlew", "mvnw", "pom.xml", "build.gradle", ".git" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if not root_dir or root_dir == "" then
  return
end

-- Workspace directory per project
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls/workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local config = {
  cmd = { "jdtls", "-data", workspace_dir },
  root_dir = root_dir,
  on_attach = require("nvchad.configs.lspconfig").on_attach,
  capabilities = require("nvchad.configs.lspconfig").capabilities,
}

jdtls.start_or_attach(config)
