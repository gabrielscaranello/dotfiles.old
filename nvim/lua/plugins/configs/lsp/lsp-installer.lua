local status, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status then
  return
end


local install_servers = function()
  local required_servers = {
    "jsonls",
    "tsserver",
  }

  local installed_servers = require("nvim-lsp-installer.servers").get_installed_servers()

  local is_installed = function(server_name)
    for _, installed_server in pairs(installed_servers) do
      if server_name == installed_server.name then
        return true
      end
    end
    return false
  end
  
  for i, server in pairs(required_servers) do
    if not is_installed(server) then
      lsp_installer.install(server)
    end
  end
end

lsp_installer.on_server_ready(function(server)
  install_servers()

  local opts = server:get_default_options()
  opts.on_attach = require("plugins.configs.lsp.handlers").on_attach
  opts.capabilities = require("plugins.configs.lsp.handlers").capabilities

  local present, av_overrides = pcall(require, "plugins.configs.lsp.settings." .. server.name)
  if present then
    opts = vim.tbl_deep_extend("force", av_overrides, opts)
  end

  server:setup(opts)
 end)
