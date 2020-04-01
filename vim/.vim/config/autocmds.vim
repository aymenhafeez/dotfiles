" ---------------------------------- autocmds ---------------------------------

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

augroup markdown_mapping
    autocmd!
    autocmd filetype markdown nnoremap <buffer> <Leader>mk :InstantMarkdownPreview<CR>
augroup END

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

" close preview window once cursor moves away or leave insert
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
