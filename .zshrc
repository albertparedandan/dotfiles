# Albert Paredandan
# zsh configuration
# Last updated: 17-03-2020


############################################################################
##### Completion
zstyle ':completion:*' menu select
bindkey '^[[Z' reverse-menu-complete

############################################################################
#### Aliases

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


#### Aliases for nvim, vim and vi
if (( $+commands[nvim] )); then
    alias v="nvim"
elif (( $+commands[vim] )); then
    alias v="vim"
elif (( $+commands[vi] )); then
    alias v="vi"
fi

#### Enable MacOS aliases
if [[ `uname` == "Darwin" ]]; then
  alias quicklook='qlmanage -p "$@" >& /dev/null'
fi

if [[ -d /Applications/XAMPP/xamppfiles ]]; then
    alias start_xampp='sudo /Applications/XAMPP/xamppfiles/xampp start'
    alias stop_xampp='sudo /Applications/XAMPP/xamppfiles/xampp stop'
fi

############################################################################
#### Misc

#### Show last 10 visited directories
alias ds="dirs -v | head -10"

if (( $+commands[hub] )); then
    alias g="hub"
elif (( $+commands[git] )); then
    alias g="git"
fi

#### Solve Vim 8.1 bug giving warnings about locale EN_HK
export LC_ALL=en_US.UTF-8

#### Case insensitive
zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}'
autoload -U compinit && compinit

#### Enter directory path to automatically cd into the directory
setopt autocd

#### Enable vim-mode and key bindings
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode

############################################################################
#### Prompt

#### Git prompts
# Enable parameter expansion and other substitutions in $PROMPT
setopt prompt_subst

GIT_THEME_PROMPT_DIRTY='✗'
GIT_THEME_PROMPT_UNPUSHED='+'
GIT_THEME_PROMPT_CLEAN='✓'

function parse_git_dirty() {
   if [[ -n $(git status -s 2> /dev/null |grep -v ^\# | grep -v "working directory clean" ) ]]; then
       echo -ne "%F{160}${GIT_THEME_PROMPT_DIRTY}"
   else
       echo -ne "%F{64}${GIT_THEME_PROMPT_CLEAN}"
   fi
   GIT_CURRENT_BRANCH=$(git name-rev --name-only HEAD 2> /dev/null)
   GIT_ORIGIN_UNPUSHED=$(git log origin/$GIT_CURRENT_BRANCH..$GIT_CURRENT_BRANCH --oneline 2>&1 | awk '{ print $1 }')
   if [[ $GIT_ORIGIN_UNPUSHED != "" ]]; then
       echo -e "%F{136}${GIT_THEME_PROMPT_UNPUSHED}"
   fi
}

function parse_git_branch() {
   git branch 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1) $(parse_git_dirty) /"
}

#### show vim mode on left prompt

# perform parameter expansion/command substitution in prompt
setopt PROMPT_SUBST

vim_ins_mode="[i]"
vim_cmd_mode="[n]"
vim_mode=$vim_ins_mode

function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
  vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

# define right prompts
PROMPT='%B%F{33}%~ %F{61}$(parse_git_branch)${vim_mode} %F{245}$ %f%b'
RPROMPT='%B%F{125}%n%F{245}@%F{166}%m%f%b'

############################################################################

#### Neofetch
neofetch
