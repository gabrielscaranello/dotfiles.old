local status, packer = pcall(require, "packer")
if not status then return end

packer.startup {
  function(use)
    use {"arcticicestudio/nord-vim"}
  end,
  config = {
    compile_path = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua",
    display = {
      open_fn = function()
        return require("packer.util").float {border = "rounded"}
      end
    },
    profile = {enable = true, threshold = 0.0001},
    git = {clone_timeout = 300},
    auto_clean = true,
    compile_on_sync = true
  }
}
