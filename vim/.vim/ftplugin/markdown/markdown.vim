set textwidth=79
set expandtab
set tabstop=4
set shiftwidth=4
set spell
set nocindent
set autoindent
set tw=75
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
inoremap <buffer> \itm \begin{itemize}<Esc>o\end{itemize}<Esc>o<Esc>kO\item 
inoremap <buffer> \it- \begin{itemize}<Esc>o\end{itemize}<Esc>o<Esc>kO\item[-] 
inoremap <buffer> \eqn \begin{align}<Esc>o\end{align}<Esc>o<Esc>kO
inoremap <buffer> \neqn \begin{align*}<Esc>o\end{align*}<Esc>o<Esc>kO
inoremap <buffer> \eqa \begin{eqnarray}<Esc>o\end{eqnarray}<Esc>o<Esc>kO
inoremap <buffer> \fig \begin{figure}[H]<CR><CR>\end{figure}<Esc>ki\centering<CR>\includegraphics[width=\textwidth]{<++>}<CR>\caption{<++>}<Esc><CR><CR>i<++><Esc>3k3wli
inoremap <buffer> \ul \underline{}<++><Esc>bli
inoremap <buffer> ` `'<Esc>i
inoremap <buffer> \ode \frac{\dd }{\dd <++>}<++><Esc>bbbi
inoremap <buffer> \pde \frac{\partial }{\partial <++>}<++><Esc>bbbi

" move to next placeholder
inoremap <buffer> <C-l> <Esc>/<++><CR><Esc>cf>
