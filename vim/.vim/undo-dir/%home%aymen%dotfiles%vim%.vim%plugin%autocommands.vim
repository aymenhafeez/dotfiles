Vim�UnDo� 0��xܜ 7�r����Z�!W8�z�"��Fp      h    autocmd filetype netrw nnoremap <silent> <leader>- :Lexplore %:p:h<CR>:call DeleteEmptyBuffers()<CR>      @                       ^�A]    _�                             ����                                                                                                                                                                                                                                                                                                                                                             ^�h     �                   �               5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             ^�k     �                " Autocommands {{{5�_�                            ����                                                                                                                                                                                                                                                                                                                                                  V        ^�p    �                    " }}}5�_�                            ����                                                                                                                                                                                                                                                                                                                                                  V        ^�r    �                 5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             ^���     �               5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             ^���    �               �               5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        ^��
    �               " Auto command5�_�      	                 -    ����                                                                                                                                                                                                                                                                                                                                                  V        ^��"     �               ;" call startscreen function to open Vim on a scratch buffer5�_�      
           	      5    ����                                                                                                                                                                                                                                                                                                                                                  V        ^��'    �               <" call startscreen function to open Vim on a 'scratch buffer5�_�   	              
           ����                                                                                                                                                                                                                                                                                                                                                  V        ^��>    �                    =" call startscreen function to open Vim on a 'scratch' buffer   augroup startscreen   		autocmd!   &	autocmd VimEnter * call StartScreen()   augroup end        5�_�   
                        ����                                                                                                                                                                                                                                                                                                                               4          4       V   4    ^�A1    �                a    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> :call DeleteEmptyBuffers()<CR>:bd<CR>5�_�                           ����                                                                                                                                                                                                                                                                                                                                                V       ^�A5    �                B    autocmd filetype netrw nnoremap <silent> <buffer> <C-l> <C-w>l5�_�                           ����                                                                                                                                                                                                                                                                                                                                         9       V   9    ^�A=   	 �                   �             5�_�                       6    ����                                                                                                                                                                                                                                                                                                                                         9       V   9    ^�AO   
 �               6    " get rid of empty buffers created when using :Lex5�_�                       @    ����                                                                                                                                                                                                                                                                                                                               :          :       V   :    ^�A[     �               h    autocmd filetype netrw nnoremap <silent> <leader>- :Lexplore %:p:h<CR>:call DeleteEmptyBuffers()<CR>5�_�                       @    ����                                                                                                                                                                                                                                                                                                                               :          :       V   :    ^�A[     �               g    autocmd filetype netrw nnoremap <silent> <leader>- :Lexplore%:p:h<CR>:call DeleteEmptyBuffers()<CR>5�_�                       @    ����                                                                                                                                                                                                                                                                                                                               :          :       V   :    ^�A[     �               f    autocmd filetype netrw nnoremap <silent> <leader>- :Lexplore:p:h<CR>:call DeleteEmptyBuffers()<CR>5�_�                       @    ����                                                                                                                                                                                                                                                                                                                               :          :       V   :    ^�A\     �               e    autocmd filetype netrw nnoremap <silent> <leader>- :Lexplorep:h<CR>:call DeleteEmptyBuffers()<CR>5�_�                       @    ����                                                                                                                                                                                                                                                                                                                               :          :       V   :    ^�A\     �               d    autocmd filetype netrw nnoremap <silent> <leader>- :Lexplore:h<CR>:call DeleteEmptyBuffers()<CR>5�_�                        @    ����                                                                                                                                                                                                                                                                                                                               :          :       V   :    ^�A\    �               c    autocmd filetype netrw nnoremap <silent> <leader>- :Lexploreh<CR>:call DeleteEmptyBuffers()<CR>5��