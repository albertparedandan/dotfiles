set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Blinking cursor on INSERT mode
set guicursor=i:blinkon100

 " auto-install vim-plug                                                                                                                
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim')) 
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall                                                                                                      
endif

call plug#begin('~/.config/nvim/plugged')        
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
call plug#end()

" Bind Ctrl + n to NERDTreeToggle
nmap <C-n> :NERDTreeToggle<CR>

" ctrlp
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

let g:NERDTreeGitStatusWithFlags = 1

" Change ESC to jk combination
inoremap jk <ESC>

"" Highlight currently open buffer in NERDTree
"autocmd BufEnter * call SyncTree()
"
"" sync open file with NERDTree
"" " Check if NERDTree is open or active
"function! IsNERDTreeOpen()        
"  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
"endfunction
"
"" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
"" file, and we're not in vimdiff
"function! SyncTree()
"  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
"    NERDTreeFind
"    wincmd p
"  endif
"endfunction
