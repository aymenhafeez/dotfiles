Vim�UnDo� "&l$�uZD�Р���
�+!\�u
T�o              =   8   M       M   M   M    ^nC�    _�       9          8   #        ����                                                                                                                                                                                                                                                                                                                            #           $           V        ^\�X    �   "   #              eautocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif5�_�   8   :           9   "        ����                                                                                                                                                                                                                                                                                                                            !           "           V        ^b��    �   !   #          7autocmd InsertLeave * if pumvisible() == 0|pclose|endif5�_�   9   ;           :          ����                                                                                                                                                                                                                                                                                                                                                             ^fyZ     �          "      O" ---------------------------------- autocmds ---------------------------------5�_�   :   <           ;          ����                                                                                                                                                                                                                                                                                                                                                             ^fy]     �          "      ," autocmds ---------------------------------5�_�   ;   =           <           ����                                                                                                                                                                                                                                                                                                                                                             ^fy_     �                !---------------------------------5�_�   <   >           =      #    ����                                                                                                                                                                                                                                                                                                                                                             ^fy`    �         #      #" ---------------------------------5�_�   =   ?           >          ����                                                                                                                                                                                                                                                                                                                                                             ^fyl     �          #      
" autocmds5�_�   >   @           ?      
    ����                                                                                                                                                                                                                                                                                                                                                             ^fyn    �          #      " autocommds5�_�   ?   A           @      
    ����                                                                                                                                                                                                                                                                                                                                                             ^fyr    �         #      
" --------5�_�   @   B           A           ����                                                                                                                                                                                                                                                                                                                                                  V        ^f��     �         #    �         #    5�_�   A   C           B           ����                                                                                                                                                                                                                                                                                                                                                  V        ^f��     �         $    �         $    5�_�   B   D           C           ����                                                                                                                                                                                                                                                                                                                                          C       v   C    ^f��     �         %      Dnnoremap <leader>- :Lexplore %:p:h<CR>:call DeleteEmptyBuffers()<CR>5�_�   C   E           D          ����                                                                                                                                                                                                                                                                                                                                         6       v   6    ^f��     �         %      P    autocmd filetype netrw nnoremap <silent> <CR> :call DeleteEmptyBuffers()<CR>�         %    5�_�   D   F           E      _    ����                                                                                                                                                                                                                                                                                                                                         ^       v   6    ^f��   	 �         %      x    autocmd filetype netrw nnoremap <leader>- :Lexplore %:p:h<CR>:call DeleteEmptyBuffers()<CR> DeleteEmptyBuffers()<CR>5�_�   E   G           F   %        ����                                                                                                                                                                                                                                                                                                                                                             ^f�   
 �   $   %          9" autocmd InsertLeave * if pumvisible() == 0|pclose|endif5�_�   F   H           G   #   =    ����                                                                                                                                                                                                                                                                                                                                                             ^f�    �   "   $   $      =" close preview window once cursor moves away or leave insert5�_�   G   I           H           ����                                                                                                                                                                                                                                                                                                                            $           $           V        ^hL�     �                 5�_�   H   L           I   #        ����                                                                                                                                                                                                                                                                                                                            #           #           V        ^hM    �   "   $          8autocmd CursorMovedI * if pumvisible() == 0|pclose|endif5�_�   I   M   J       L           ����                                                                                                                                                                                                                                                                                                                                                  V        ^n>t    �                    augroup markdown_mapping       autocmd!   V    autocmd filetype markdown nnoremap <buffer> <Leader>mk :InstantMarkdownPreview<CR>   augroup END5�_�   L               M           ����                                                                                                                                                                                                                                                                                                                                                             ^nC�    �                    augroup help_help       autocmd!   -    autocmd filetype help call HelpFileHelp()   augroup END5�_�   I   K       L   J           ����                                                                                                                                                                                                                                                                                                                                                  V        ^lR�    �      "        5�_�   J               K           ����                                                                                                                                                                                                                                                                                                                                                             ^lS�    �              5�_�              8         <    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      `    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> call DeleteEmptyBuffers()<CR>:bd<CR>5�_�                       <    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      _    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> all DeleteEmptyBuffers()<CR>:bd<CR>5�_�                       <    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      ^    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> ll DeleteEmptyBuffers()<CR>:bd<CR>5�_�                       <    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      ]    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> l DeleteEmptyBuffers()<CR>:bd<CR>5�_�                       <    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      \    autocmd filetype netrw nnoremap <silent> <buffer> <Esc>  DeleteEmptyBuffers()<CR>:bd<CR>5�_�                       <    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      [    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> DeleteEmptyBuffers()<CR>:bd<CR>5�_�                       <    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      Z    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> eleteEmptyBuffers()<CR>:bd<CR>5�_�      	                 <    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      Y    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> leteEmptyBuffers()<CR>:bd<CR>5�_�      
           	      <    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      X    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> eteEmptyBuffers()<CR>:bd<CR>5�_�   	              
      <    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      W    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> teEmptyBuffers()<CR>:bd<CR>5�_�   
                    <    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      V    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> eEmptyBuffers()<CR>:bd<CR>5�_�                       <    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      U    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> EmptyBuffers()<CR>:bd<CR>5�_�                       <    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      T    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> mptyBuffers()<CR>:bd<CR>5�_�                       <    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      S    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> ptyBuffers()<CR>:bd<CR>5�_�                       <    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      R    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> tyBuffers()<CR>:bd<CR>5�_�                       <    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      Q    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> yBuffers()<CR>:bd<CR>5�_�                       <    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      P    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> Buffers()<CR>:bd<CR>5�_�                       <    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      O    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> uffers()<CR>:bd<CR>5�_�                       <    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      N    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> ffers()<CR>:bd<CR>5�_�                       <    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      M    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> fers()<CR>:bd<CR>5�_�                       <    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      L    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> ers()<CR>:bd<CR>5�_�                       <    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      K    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> rs()<CR>:bd<CR>5�_�                       <    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      J    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> s()<CR>:bd<CR>5�_�                       <    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      I    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> ()<CR>:bd<CR>5�_�                       <    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      H    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> )<CR>:bd<CR>5�_�                       <    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      G    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> <CR>:bd<CR>5�_�                       <    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      F    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> CR>:bd<CR>5�_�                       <    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      E    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> R>:bd<CR>5�_�                       <    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      D    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> >:bd<CR>5�_�                       <    ����                                                                                                                                                                                                                                                                                                                                                             ^\�    �         $      C    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> :bd<CR>5�_�                        2    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      O    autocmd filetype netrw nnoremap <silent> <CR> call DeleteEmptyBuffers()<CR>5�_�      !                  2    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      N    autocmd filetype netrw nnoremap <silent> <CR> all DeleteEmptyBuffers()<CR>5�_�       "           !      2    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      M    autocmd filetype netrw nnoremap <silent> <CR> ll DeleteEmptyBuffers()<CR>5�_�   !   #           "      2    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      L    autocmd filetype netrw nnoremap <silent> <CR> l DeleteEmptyBuffers()<CR>5�_�   "   $           #      2    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      K    autocmd filetype netrw nnoremap <silent> <CR>  DeleteEmptyBuffers()<CR>5�_�   #   %           $      2    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      J    autocmd filetype netrw nnoremap <silent> <CR> DeleteEmptyBuffers()<CR>5�_�   $   &           %      2    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      I    autocmd filetype netrw nnoremap <silent> <CR> eleteEmptyBuffers()<CR>5�_�   %   '           &      2    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      H    autocmd filetype netrw nnoremap <silent> <CR> leteEmptyBuffers()<CR>5�_�   &   (           '      2    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      G    autocmd filetype netrw nnoremap <silent> <CR> eteEmptyBuffers()<CR>5�_�   '   )           (      2    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      F    autocmd filetype netrw nnoremap <silent> <CR> teEmptyBuffers()<CR>5�_�   (   *           )      2    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      E    autocmd filetype netrw nnoremap <silent> <CR> eEmptyBuffers()<CR>5�_�   )   +           *      2    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      D    autocmd filetype netrw nnoremap <silent> <CR> EmptyBuffers()<CR>5�_�   *   ,           +      2    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      C    autocmd filetype netrw nnoremap <silent> <CR> mptyBuffers()<CR>5�_�   +   -           ,      2    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      B    autocmd filetype netrw nnoremap <silent> <CR> ptyBuffers()<CR>5�_�   ,   .           -      2    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      A    autocmd filetype netrw nnoremap <silent> <CR> tyBuffers()<CR>5�_�   -   /           .      2    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      @    autocmd filetype netrw nnoremap <silent> <CR> yBuffers()<CR>5�_�   .   0           /      2    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      ?    autocmd filetype netrw nnoremap <silent> <CR> Buffers()<CR>5�_�   /   1           0      2    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      >    autocmd filetype netrw nnoremap <silent> <CR> uffers()<CR>5�_�   0   2           1      2    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      =    autocmd filetype netrw nnoremap <silent> <CR> ffers()<CR>5�_�   1   3           2      2    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      <    autocmd filetype netrw nnoremap <silent> <CR> fers()<CR>5�_�   2   4           3      2    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      ;    autocmd filetype netrw nnoremap <silent> <CR> ers()<CR>5�_�   3   5           4      2    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      :    autocmd filetype netrw nnoremap <silent> <CR> rs()<CR>5�_�   4   6           5      2    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      9    autocmd filetype netrw nnoremap <silent> <CR> s()<CR>5�_�   5   7           6      2    ����                                                                                                                                                                                                                                                                                                                                                             ^\�     �         $      8    autocmd filetype netrw nnoremap <silent> <CR> ()<CR>5�_�   6               7          ����                                                                                                                                                                                                                                                                                                                                                             ^\�    �              5��