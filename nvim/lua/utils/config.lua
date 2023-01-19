local M = {}

M.packer_init_opts = function()
    return {
        compile_path = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua",
        auto_clean = true,
        compile_on_sync = true,
        display = {
            working_sym = "ﲊ",
            error_sym = "✗ ",
            done_sym = " ",
            removed_sym = " ",
            moved_sym = "",
            open_fn = function()
                return require("packer.util").float {
                    border = "single"
                }
            end
        },
        profile = {
            enable = true,
            threshold = 0.0001
        },
        git = {
            clone_timeout = 300
        }
    }
end
return M
