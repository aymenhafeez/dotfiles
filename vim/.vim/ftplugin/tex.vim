" ---------------------- Settings and mappings for LaTeX ----------------------

augroup filetype_things
    autocmd!
    autocmd BufRead,BufNewFile *.tex set filetype=tex
augroup END

set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set tw=80
set fo+=t

inoremap <buffer> $ $$<++><Esc>4hi
inoremap <buffer> $$ $$$$<++><Esc>5hi
inoremap <buffer> \itl \textit{}<++><Esc>bli
inoremap <buffer> \bf \textbf{}<++><Esc>bli
inoremap <buffer> \frac \frac{}{<++>}<++><Esc>bli
inoremap <buffer> \int \int_{}^{<++>}<++><Esc>bli
inoremap <buffer> \sum \sum_{}^{<++>}<++><Esc>bli
inoremap <buffer> \sm \sum_{}<++><Esc>bli
inoremap <buffer> \prod \prod_{}^{<++>}<++><Esc>bli
inoremap <buffer> \prd \prod_{}<++><Esc>bli
inoremap <buffer> \l( \left(\right)<++><Esc>3bli
inoremap <buffer> \l[ \left[\right]<++><Esc>3bli
inoremap <buffer> \l{ \left{\right}<++><Esc>3bli
inoremap <buffer> \l{ \left{\right}<++><Esc>3bli
inoremap <buffer> \eq[ \[\]<++><Esc>5hi
inoremap <buffer> \ra $\rightarrow$
inoremap <buffer> \bg \begin{}<Esc>
inoremap <buffer> \eqn \begin{align}<Esc><CR>i\end{align}<Esc>ko
inoremap <buffer> \neqn \begin{align*}<Esc><CR>i\end{align*}<Esc>ko
inoremap <buffer> \eqa \begin{eqnarray}<Esc><CR>i\end{eqnarray}<Esc>ko
inoremap <buffer> \fig \begin{figure}[H]<CR><CR>\end{figure}<Esc>ki\centering<CR>\includegraphics[width=\textwidth]{<++>}<CR>\caption{<++>}<Esc><CR><CR>i<++><Esc>3k3wli
inoremap <buffer> \ul \underline{}<++><Esc>bli
inoremap <buffer> ` `'<Esc>i

" move to next placeholder
inoremap <buffer> <C-l> <Esc>/<++><CR><Esc>cf>

" compile and open/update pdf
nnoremap <buffer> <silent> <Leader>cm :w!<CR>:!clear && pdflatex % && open %:t:r.pdf<CR><CR>
