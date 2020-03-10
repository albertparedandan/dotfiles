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

#### Solve Vim 8.1 bug giving warnings about locale EN_HK
export LC_ALL=en_US.UTF-8
