" wylacza kompatybilnosc z vi
set nocompatible

" ignorowanie wielkosci liter podczas wyszukiwania
set ignorecase

" nie przewijaj ekrany podczas wyszukiwania
set noincsearch

" podswietlenie wszystkich wyszukanych wynikow
set hlsearch

" tytul na pasku konsoli
set title

" parametry title
set titlestring=vim:\ [\ %{hostname()}\ ]\ [\ %F\ ]

" parametry statusline
"set statusline=[\ %{hostname()}\ ]\ \ [\ %F\ ]\ %m%r%h%w\%=[\ Type=%Y\ ]\ \ [\ x=%04v,y=%04l\ ]\ \ [\ %p%%\ ]\ \ [\ Length=%L\ ]

" numerowanie linii
set number

" kolorowanie kolumny z kursorem
set cursorline

" zawsze pokazuj statusline
set laststatus=2

" zachowuje wciecia poprzedniej linii
" set autoindent

" w ostatniej linii nie wyswietla @
set display=lastline,uhex

" tak wygladaja znaki niedrukowalne (F4)
set listchars=tab:>-,trail:-,eol:$

" wlacza uzycie backspace
set backspace=indent,eol,start

" wylacza ladowanie foldow
set nofoldenable

" spacje zamiast tabulatora,
set expandtab

" 4-spacjowy tabulator
set tabstop=4

" 4-spacjowe przesuwanie >
set shiftwidth=4

" history undo dla kazdego bufora
set hidden

" otwiera nowe okno ponizej
set splitbelow

" nowe okno po prawej
set splitright

" ilosc wpisow w historii
set history=50

" kodowanie
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

" start scrolling gdy kursor jest 1 linie od krawedzi strony
set scrolloff=1

" pokazuje w prawym dolnym rogu nr linii w vmode lub aktualna komende
set showcmd

" wklejanie
set pastetoggle=<F5>

" 256 kolorow jesli nie ma ustawionej $TERM=xterm-256color
set t_Co=256

" kolory
colorscheme radar

" podswietlanie skladni
syntax on

" wylaczenie podswietlania nawiasow
let loaded_matchparen=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" abbreviations

iab date# <C-R>=strftime("%Y%m%d %H:%M:%S")<CR>
iab date822# <C-R>=strftime("%a, %d %b %Y %H:%M:%S %z")<CR>
iab hostname# <C-R>=hostname()<CR>
iab path# <C-R>=expand("%:p")<CR>
iab pwd# <C-R>=expand("%:p:h")<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" mappings

" wstawia nowa linie bez pozostania w insert mode
map <Esc><Enter>  O<Esc>
map <Enter> o<Esc>

" podczas ctrl+e/y kursor nie przemieszcza sie z tekstem
map <C-E> <C-E>j
map <C-Y> <C-Y>k

" podczas formatowania > nie traci zaznaczenia
vmap > :><CR>gv
vmap < :<<CR>gv

" tabulator (jeden klik zamiast dwoch)
nmap > >>
nmap < <<

" wstawienie jednego znaku
map ii i<Space><Esc>r

" Alt i l,h,j,k jako "kursory" w insert mode
imap <Esc>l <Right>
imap <Esc>h <Left>
imap <Esc>j <Esc>l<Down>
imap <Esc>k <Esc>l<Up>

" mapowanie q i w
nmap <Tab>q :q!<CR>
nmap <Tab>w :wa<CR>
nmap qw :wqa<CR>

" kasowanie wyszukanych wynikow \c
nmap <Leader>c :let @/=""<CR>

" zamyka buffer i przechodzi do poprzedniego
nmap <Leader>bd :bd!<CR>

" przelacza pomiedzy otwartymi plikami
nmap <Space>] :bn<CR>
nmap <Space>[ :bp<CR>
nmap <Space><Right> :bn<CR>
nmap <Space><Left> :bp<CR>

" formatowanie tekstu (kazda linia osobno)
nmap Q :!fmt -s -w72<CR>
vmap Q :!fmt -s -w72<CR>

" numerowanie linii
nmap <F2> :set number!<Bar>set number?<CR>

" wyswietlanie indentLine
nmap <F3> :IndentLinesToggle<CR>:LeadingSpaceToggle<CR>

" niedrukowalne znaki
nmap <F4> :set list!<Bar>set list?<CR>

" kolorowanie kolumny z kursorem
nmap <F6> :set cursorline!<Bar>set cursorline?<CR>

" przeladowanie konfiguracji
nmap <F12> :source $MYVIMRC<Bar>:echo "$MYVIMRC reloaded"<CR>

" kasowanie bez kopiowania
nnoremap <Leader>d "_d
vnoremap <Leader>d "_d

" podmiana textu w vmode na ten z bufora
vnoremap <Leader>r "_dP

" pozostawia wciecie po nacisnieciu Esc
nnoremap o ox<BS>
nnoremap O Ox<BS>
inoremap <CR> <CR>x<BS>

" dopelnianie calego powyzszego slowa
inoremap <expr> <C-Y> matchstr(getline(line('.')-1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" functions

" kasowanie trailing spaces podczas zapisu
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins

""" airline
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_section_c = airline#section#create(['%{hostname()}:%F'])
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <Space>1 <Plug>AirlineSelectTab1
nmap <Space>2 <Plug>AirlineSelectTab2
nmap <Space>3 <Plug>AirlineSelectTab3
nmap <Space>4 <Plug>AirlineSelectTab4
nmap <Space>5 <Plug>AirlineSelectTab5
nmap <Space>6 <Plug>AirlineSelectTab6
nmap <Space>7 <Plug>AirlineSelectTab7
nmap <Space>8 <Plug>AirlineSelectTab8
nmap <Space>9 <Plug>AirlineSelectTab9
nmap <Space>h <Plug>AirlineSelectPrevTab
nmap <Space>l <Plug>AirlineSelectNextTab

""" commentary
set commentstring=#\ %s
autocmd FileType vim setlocal commentstring=\"\ %s
autocmd FileType lua setlocal commentstring=\--\ %s
autocmd FileType groovy setlocal commentstring=\//\ %s
autocmd FileType javascript setlocal commentstring=\//\ %s
autocmd FileType tex setlocal commentstring=\%\ %s

autocmd FileType yaml setlocal tabstop=2 shiftwidth=2
autocmd FileType tf setlocal tabstop=2 shiftwidth=2
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2
autocmd FileType make setlocal noexpandtab

autocmd BufEnter *.pp,*.erb setfiletype ruby
autocmd BufEnter *.json,*.j2 setfiletype javascript
autocmd BufEnter *.tf,*.tfvars setfiletype tf
autocmd BufEnter Jenkinsfile,*.Jenkinsfile,Jenkinsfile.* setfiletype groovy

""" easy align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

""" indentline
let g:indentLine_enabled = 1
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_char = '┊'
let g:indentLine_fileType = []
let g:indentLine_color_term = 239
let g:indentLine_color_tty_light = 7
let g:indentLine_color_dark = 1
" let g:indentLine_setConceal = 0
