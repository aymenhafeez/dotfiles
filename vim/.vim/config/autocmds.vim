" ---------------------------------- autocmds ---------------------------------

" return to last edit position when opening files
augroup last_edit
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

" turn off autocommenting new line for all filetypes
augroup auto_comment
    autocmd!
    autocmd filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END

" better filetype detection
augroup filetype_things
    autocmd!
    autocmd BufRead,BufNewFile *.markdown set filetype=mkd
    autocmd BufRead,BufNewFile *.md       set filetype=mkd
augroup END
