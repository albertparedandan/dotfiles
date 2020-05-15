set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
luafile $HOME/.config/nvim/lua/plug-colorizer.lua
