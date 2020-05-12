" Autocommands

" return to last edit position when opening files
augroup last_edit_position
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

" turn off autocommenting new line for all filetypes
augroup auto_comment_off
    autocmd!
    autocmd filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END

augroup netrw_mappings
    autocmd!
    " get rid of empty buffers created when using :Lexplore
    autocmd filetype netrw nnoremap <silent> <CR> :call DeleteEmptyBuffers()<CR>
    autocmd filetype netrw nnoremap <silent> <leader>- :Lexplore<CR>:call DeleteEmptyBuffers()<CR>
augroup END
