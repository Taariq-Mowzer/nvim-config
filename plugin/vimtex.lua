vim.g.vimtex_complete_enabled = 1
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_compiler_method = 'latexmk'
vim.g.vimtex_bibtex_flavor = 'biber'
vim.g.vimtex_quickfix_ignore_filters = {"Underfull", "Overfull"}
vim.g.vimtex_compiler_latexmk = {
    aux_dir = ".latex-tmp", -- create a directory called aux that will contain all the auxiliary files
}
