##### Completion
zstyle ':completion:*' menu select
bindkey '^[[Z' reverse-menu-complete

#### Exa Alias
if (( $+commands[hub] )); then
    alias g="hub"
elif (( $+commands[git] )); then
    alias g="git"
fi

if (( $+commands[exa] )); then
    alias l='exa --classify --color=always --color-scale --all --ignore-glob ".git" --long --git --header'

    function li() {
        local ignore=""
        for i in ${1+"$@"}; do
            ignore+="|$i"
        done
        exa --classify --color=always --color-scale --all --ignore-glob ".git$ignore" --long --git --header
    }

    alias lgd='exa --classify --color=always --color-scale --grid --all --ignore-glob ".git" --long --git --header'

    alias lg='exa --classify --color=always --color-scale --grid --all --ignore-glob ".*" --long --git --header'

    function lgi() {
        local ignore=""
        for i in ${1+"$@"}; do
            ignore+="|$i"
        done
        exa --classify --color=always --color-scale --grid --all --ignore-glob ".git$ignore" --long --git --header
    }

    alias lt='exa --classify --color=always --color-scale --tree --ignore-glob ".git" --long --git --header'

    function lti() {
        local ignore=""
        for i in ${1+"$@"}; do
            ignore+="|$i"
        done
        exa --classify --color=always --color-scale --tree --ignore-glob ".git$ignore" --long --git --header
    }

    function ltl() {
        exa --classify --color=always --color-scale --tree --level=$1 --ignore-glob ".git" --long --git --header
    }

    function ltli() {
        local ignore=""
        for i in ${2+"$@"}; do
            ignore+="|$i"
        done
        exa --classify --color=always --color-scale --tree --level=$1 --ignore-glob ".git$ignore" --long --git --header
    }
else
    alias l='ls -FGA'
fi

#### Directory Alias
alias -g ...="../.."
alias -g ....="../../.."
alias -g .....="../../../.."
alias -g ......="../../../../.."
alias -g .......="../../../../../.."
alias -g ........="../../../../../../.."
alias -g .........="../../../../../../../.."
alias -g ..........="../../../../../../../../.."

#### Solve Vim 8.1 bug giving warnings about locale EN_HK
export LC_ALL=en_US.UTF-8

#### Aliases for nvim, vim and vi
if (( $+commands[nvim] )); then
    alias v="nvim"
elif (( $+commands[vim] )); then
    alias v="vim"
elif (( $+commands[vi] )); then
    alias v="vi"
fi

#### Case insensitive
zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}'
autoload -U compinit && compinit

#### Enter directory path to automatically cd into the directory
setopt autocd

#### Enable vim-mode and key bindings
# bindkey -v

#### Enable MacOS aliases
if [[ `uname` == "Darwin" ]]; then
  alias quicklook='qlmanage -p "$@" >& /dev/null'
fi

if [[ -d /Applications/XAMPP/xamppfiles ]]; then
    alias start_xampp='sudo /Applications/XAMPP/xamppfiles/xampp start'
    alias stop_xampp='sudo /Applications/XAMPP/xamppfiles/xampp stop'
fi

#### Neofetch
neofetch
