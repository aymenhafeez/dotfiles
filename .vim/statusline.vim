" statusline
highlight VertSplit ctermbg=NONE guibg=NONE
highlight FadedColour guifg=#38616b
highlight FadedBG guibg=#38616b
highlight VisualColour guifg=#3454cd
highlight InsertColour guifg=#ffeda9
highlight OffWhiteFG guifg=#cbccb1

" statusline
set statusline=
set statusline+=%#FadedColour#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#OffWhiteFG#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#CursorIM#%{(mode()=='r')?'\ \ REPLACE\ ':''}
set statusline+=%#VisualColour#%{(mode()=='v')?'\ \ VISUAL\ ':''}
set statusline+=%#FadedBG#
set statusline+=%#Cursor#
set statusline+=\ %n 
set statusline+=%R\  
set statusline+=%#FadedColour#
set statusline+=\ %M
set statusline+=\ %f\  
set statusline +=\ %{fugitive#statusline()}
set statusline+=%=
set statusline+=%#FadedColour#
set statusline+=\ %y 
set statusline+=\ %3l:%-2c\  
set statusline+=%#Cursor#
set statusline+=\ %3p%%\  

