" TeX mappings
augroup TeX_mappings
    autocmd!
    autocmd filetype tex,latex,markdown inoremap <buffer> $ $$<++><Esc>4hi
    autocmd filetype tex,latex,markdown inoremap <buffer> $$ $$$$<++><Esc>5hi
    autocmd filetype tex,latex,markdown inoremap <buffer> \itl \textit{}<++><Esc>bli
    autocmd filetype tex,latex,markdown inoremap <buffer> \bf \textbf{}<++><Esc>bli
    autocmd filetype tex,latex,markdown inoremap <buffer> \frac \frac{}{<++>}<++><Esc>bli
    autocmd filetype tex,latex,markdown inoremap <buffer> \int \int_{}^{<++>}<++><Esc>bli
    autocmd filetype tex,latex,markdown inoremap <buffer> \sum \sum_{}^{<++>}<++><Esc>bli
    autocmd filetype tex,latex,markdown inoremap <buffer> \sm \sum_{}<++><Esc>bli
    autocmd filetype tex,latex,markdown inoremap <buffer> \prod \prod_{}^{<++>}<++><Esc>bli
    autocmd filetype tex,latex,markdown inoremap <buffer> \prd \prod_{}<++><Esc>bli
    autocmd filetype tex,latex,markdown inoremap <buffer> \l( \left(\right)<++><Esc>3bli
    autocmd filetype tex,latex,markdown inoremap <buffer> \l[ \left[\right]<++><Esc>3bli
    autocmd filetype tex,latex,markdown inoremap <buffer> \l{ \left{\right}<++><Esc>3bli
    autocmd filetype tex,latex,markdown inoremap <buffer> \l{ \left{\right}<++><Esc>3bli
    autocmd filetype tex,latex,markdown inoremap <buffer> \eq[ \[\]<++><Esc>5hi
    autocmd filetype tex,latex,markdown inoremap <buffer> \ra $\rightarrow$
    autocmd filetype tex,latex,markdown inoremap <buffer> \bg \begin{}<Esc>
    autocmd filetype tex,latex,markdown inoremap <buffer> \eqn \begin{align}<Esc><CR>i\end{align}<Esc>ko
    autocmd filetype tex,latex,markdown inoremap <buffer> \neqn \begin{align*}<Esc><CR>i\end{align*}<Esc>ko
    autocmd filetype tex,latex,markdown inoremap <buffer> \eqa \begin{eqnarray}<Esc><CR>i\end{eqnarray}<Esc>ko
    autocmd filetype tex,latex,markdown inoremap <buffer> \fig \begin{figure}[H]<CR><CR>\end{figure}<Esc>ki\centering<CR>\includegraphics[width=\textwidth]{<++>}<CR>\caption{<++>}<Esc><CR><CR>i<++><Esc>3k3wli
    autocmd filetype tex,latex,markdown inoremap <buffer> \ul \underline{}<++><Esc>bli
    autocmd filetype tex,latex inoremap <buffer> ` `'<Esc>i
    " move to next placeholder
    autocmd filetype tex,latex,markdown inoremap <buffer> <C-l> <Esc>/<++><CR><Esc>cf>
    " compile and open/update pdf
    autocmd filetype tex,latex nnoremap <buffer> <silent> <Leader>cm :w!<CR>:!clear && pdflatex % && open %:t:r.pdf<CR><CR>
augroup END
