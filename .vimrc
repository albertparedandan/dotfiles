"""" Leader key
let mapleader = " "                               " Change leader key to <Space>

"""" Space and Tabs
set tabstop=2                                     " 4 space tab
set expandtab                                     " use spaces for tabs
set softtabstop=2                                 " 4 space tab
set shiftwidth=2                                  " size of an "indent"
set autoindent                                    " indent new lines
set smartindent                                   " smarter autoindenting
set smarttab                                      " smart tab
set linebreak                                     " wrap long lines better

"""" UI
set relativenumber                                " set relative line numbers
set number                                        " display absolute line number on current line
set showcmd                                       " show command in bottom bar
set cursorline                                    " highlight current line
set showmatch                                     " higlight matching parenthesis
set wildmenu                                      " visual autocomplete for command menu
set wildmode=list:longest,full                    " better autocomplete menu
set laststatus=2                                  " status bar always shown
set statusline+=%F                                " status bar always shows full path

"""" Searching
set ignorecase                                    " ignore case when searching
set smartcase                                     " override ignorecase if search pattern contains upper case characters
set incsearch                                     " search as characters are entered
set hlsearch                                      " highlight all matches
set path+=**                                      " Recursively find all the files in the current folder

"""" Splits
set splitbelow splitright                         " Set default split is below and at the right
cabbrev vsf vert sfind                            " vsf remaps to vert sfind
map <Leader>th <C-w>t<C-w>H                       " make split from horizontal to vertical
map <Leader>tk <C-w>t<C-w>K                       " make split from vertical to horizontal 
map <Leader>tn :bn<cr>                            " change buffer next to leader + bn
map <Leader>tp :bp<cr>                            " change buffer previous to leader + bp


""""  MISC
if has("clipboard")
    set clipboard=unnamed                         " allow for copy and paste into MacOS clipboard
endif
if has("mouse")
    set mouse=a                                   " enable mouse
endif
set clipboard=unnamed

nnoremap ,/ :nohlsearch<CR>                       " stop highlighting search text

set backspace=indent,eol,start                    " Enable backspace like normal programs

let g:airline#extensions#tabline#enabled = 1      " Enable tabline
