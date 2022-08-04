vim.cmd [[
    augroup MiscAutocommands
        autocmd!
        " return to last edit position when opening files
        autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
        " remove automatically adding comment on new line
        autocmd filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
        " automatically open when a quickfix command is executed and there are valid errors
        autocmd QuickFixCmdPost [^l]* cwindow
        " mappings for quickfix location list
        autocmd BufReadPost quickfix nnoremap <buffer> <leader>cn :cnext<CR>
        autocmd BufReadPost quickfix nnoremap <buffer> <leader>cp :cprev<CR>
        autocmd BufReadPost quickfix nnoremap <buffer> <leader>ln :lnext<CR>
        autocmd BufReadPost quickfix nnoremap <buffer> <leader>lp :lprev<CR>
        autocmd TermOpen * setlocal nonumber norelativenumber nocursorline
    augroup END
]]
