"Plugins----
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'preservim/NERDTree'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
Plugin 'rafi/awesome-vim-colorschemes'
Plugin 'tribela/vim-transparent'

" autocompletion
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'mattn/vim-lsp-settings'

call vundle#end()
"--------

filetype indent plugin on
syntax on

set backspace=indent,eol,start
set autoindent
set expandtab
set softtabstop=4
set tabstop=4
set smarttab
set smartindent
set cindent
if has('mouse')
    set mouse=a
endif

set number
set laststatus=2
set visualbell
set t_vb=
set wildmenu
set showcmd
set ignorecase
set smartcase
set shiftround
set shiftwidth=4

set clipboard=unnamedplus
set encoding=utf-8


set colorcolumn=80
"set textwidth=80

" autocomplete list options
set completeopt=longest,menuone,popuphidden
set completepopup=highlight:Pmenu,border:off
" autocomplete suggestions menu colors
highlight Pmenu ctermbg=gray
highlight PmenuSel ctermbg=lightblue
" use tab for autocomplete suggestions
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

"NERDTree------
noremap <C-T> :NERDTreeToggle <cr>
let NERDTreeShowHidden=1 "Show secret files
let NERDTreeQuitOnOpen=1 "Quit NERDTree when open file
"-------------
"
"ColorScheme----
set background=dark
set termguicolors
colorscheme onedark
let g:airline_theme='onedark'
"-----

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

autocmd Filetype {cs,py,c,cpp,h} call Completion()
function Completion()
    inoremap {      {}<Left>
    inoremap {<CR>  <CR>{<CR>}<Esc>O
    inoremap {{     {
        inoremap {}     {}

        inoremap (  ()<Left>
        inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
        inoremap <expr> <BS>  strpart(getline('.'), col('.')-2, 2) == "()" ? "\<BS><Del>" : strpart(getline('.'), col('.')-2, 2) == "''" ? "\<BS><Del>" : strpart(getline('.'), col('.')-2, 2) == "\"\"" ? "\<BS><Del>" : "\<BS>"

        inoremap [  []<Left>
        inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"

        inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>"
        inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"

        inoremap for<Space> for ()<Left>
        inoremap if<Space> if ()<Left>
        inoremap if<Tab> if ()<Left>
endfunction


"exe code in C
nnoremap <F3> :call RunCode()<CR>
function RunCode()
    if &ft == 'c'
    w !gcc -Wall -Wextra -Werror -std=c99 -O1 -o main *.c && ./main && rm ./main
    " w !make && make run
  elseif &ft == 'python'
    w !python %:p
  elseif &ft == "cs"
    w !dotnet run
  else
    w !make && make run
  endif
endfunction
