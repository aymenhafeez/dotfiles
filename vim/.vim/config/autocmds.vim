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

augroup markdown_mapping
    autocmd!
    autocmd filetype markdown nnoremap <buffer> <Leader>mk :InstantMarkdownPreview<CR>

" netrw 
augroup netrw_mappings
    autocmd!
    autocmd filetype netrw nnoremap <buffer> <C-l> <C-w>l
    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> :call DeleteEmptyBuffers()<CR>:bd<CR>
    autocmd filetype netrw nnoremap <silent> <CR> :call DeleteEmptyBuffers()<CR>
augroup END

augroup help_help
    autocmd!
    autocmd filetype help call HelpFileHelp()
augroup END
