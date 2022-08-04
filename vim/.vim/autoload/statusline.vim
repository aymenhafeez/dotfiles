
function! statusline#lightlineconfig() abort
    let g:lightline = {
        \ 'colorscheme': 'one',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ ],
        \             [ 'readonly', 'filename', 'gitbranch', 'modified', 'coc_info', 'coc_hints', 'coc_errors', 'coc_warnings' ] ],
        \   'right': [ [  ], 
        \               [ 'percentwin' ],
        \             [ 'filetype',  'lineinfo' ] ]
        \ },
        \ 'tabline': {
        \   'left': [ ['buffers'] ],
        \   'right': [ ['close'] ]
        \ },
        \ 'component_expand': {
        \   'buffers': 'lightline#bufferline#buffers'
        \ },
        \ 'component_type': {
        \   'buffers': 'tabsel'
        \ },
        \ 'component_function': {
        \   'cocstatus': 'coc#status',
        \   'readonly': 'LightlineReadonly',
        \   'space': ' ',
        \   'gitbranch': 'FugitiveHead'
        \ },
        \ }
    call lightline#coc#register()

    function! LightlineReadonly()
        return &readonly && &filetype !=# 'help' ? 'RO' : ''
    endfunction
endfunction

