local plugin_groups = {
  require "plugins.core",
  require "plugins.lsp",
  require "plugins.completion",
  require "plugins.formatting",
  require "plugins.lang",
  require "plugins.editing",
}

local plugins = {}

for _, group in ipairs(plugin_groups) do
  vim.list_extend(plugins, group)
end

return plugins
