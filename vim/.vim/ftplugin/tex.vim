" ---------------------- Settings and mappings for LaTeX ----------------------

set tabstop=4
set shiftwidth=4
set expandtab
set tw=80
set fo+=t
setlocal spell!
set conceallevel=1
let g:tex_conceal='abdmg'

" maths
inoremap <buffer> mk<Tab> $$<++><Esc>4hi
inoremap <buffer> \[<Tab> \[<CR>\]<++><Esc>O
inoremap <buffer> \ali \begin{align}<Esc>o\end{align}<Esc>o<Esc>kO
inoremap <buffer> \nali \begin{align*}<Esc>o\end{align*}<Esc>o<Esc>kO
inoremap <buffer> \eqa \begin{eqnarray}<Esc>o\end{eqnarray}<Esc>o<Esc>kO

inoremap <buffer> \frac \frac{}{<++>}<++><Esc>bli
inoremap <buffer> \int \int_{}^{<++>}<++><Esc>bli
inoremap <buffer> \sum \sum_{}^{<++>}<++><Esc>bli
inoremap <buffer> \sm \sum_{}<++><Esc>bli
inoremap <buffer> \prod \prod_{}^{<++>}<++><Esc>bli
inoremap <buffer> \prd \prod_{}<++><Esc>bli
inoremap <buffer> \l( \left(\right)<++><Esc>3bli
inoremap <buffer> \l[ \left[\right]<++><Esc>3bli
inoremap <buffer> \l{ \left{\right}<++><Esc>3bli
inoremap <buffer> \lim \lim_{ \to <++>}<++><Esc>BBhi
inoremap <buffer> \oo \infty
inoremap <buffer> \ubr \underbrace{}<++><Esc>bli

inoremap <buffer> \ra $\rightarrow$
inoremap <buffer> \Ra $\Rightarrow$

" text
inoremap <buffer> \tt \text{}<++><Esc>bli
inoremap <buffer> \itl \textit{}<++><Esc>bli
inoremap <buffer> \bf \textbf{}<++><Esc>bli
inoremap <buffer> \thr $\therefore$
inoremap <buffer> \bg \begin{}<Esc>i
inoremap <buffer> \itm \begin{itemize}<Esc>o\end{itemize}<Esc>o<Esc>kO\item 
inoremap <buffer> \fig \begin{figure}[H]<CR><CR>\end{figure}<Esc>ki\centering<CR>\includegraphics[width=\textwidth]{<++>}<CR>\caption{<++>}<Esc><CR><CR>i<++><Esc>3k3wli
inoremap <buffer> \ul \underline{}<++><Esc>bli

" derivatives
inoremap <buffer> \ode \frac{\dd }{\dd <++>}<++><Esc>bbbi
inoremap <buffer> \sode \frac{\dd^2 }{\dd <++>^2}<++><Esc>BBi
inoremap <buffer> \pde \frac{\partial }{\partial <++>}<++><Esc>bbbi
inoremap <buffer> \spde \frac{\partial^2 }{\partial <++>^2}<++><Esc>BBi

inoremap <buffer> box<Tab> \boxed{}<Esc>i

" close environments
inoremap <buffer> ]] <Esc>?begin<CR>yypwciwend<Esc>O
nnoremap <buffer> ]] mt?begin<CR>yy`tpwciwend<Esc>

" make visual selection the numerator of a fraction
vnoremap <buffer> \<Tab> c\frac{}{}<++><Esc>bpf{li

" wrap visual selection
vnoremap <buffer> mm<Tab> c\[<CR>\]<Esc>P
vnoremap <buffer> ali<Tab> c\begin{align}<CR>\end{align}<Esc>P
vnoremap <buffer> \box<Tab> I\boxed{<Esc>A}

" move to next placeholder
inoremap <buffer> <C-l> <Esc>/<++><CR><Esc>cf>

nnoremap <buffer> \bf<Tab> Bi\textbf{<Esc>Eli}<Esc>
nnoremap <buffer> \it<Tab> Bi\textit{<Esc>Eli}<Esc>
nnoremap <buffer> \ul<Tab> Bi\underline{<Esc>Eli}<Esc>

" compile and update pdf
nnoremap <buffer> <silent> <Leader>cm :w!<CR>:!clear && pdflatex %<CR><CR>
" open in zathura
nnoremap <buffer> <silent> <Leader>prv :w!<CR>:!clear && pdflatex % && nohup zathura %:t:r.pdf &<CR><CR>

" greek letters
inoremap <buffer> \al<Tab> \alpha
inoremap <buffer> \Al<Tab> \alpha
inoremap <buffer> \be<Tab> \beta
inoremap <buffer> \Be<Tab> \Beta
inoremap <buffer> \ga<Tab> \gamma
inoremap <buffer> \Ga<Tab> \Gamma
inoremap <buffer> \de<Tab> \delta
inoremap <buffer> \ep<Tab> \epsilon
inoremap <buffer> \Ep<Tab> \Epsilon
inoremap <buffer> \ze<Tab> \zeta
inoremap <buffer> \Ze<Tab> \Zeta
inoremap <buffer> \et<Tab> \eta
inoremap <buffer> \Et<Tab> \Eta
inoremap <buffer> \th<Tab> \theta
inoremap <buffer> \Th<Tab> \Theta
inoremap <buffer> \io<Tab> \iota
inoremap <buffer> \Io<Tab> \Iota
inoremap <buffer> \ka<Tab> \kappa
inoremap <buffer> \Ka<Tab> \Kappa
inoremap <buffer> \la<Tab> \lambda
inoremap <buffer> \La<Tab> \Lambda
inoremap <buffer> \mu<Tab> \mu
inoremap <buffer> \Mu<Tab> \Mu
inoremap <buffer> \nu<Tab> \nu
inoremap <buffer> \Nu<Tab> \Nu
inoremap <buffer> \xi<Tab> \xi
inoremap <buffer> \Xi<Tab> \Xi
inoremap <buffer> \oc<Tab> \omicron
inoremap <buffer> \Oc<Tab> \Omicron
inoremap <buffer> \pi<Tab> \pi
inoremap <buffer> \Pi<Tab> \Pi
inoremap <buffer> \ph<Tab> \phi
inoremap <buffer> \Ph<Tab> \Phi
inoremap <buffer> \rh<Tab> \rho
inoremap <buffer> \Rh<Tab> \Rho
inoremap <buffer> \si<Tab> \sigma
inoremap <buffer> \Si<Tab> \Sigma
inoremap <buffer> \ta<Tab> \tau
inoremap <buffer> \Ta<Tab> \Tau
inoremap <buffer> \up<Tab> \upsilon
inoremap <buffer> \Up<Tab> \Upsilon
inoremap <buffer> \ch<Tab> \chi
inoremap <buffer> \Ch<Tab> \Chi
inoremap <buffer> \ps<Tab> \psi
inoremap <buffer> \Ps<Tab> \Psi
inoremap <buffer> \og<Tab> \omega
inoremap <buffer> \Og<Tab> \Omega
