local status, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status then
  return
end

lsp_installer.on_server_ready(function(server)
  local opts = server:get_default_options()
  opts.on_attach = require("plugings.configs.lsp.handlers").on_attach
  opts.capabilities = require("plugins.configs.lsp.handlers").capabilities

  -- Apply AstroVim server settings (if available)
  local present, av_overrides = pcall(require, "plugins.configs.lsp.settings." .. server.name)
  if present then
    opts = vim.tbl_deep_extend("force", av_overrides, opts)
  end

  server:setup(options)
 end)
