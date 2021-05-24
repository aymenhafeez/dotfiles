
" run pandoc on current markdown file and compile to/update pdf
function! pandoc#md_to_pdf() abort
    let markdown_name = expand('%:t')
    let pdf_name = expand('%:t:r')
    execute '!pandoc -o ' . pdf_name . '.pdf ' . markdown_name
endfunction

" choose PDF name
function! pandoc#md_to_pdf_new_name() abort
    let markdown_name = expand('%:t')
    let pdf_name = input("PDF name: ")
    execute '!pandoc -o ' . pdf_name . '.pdf ' . markdown_name
endfunction

" run pandoc and open PDF preview
function! pandoc#pdf_preview() abort
    execute '!clear && pandoc -s -o %:t:r.pdf % && nohup xdg-open %:t:r.pdf &'
endfunction

