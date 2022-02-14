
if !exists('g:loaded_nvim_treesitter')
  echom "Not loaded treesitter"
  finish
endif

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    "bash",
    "html",
    "javascript",
    "json",
    "lua",
    "php",
    "scss",
    "typescript",
    "vim",
    "vue",
  },
  autotag = {
    enable = true,
  },
  context_commentstring = { enable = true }
}

EOF
