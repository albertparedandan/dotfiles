# Albert Paredandan

############################################################################
#### Zplug

export ZPLUG_HOME=$(brew --prefix)/opt/zplug

if [[ -f $ZPLUG_HOME/init.zsh ]]; then
    source $ZPLUG_HOME/init.zsh

    zplug "zplug/zplug", hook-build:"zplug --self-manage"

    if ! zplug check; then
        zplug install
    fi

    zplug load
fi

#### Dracula Theme ZSH
zplug "dracula/zsh", as:theme

############################################################################
##### Completion
zstyle ':completion:*' menu select
bindkey '^[[Z' reverse-menu-complete

############################################################################
##### NVM
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

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

#### Enable hub alias
if (( $+commands[hub] )); then
    alias g="hub"
elif (( $+commands[git] )); then
    alias g="git"
fi

#### Alias for cp and mv prompts
# confirm before overwrite
alias cp="cp -i"
alias mv="mv -i"

############################################################################
#### Misc

#### Church
function snotes() {
  if [ "$1" != "" ] 
  then
    pandoc "$1" -f docx+empty_paragraphs -t markdown-raw_attribute -s --wrap=none --indent --preserve-tabs --strip-comments -o sermon.md
  else
    echo "At least 1 file needed to convert sermon notes"
  fi
}

#### Show last 10 visited directories
alias ds="dirs -v | head -10"
setopt autopushd
setopt pushdminus

#### Solve Vim 8.1 bug giving warnings about locale EN_HK
export LC_ALL=en_US.UTF-8

#### Case insensitive
zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}'

##### HUB Options
## To enable hub autocompletion, visit https://github.com/github/hub/tree/master/etc#zsh
fpath=(~/.zsh/completions $fpath) 
autoload -U compinit && compinit

## Github_token 
#export GITHUB_TOKEN=


#### Enter directory path to automatically cd into the directory
setopt autocd

#### Enable vim-mode and key bindings
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins '^a'    beginning-of-line
bindkey -M viins '^e'    end-of-line

############################################################################
#### Prompt

#### Enable parameter expansion and other substitutions in $PROMPT
setopt prompt_subst

function prompt_git_info {
  emulate -LR zsh
  # Branch info
  local ref
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || \
    return 0
  # Dirty info
  local dirty
  if [[ -n $(command git status --porcelain 2> /dev/null | tail -n1) ]]; then
    dirty="%{$fg[red]%}✗"
  else
    dirty="%{$fg[green]%}✓"
  fi
  # Remote info
  local remote
  if $(echo "$(command git log @{upstream}..HEAD 2> /dev/null)" | grep '^commit' &> /dev/null); then
    remote="%{$fg[yellow]%}+"
  fi
  echo "(${ref#refs/heads/}) ${dirty}${remote} "
}

#### show vim mode on left prompt
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

#### Define the prompts
PROMPT='%B%{$fg[blue]%}%~ %{$fg[yellow]%}$(prompt_git_info)${vim_mode} %{$fg[default]%}$ %f%b'
RPROMPT='%B%{$fg[magenta]%}%n%{$fg[pink]%}@%{$fg[red]%}%m%f%b'

############################################################################
#### Export PATH
path+=$HOME/.emacs.d/bin
path+=/usr/local/sbin
path+=/Library/TeX/texbin
export PATH="/usr/local/opt/node@12/bin:$PATH"
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="/Users/albertpare/Library/Python/2.7/bin:$PATH"
export PATH="/Users/albertpare/.gem/ruby/2.6.0/bin:$PATH"
export PATH=/opt/homebrew/bin:$PATH
export PATH
export SUMO_HOME="/usr/local/Cellar/sumo/1.5.0/share/sumo"
export JAVA_HOME=/usr/libexec/java_home
export JAVA_INCLUDE_DIR=/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home/include

############################################################################
#### Neofetch
neofetch
