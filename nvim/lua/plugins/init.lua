local status, packer = pcall(require, "packer")
if not status then return end

-- add plugins
packer.startup {
    function(use)
        local configs = require("plugins.configs")

        use "wbthomason/packer.nvim"
        use "nvim-lua/plenary.nvim"
        use "nvim-lua/popup.nvim"

        use {"lewis6991/impatient.nvim", config = configs['impatient']}

        use {
            "antoinemadec/FixCursorHold.nvim",
            event = "BufRead",
            config = configs["fix-cursor-hold"]
        }

        use {"nathom/filetype.nvim", config = configs["filetype"]}

        use {"kyazdani42/nvim-web-devicons", config = configs["icons"]}

        use {"nvim-lualine/lualine.nvim", config = configs["lualine"]}

        use {
            "kyazdani42/nvim-tree.lua",
            config = configs["nvim-tree"],
            cmd = {"NvimTreeToggle", "NvimTreeFocus"},
            after = {"gitsigns.nvim"}
        }

        use {
            "akinsho/bufferline.nvim",
            after = "nvim-web-devicons",
            config = configs["bufferline"]
        }

        use {"moll/vim-bbye", after = "bufferline.nvim"}

        -- Syntax highlighting
        use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            event = "BufRead",
            cmd = {
                "TSInstall", "TSInstallInfo", "TSInstallSync", "TSUninstall",
                "TSUpdate", "TSUpdateSync", "TSDisableAll", "TSEnableAll"
            },
            config = configs["treesitter"],
            requires = {
                {
                    -- Parenthesis highlighting
                    "p00f/nvim-ts-rainbow",
                    after = "nvim-treesitter"
                }, {
                    -- Autoclose tags
                    "windwp/nvim-ts-autotag",
                    after = "nvim-treesitter"
                }, {
                    -- Context based commenting
                    "JoosepAlviste/nvim-ts-context-commentstring",
                    after = "nvim-treesitter"
                }
            }
        }

        use {
            "lewis6991/gitsigns.nvim",
            config = configs["gitsigns"],
            requires = {'nvim-lua/plenary.nvim'}
        }

        use {
            "L3MON4D3/LuaSnip",
            config = configs['lua-snip'],
            requires = {"rafamadriz/friendly-snippets"},
            after = "nvim-lsp-installer"
        }

        -- Completion engine
        use {"hrsh7th/nvim-cmp", event = "BufRead", config = configs["cmp"]}

        -- Snippet completion source
        use {"saadparwaiz1/cmp_luasnip", after = "nvim-cmp"}

        -- Buffer completion source
        use {"hrsh7th/cmp-buffer", after = "nvim-cmp"}

        -- Path completion source
        use {"hrsh7th/cmp-path", after = "nvim-cmp"}

        -- LSP completion source
        use {"hrsh7th/cmp-nvim-lsp"}

        -- LSP manager
        use {
            "williamboman/nvim-lsp-installer",
            event = "BufRead",
            cmd = {
                "LspInstall", "LspInstallInfo", "LspPrintInstalled",
                "LspRestart", "LspStart", "LspStop", "LspUninstall",
                "LspUninstallAll"
            },
            after = "nvim-lspconfig"
        }

        -- Built-in LSP
        use {
            "neovim/nvim-lspconfig",
            event = "BufRead",
            config = configs["lsp"]
        }

        -- LSP enhancer
        use {
            "tami5/lspsaga.nvim",
            event = "BufRead",
            config = configs["lsp.lspsaga"],
            after = {"nvim-lsp-installer"}
        }

        -- LSP symbols
        use {
            "simrat39/symbols-outline.nvim",
            cmd = "SymbolsOutline",
            setup = configs["symbols-outline"]
        }

        -- Formatting and linting
        use {
            "jose-elias-alvarez/null-ls.nvim",
            event = "BufRead",
            config = configs["null-ls"],
            requires = {"nvim-lua/plenary.nvim"},
            after = "nvim-lsp-installer"
        }

        -- Fuzzy finder
        use {
            "nvim-telescope/telescope.nvim",
            cmd = "Telescope",
            config = configs['telescope']
        }

        -- Fuzzy finder syntax support
        use {"nvim-telescope/telescope-fzf-native.nvim", run = "make"}

        -- Start screen
        use {"glepnir/dashboard-nvim", config = configs['dashboard']}

        -- Color highlighting
        use {
            "norcalli/nvim-colorizer.lua",
            event = "BufRead",
            config = configs['colorizer']
        }

        -- Autopairs
        use {
            "windwp/nvim-autopairs",
            event = "InsertEnter",
            config = configs['autopairs']
        }

        -- Terminal
        use {
            "akinsho/nvim-toggleterm.lua",
            cmd = "ToggleTerm",
            config = configs['toggleterm']
        }

        -- String Case Converter
        use {"chiedo/vim-case-convert"}

        -- Commenting
        use {
            "numToStr/Comment.nvim",
            event = "BufRead",
            config = configs['comment']
        }

        -- Indentation
        use {
            "lukas-reineke/indent-blankline.nvim",
            config = configs['indent-line']
        }

        -- Keymaps popup
        use {"folke/which-key.nvim", config = configs["which-key"]}

        -- Smooth scrolling
        use {
            "karb94/neoscroll.nvim",
            event = "BufRead",
            config = configs['neoscroll']
        }

        use {
            "max397574/better-escape.nvim",
            event = {"InsertEnter"},
            config = function()
                require("better_escape").setup {
                    mapping = {"ii", "jj", "jk", "kj"},
                    timeout = vim.o.timeoutlen,
                    keys = "<ESC>"
                }
            end
        }

        use {
            "tzachar/cmp-tabnine",
            run = "./install.sh",
            requires = {"hrsh7th/nvim-cmp"},
            config = configs['tabnine']
        }

        -- Get extra JSON schemas
        use {"b0o/SchemaStore.nvim"}

        use {"rcarriga/nvim-notify", config = configs["notify"]}

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
