set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

"" auto-install vim-plug                                                                                                                
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim')) 
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall                                                                                                      
endif

call plug#begin('~/.config/nvim/plugged')        
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files
Plug 'dracula/vim',{'as':'dracula'}
call plug#end()

" ctrlp
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

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
