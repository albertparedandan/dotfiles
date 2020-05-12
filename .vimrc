"""" Vim Plug
"" auto-install vim-plug                                                                                                                
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim')) 
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall                                                                                                      
endif

" required, all plugins must appear after this line
call plug#begin('~/.config/nvim/plugged')
" Airline statusbar
Plug 'vim-airline/vim-airline'
" Airline themes
Plug 'vim-airline/vim-airline-themes'
" Navigate through tmux and vim windows/buffers
Plug 'christoomey/vim-tmux-navigator'
" Dracula theme
Plug 'dracula/vim',{'as':'dracula'}
" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Change the character surrounding a word
Plug 'tpope/vim-surround'
" Enable color highlight in CSS files
Plug 'ap/vim-css-color'

" Show diff in vim line number area
if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif
call plug#end()


"""" Colours
"" Enable sytanx highlighting
syntax on

"" 256 colors
set termguicolors

"" Set colourscheme
colorscheme dracula
set background=dark
let g:airline_theme='dracula'

"""" Keybindings
"" Leader key
let mapleader = " "

" Change ESC to jk combination
inoremap jk <ESC>

" stop highlighting search text
nnoremap <leader>/ :nohlsearch<CR>

" remap ESC to go out of Vim terminal
tnoremap <Esc> <C-\><C-n>

" remap Leader b to switch buffers
nnoremap <leader>b :b


"""" Space and Tabs
" 2 space tab
set tabstop=2
" use spaces for tabs
set expandtab
" 2 space tab
set softtabstop=2
" size of an indent
set shiftwidth=2
" indent new lines
set autoindent
" smarter autoindenting
set smartindent
" smart tab
set smarttab
" wrap long lines better
set linebreak

"""" UI
" set relative line numbers
set relativenumber
" display absolute line number on current line
set number
" show command in bottom bar
set showcmd
" highlight current line
set cursorline
" higlight matching parenthesis
set showmatch
" visual autocomplete for command menu
set wildmenu
" better autocomplete menu
set wildmode=list:longest,full

"" Ignore case for completion in file search
set wildignorecase
" status bar always shown
set laststatus=2
" status bar always shows full path
set statusline+=%F

"""" Searching
" ignore case when searching
set ignorecase
" override ignorecase if search pattern contains upper case characters
set smartcase
" search as characters are entered
set incsearch
" highlight all matches
set hlsearch
" Recursively find all the files in the current folder
set path+=**
" :fn is equal to :find
cabbrev fn find

"""" Splits
" Set default split is below and at the right
set splitbelow splitright
" vsf remaps to vert sfind
cabbrev vsf vert sfind
" make split from horizontal to vertical
map <Leader>th <C-w>t<C-w>H
" make split from vertical to horizontal 
map <Leader>tk <C-w>t<C-w>K
" delete buffer
map <Leader>bd :bd<cr>


""""  MISC
" allow for copy and paste into MacOS clipboard
if has("clipboard")
    set clipboard=unnamed
endif

" enable mouse
if has("mouse")
    set mouse=a
endif

" Enable backspace like normal programs
set backspace=indent,eol,start


"""" Enable buffer number in tabline
" Quick-switching of buffer index, note that these numbers are not buffer, numbers and will be different from the numbers in :ls
let g:airline#extensions#tabline#enabled = 1      " Enable tabline
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>tp <Plug>AirlineSelectPrevTab
nmap <leader>tn <Plug>AirlineSelectNextTab

"""" COC Config
"" Enable CoC python stuff
let g:python3_host_prog = '/usr/local/bin/python3'
let g:python_host_prog = '/usr/bin/python2'

let g:coc_global_extensions = [
  \ 'coc-pairs',
  \ 'coc-prettier',
  \ 'coc-snippets',
  \ ]

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
