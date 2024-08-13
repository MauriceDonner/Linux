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
autocmd FileType tex let b:coc_suggest_disable = 1
set foldenable
set foldmethod=marker

"colorscheme default
set colorcolumn=80
highlight colorcolumn ctermbg=0
let &colorcolumn=join(range(81,999),",")

"yank to clipboard
if has("clipboard")
    set clipboard=unnamed " copy to the system clipboard

    if has("unnamedplus") " X11 support
	set clipboard+=unnamedplus
    endif
endif
" paste from clipboard
vnoremap <C-c> :w !pbcopy<CR><CR> noremap <C-v> :r !pbpaste<CR><CR>

let NERDTreeMinimalUI=1
let g:coc_disable_startup_warning=1

let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=0 ctermbg=0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=12 ctermbg=12
" }}}

" Vim Bindings {{{
nnoremap <C-F> :NERDTreeToggle<CR>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <TAB> :split<CR>
inoremap jj <ESC> l
let g:Terminal_EscKey = 'jj'
" nnoremap <CR> :noh<CR> Currently disabled because of coc

nmap <F8> :TagbarToggle<CR>

" Compile Shortcut
autocmd FileType python map <buffer> <C-T> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType tex map <buffer> <C-T> :w<CR>:exec ':Latexmk'<CR>
autocmd filetype cpp nnoremap <buffer> <C-T> :w<CR> :!g++ % -ggdb -o %:r -std=c++17 && ./%:r<CR>

"}}}

" {{{ Conquerer of Completion

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

"" Remap <C-f> and <C-b> for scroll float windows/popups. Currently disabled
"" because of Nerdtree!!!
" if has('nvim-0.4.0') || has('patch-8.2.0750')
"   nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"   inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"   inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"   vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" }}}

" {{{ GitHub Plugins
call plug#begin()

Plug 'https://github.com/powerman/vim-plugin-AnsiEsc'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/tpope/vim-surround' " Quickly put brackets around things
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'https://github.com/ryanoasis/vim-devicons'
" Plug 'https://github.com/tc50cal/vim-terminal'
Plug 'https://github.com/preservim/tagbar'
Plug 'https://github.com/neoclide/coc.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'LaTeX-Box-Team/LaTeX-Box'
Plug 'brennier/quicktex'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'https://github.com/mg979/vim-visual-multi'

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
    \'hl'  : '\highlight{<+++>}<++>',
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
let g:LatexBox_quickfix=1
let g:LatexBox_latexmk_options="-pdf -xelatex"

" }}}
