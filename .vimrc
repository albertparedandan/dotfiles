"""" Colors
set background=dark
highlight clear SignColumn      " clear default color in sign column
colorscheme darkblue         " default darkblue

""""  MISC
if has("clipboard")
    set clipboard=unnamed       " allow for copy and paste into MacOS clipboard
endif
if has("mouse")
    set mouse=a                 " enable mouse
endif

set clipboard=unnamed

"""" Space and Tabs
set tabstop=4                   " 4 space tab
set expandtab                   " use spaces for tabs
set softtabstop=4               " 4 space tab
set shiftwidth=4                " size of an "indent"
set autoindent                  " indent new lines
set smartindent                 " smarter autoindenting
set linebreak                   " wrap long lines better

"""" UI
set relativenumber              " set relative line numbers
set number                      " display absolute line number on current line
set showcmd                     " show command in bottom bar
set cursorline                  " highlight current line
set showmatch                   " higlight matching parenthesis
set wildmenu                    " visual autocomplete for command menu
set wildmode=list:longest,full  " better autocomplete menu
set laststatus=2                " status bar always shown
set statusline+=%F              " status bar always shows full path
"""" Searching
set ignorecase                  " ignore case when searching
set smartcase                   " override ignorecase if search pattern contains upper case characters
set incsearch                   " search as characters are entered
set hlsearch                    " highlight all matches

"""" Enable backspace like normal programs
set backspace=indent,eol,start
