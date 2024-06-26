" {{{ Vim Options

set nocompatible
set rnu
set nu
syntax enable
set nolist 
set tabstop=8
set softtabstop=4
set shiftwidth=4
set noexpandtab
set hlsearch
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

filetype plugin on
set foldenable
set foldmethod=marker

"yank to clipboard
if has("clipboard")
    set clipboard=unnamed " copy to the system clipboard

    if has("unnamedplus") " X11 support
	set clipboard+=unnamedplus
    endif
endif
" paste from clipboard
vnoremap <C-c> :w !pbcopy<CR><CR> noremap <C-v> :r !pbpaste<CR><CR>

" }}}

" {{{ Colors

"colorscheme desert
set colorcolumn=80
highlight colorcolumn ctermbg=0
let &colorcolumn=join(range(81,999),",")

" }}}

" {{{ Mappings

" Autocompletion
inoremap <S-Tab> <C-N>

" Keyboard Shortcuts
" map <C-T> :w <bar> :Latexmk <CR>
autocmd FileType python map <buffer> <C-T> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType tex map <buffer> <C-T> :w<CR>:exec ':Latexmk'<CR>
autocmd filetype cpp nnoremap <buffer> <C-T> :w<CR> :!g++ % -ggdb -o %:r -std=c++17 && ./%:r<CR>
map - dd p
nnoremap <C-U> :vsplit <CR>
nnoremap <C-I> :split <CR>
nnoremap <C-Y> :resize -10 <CR>
nnoremap <C-O> :resize +10 <CR>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-W> :q <CR>
nnoremap <CR> :noh<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

"}}}

" {{{ Plugin Manager ---

 if empty(glob('~/.vim/autoload/plug.vim'))
   silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
     \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
 endif

" }}}

" {{{ GitHub Plugins

 call plug#begin()
 
 Plug 'LaTeX-Box-Team/LaTeX-Box'
 Plug 'brennier/quicktex'
 Plug 'tpope/vim-fugitive'
 Plug 'tpope/vim-surround'
 Plug 'tpope/vim-eunuch'
 Plug 'powerline/powerline'
 "Plug 'prabirshrestha/vim-lsp' # For error messages in C++
 "Plug 'vim-scripts/AutoComplPop'
 
 call plug#end()

" }}}

" {{{ TeX Options

let g:quicktex_tex = {
    \' '   : "\<ESC>:call search('<+.*+>')\<CR>\"_c/+>/e\<CR>",
    \'m'   : '\( <+++> \)<++>',
    \'M'   : "\\[ \<CR><+++>\<CR>\\]\<CR><++>",
    \'prf' : "\\begin{proof}\<CR><+++>\<CR>\\end{proof}",
    \'sec' : '\section{<+++>} <++>', 
    \'sec*' : '\section*{<+++>} <++>', 
    \'ssec': '\subsection{<+++>} <++>',
    \'ssec*': '\subsection*{<+++>} <++>',
    \'bf'  : '\textbf{<+++>} <++>',
    \'ita'  : '\textit{<+++>} <++>',
    \'cod' : '\texttt{<+++>} <++>',
    \'incl': "\\includegraphics[width=.<+++>\\textwidth]{<++>}",
    \'sincl': "\\subcaptionbox{\\ }[.<+++>\\textwidth]\<CR>{\\includegraphics[width=.<++>\\textwidth]{<++>}}\<CR><++>",
    \'tabl': "\\begin{table}[H]\<CR>\\centering\<CR><+++>\<CR>\\end{table}",
    \'fig' : "\\begin{figure}[H]\<CR>\\centering\<CR><+++>\<CR>\\caption{<++>}\<CR>\\end{figure}",
    \'sfig': "\\begin{subfigure}[b]{0.5\\linewidth}\<CR>\\centering\<CR><+++> \<CR>\\end{subfigure}",
    \'tabular': "\\begin{tabular}{lcc}\<CR>\\toprule\<CR><+++> & <++> & <++> \\\\ \\midrule\<CR><++> & <++> & <++> \<CR>\\bottomrule\<CR>\\end{tabular}",
    \'enu' : "\\begin{enumerate}\<CR>\\item <+++>\<CR>\\end{enumerate}",
    \'ite' : "\\begin{itemize}\<CR>\\item <+++>\<CR>\\end{itemize}",
    \'algn' : "\\begin{align}\<CR><+++>\<CR>\\end{align}\<CR><++>",
    \'algn*': "\\begin{align*}\<CR><+++>\<CR>\\end{align*}\<CR><++>",
    \'f1'  : "% {{{ <+++>",
    \'f2'  : "% }}} <+++>",
    \'fold': "% {{{ <+++>\<CR><++>\<CR>% }}}",
    \'lst' : "\\begin{lstlisting}\<CR><+++>\<CR>\\end{lstlisting}",
    \'frm' : "\\begin{frame}{<+++>}\<CR><++>\<CR>\\end{frame}",
    \'minip': "\\begin{minipage}{<+++>\\textwidth}\<CR><++>\<CR>\\end{minipage}",
    \'verb': '\verb`<+++>` <++>',
    \'sf'  : '\textsf{<+++>} <++>',
    \'ver' : '<verbatim><+++></verbatim><++>',
    \'lit' : '<literal><+++></literal><++>',
    \'col' : '\color{<+++>}<++>\color{black}<++>'
    \}

let g:quicktex_math = {
    \' '    : "\<ESC>:call search('<+.*+>')\<CR>\"_c/+>/e\<CR>",
    \'cal'  : '\mathcal{<+++>} <++> ',
    \'set'  : '\{ <+++> \} <++>',
    \'frac' : '\frac{<+++>}{<++>} <++>',
    \'si'   : '\SI{<+++>}{<++>} <++>',
    \'bf'   : '\mathbf{<+++>} <++>',
    \'text'  : '\text{<+++>} <++>',
    \'cod'  : '\texttt{<+++>} <++>',
    \'sub'  : '_{<+++>} <++>',
    \'pow'  : '^{<+++>} <++>',
    \'sqrt' : '\sqrt{<+++>} <++>',
    \'sum'  : '\sum_{<+++>} <++>',
    \'exp'  : '\exp \left( <+++> \right) <++>',
    \'sin'  : '\sin \left( <+++> \right) <++>',
    \'cos'  : '\cos \left( <+++> \right) <++>',
    \'tan'  : '\tan \left( <+++> \right) <++>',
    \'log'  : '\log \left( <+++> \right) <++>',
    \'lef' : '\left( <+++> \right) <++>',
    \'lefc' : '\left\{ <+++> \right\} <++>',
    \'lefs' : '\left[ <+++> \right] <++>',
    \'lef|' : '\left| <+++> \right| <++>',
    \'lef<' : '\langle <+++> \rangle <++>',
    \'ln'   : '\ln \big( <+++> \big) <++>',
    \'and'  : '\quad \text{and} \quad <+++>',
    \'alpha': '\alpha <+++>',
    \'beta' : '\beta <+++>',
    \'gamma': '\gamma <+++>',
    \'delta': '\delta <+++>',
    \'Delta': '\Delta <+++>',
    \'epsilon': '\varepsilon <+++>',
    \'eta'  : '\eta <+++>',
    \'theta': '\theta <+++>',
    \'lambda': '\lambda <+++>',
    \'mu'   : '\mu <+++>',
    \'nu'   : '\nu <+++>',
    \'zeta' : '\zeta <+++>',
    \'pi'   : '\pi <+++>',
    \'rho'  : '\rho <+++>',
    \'phi'  : '\phi <+++>',
    \'varphi': '\varphi <+++>',
    \'psi'  : '\psi <+++>',
    \'sig'  : '\sigma <+++>',
    \'tau'  : '\tau <+++>',
    \'chi'  : '\chi <+++>',
    \'del'  : '\partial <+++>',
    \'omega': '\omega <+++>',
    \'per'  : '\per <+++>',
    \'deg'  : '^{\circ} <+++>',
    \'times': '\cdot <+++>', 
    \'array': "\\begin{array}{lcr}\<CR><+++> & <++> & <++> \\\\ \<CR><++> & <++> & <++> \<CR>\\end{array}\<CR><++>",
    \'mat'  : "\\left(\\begin{matrix}<+++> & <++> \\\\ <++> & <++> \\end{matrix}\\right)\<CR><++>",
    \'mat3'  : "\\left(\<CR>\\begin{matrix}\<CR><+++> & <++> & <++> \\\\ \<CR><++> & <++> & <++> \\\\ \<CR><++> & <++> & <++> \<CR>\\end{matrix}\<CR>\\right)\<CR><++>",
    \'centi' : '\centi <+++>',
    \'milli': '\milli <+++>',
    \'micro': '\micro <+++>',
    \'nano' : '\nano <+++>',
    \'pico' : '\pico <+++>',
    \'femto': '\femto <+++>',
    \'kilo' : '\kilo <+++>',
    \'mega' : '\mega <+++>',
    \'giga' : '\giga <+++>',
    \'tera' : '\tera <+++>',
    \'meter': '\meter <+++>',
    \'second': '\second <+++>',
    \'gram' : '\gram <+++>',
    \'ev'   : '\electronvolt <+++>',
    \'bar'  : '\bar <+++>',
    \'joule': '\joule <+++>',
    \'kelvin': '\kelvin <+++>',
    \'hz'   : '\hertz <+++>',
    \'mm'   : '\milli\meter <+++>',
    \'mum'  : '\micro\meter <+++>',
    \'nm'   : '\nano\meter <+++>',
    \'pm'   : '\pico\meter <+++>',
    \'fm'   : '\femto\meter <+++>',
    \'km'   : '\kilo\meter <+++>',
    \'ms'   : '\milli\second <+++>',
    \'mus'  : '\micro\second <+++>',
    \'ns'   : '\nano\second <+++>',
    \'ps'   : '\pico\second <+++>',
    \'fs'   : '\femto\second <+++>',
    \'kev'  : '\kilo\electronvolt <+++>',
    \'Mev'  : '\mega\electronvolt <+++>',
    \'Gev'  : '\giga\electronvolt <+++>',
    \'Tev'  : '\tera\electronvolt <+++>'
    \}

let g:Latex_Box_latemk_async=0
let g:LatexBox_output_type="pdf"
let g:tex_flavor='latex'
let g:LatexBox_quickfix=2
let g:LatexBox_latexmk_options="-pdf -xelatex"

" }}}

" {{{ lsp
" Taken from
" https://jonasdevlieghere.com/vim-lsp-clangd/
if executable('clangd')
    augroup lsp_clangd
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'clangd',
                    \ 'cmd': {server_info->['clangd']},
                    \ 'whitelist': ['c', 'C', 'cxx', 'h', 'cpp', 'objc', 'objcpp'],
                    \ })
        autocmd FileType h setlocal omnifunc=lsp#complete
        autocmd FileType c setlocal omnifunc=lsp#complete
        autocmd FileType C setlocal omnifunc=lsp#complete
        autocmd FileType cpp setlocal omnifunc=lsp#complete
        autocmd FileType cxx setlocal omnifunc=lsp#complete
        autocmd FileType objc setlocal omnifunc=lsp#complete
        autocmd FileType objcpp setlocal omnifunc=lsp#complete
    augroup end
endif
" }}}

"set  rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
"set laststatus=2
"set t_Co=256
"
