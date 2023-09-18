" turn on case insensitive search
set ignorecase

" turn off incremental highlighting of the searching string while typing
set noincsearch

" highlight all search pattern matches
set hlsearch

" turn on terminal title
set title

" set terminal title to look like: vim: [ HOSTNAME ] [ /path/to/file ]
set titlestring=vim:\ [\ %{hostname()}\ ]\ [\ %F\ ]

" display line numbers
set number

" highlight current line
set cursorline

" display status line always
set laststatus=2

" do not show @ symbol when line does not fit on screen
set display=lastline,uhex

" visualize tabs, trailing spaces and line endings
set listchars=tab:>-,trail:-,eol:$

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" turn off folding
set nofoldenable

" insert space characters whenever the tab key is pressed
set expandtab

" set the number spaces to insert when the tab key is pressed
set tabstop=4

" set the number spaces to insert when > is used
set shiftwidth=4

" turn off "No write since last change' when changing buffers
set hidden

" start scrolling when the cursor is X lines from the top/bottom of the screen
set scrolloff=1

" turn on color syntax highlighting
syntax on

" use custom colorscheme
colorscheme radar

" turn off highlighting of parenthesis matching
let loaded_matchparen=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" mappings
" navigate in insert mode using Alt + h/j/k/l
imap <Esc>l <Right>
imap <Esc>h <Left>
imap <Esc>j <Esc>l<Down>
imap <Esc>k <Esc>l<Up>

" copy a word above and paste it at the current position
inoremap <expr> <C-Y> matchstr(getline(line('.')-1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')

" insert new line in normal mode
nmap <Enter> o<Esc>

" leave the cursor in place when scrolling
nmap <C-E> <C-E>j
nmap <C-Y> <C-Y>k

" shift line with one >
nmap > >>
nmap < <<

" insert one character and go to normal mode
nmap ii i<Space><Esc>r

" save/quit with Tab
nmap <Tab>q :q!<CR>
nmap <Tab>w :wa<CR>
nmap qw :wqa<CR>

" clear highlightet searches
nmap <Leader>c :let @/=""<CR>

" close active buffer
nmap <Leader>bd :bd!<CR>

" switch between open buffers
nmap <Space>] :bn<CR>
nmap <Space>[ :bp<CR>
nmap <Space><Right> :bn<CR>
nmap <Space><Left> :bp<CR>

" move current line to the High/Middle/Low part of the screen
nmap HH zt
nmap MM zz
nmap LL zb

" toggle line numbering
nmap <F2> :set number!<Bar>set number?<CR>

" toggle line indentation
nmap <F3> :IndentLinesToggle<CR>:LeadingSpaceToggle<CR>

" toggle tabs, trailing spaces and line endings
nmap <F4> :set list!<Bar>set list?<CR>

" remove line without copying
nnoremap <Leader>d "_d

" shift line and keep selected text
vmap > :><CR>gv
vmap < :<<CR>gv

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" abbreviations
iab date# <C-R>=strftime("%Y%m%d %H:%M:%S")<CR>
iab path# <C-R>=expand("%:p")<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" functions
" remove white spaces when saving a file
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()

" eliminate delay on ESC
augroup FastEscape
  autocmd!
  autocmd InsertEnter * set timeoutlen=0
  autocmd InsertLeave * set timeoutlen=1000
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" plugins
" vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" to install plugins from cli run:
" vim +PluginInstall +qall
Plugin 'hashivim/vim-terraform'
Plugin 'junegunn/vim-easy-align'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'yggdroot/indentLine'
call vundle#end()
filetype plugin indent on

" airline
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
let g:airline#extensions#tabline#fnamemod = ':h'
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#formatter = 'short_path'

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

" commentary
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
autocmd BufEnter *.tf,*.tfvars,*.tfvar setfiletype terraform
autocmd BufEnter Jenkinsfile,*Jenkinsfile,Jenkinsfile* setfiletype groovy

" easy align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" indentline
let g:indentLine_enabled = 1
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_char = '┊'
let g:indentLine_fileType = []
let g:indentLine_color_term = 239
let g:indentLine_color_tty_light = 7
let g:indentLine_color_dark = 1
" let g:indentLine_setConceal = 0
"
" terraform
let g:terraform_fmt_on_save = 1
let g:terraform_align = 1
