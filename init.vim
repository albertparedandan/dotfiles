set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

let g:python3_host_prog = '/usr/local/bin/python3'
let g:python_host_prog = '/usr/bin/python2'

"" auto-install vim-plug                                                                                                                
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim')) 
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall                                                                                                      
endif

call plug#begin('~/.config/nvim/plugged')                 " required, all plugins must appear after this line
Plug 'vim-airline/vim-airline'                            " Airline statusbar
Plug 'vim-airline/vim-airline-themes'                     " Airline themes
Plug 'christoomey/vim-tmux-navigator'                     " Navigate through tmux and vim windows/buffers
Plug 'dracula/vim',{'as':'dracula'}                       " Dracula theme
Plug 'neoclide/coc.nvim', {'branch': 'release'}           " Autocomplete
Plug 'tpope/vim-surround'                                 " Change the character surrounding a word
Plug 'ap/vim-css-color'                                   " Enable color highlight in CSS files

if has('nvim') || has('patch-8.0.902')                    " Show diff in vim line number area
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif
call plug#end()

" Change ESC to jk combination
inoremap jk <ESC>

"""" Colours
"""" Enable sytanx highlighting
syntax on

"" 256 colors
set termguicolors

"" Set colourscheme
colorscheme dracula
set background=dark
let g:airline_theme='dracula'

"""" COC Config
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
" set cmdheight=2

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

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
