export PATH=$HOME/bin:/usr/local/bin:$PATH

source ~/.zplug/init.zsh

zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"

zplug "plugins/git",   from:oh-my-zsh
# zplug "vi-mode", from:oh-my-zsh

zplug "junegunn/fzf"
zplug "joshskidmore/zsh-fzf-history-search"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

autoload -U compinit; compinit

export HISTSIZE=100000
export SAVEHIST=$HISTSIZE
export HISTFILE=$HOME/.local/zsh_history

setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt inc_append_history
setopt share_history
setopt hist_ignore_space

setopt correct_all
setopt auto_list
setopt auto_menu
setopt always_to_end

zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion

[[ -o interactive ]] && stty -ixon

bindkey '^ ' autosuggest-accept
bindkey '^n' autosuggest-accept

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'

EDITOR="nvim"

cd() {
    if ! z "$@"; then
        builtin cd "$@" || return
    fi
    echo -e "\n $(pwd)\n"
    ls -alh
}

ls_func() { ls -alh; }
chpwd_functions+=(ls_func)

# alias python=python3
# alias python='QT_QPA_PLATFORM=wayland python3'
alias pip=pip3
alias jqt='QT_QPA_PLATFORM=wayland jupyter qtconsole'
alias ltmk='latexmk -interaction=nonstopmode -halt-on-error -pdf -output-directory=build'
alias ll="ls -alh"
alias pypy="$HOME/tmp/pypy/pypy3.11-v7.3.20-linux64/bin/pypy"
alias open="xdg-open"

export VISUAL=vim
export EDITOR="$VISUAL"
export NVM_DIR="/home/aymen/.nvm"
export PATH="$PATH:/home/aymen/.local/bin/"
export PATH="$PATH:/Users/aymen/Library/Python/3.8/bin"
export PATH="$PATH:/usr/local/bin/python3.10"
export PATH="$PATH:/usr/local/bin/ltex-ls"
export PATH="$PATH:/usr/local/texlive/2025/bin/x86_64-linux"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
export PATH="$HOME/tmp/texpresso/build:$PATH"
export PATH="$PATH:/home/aymen/.nvm/versions/node/v22.19.0/bin"

eval "$(zoxide init zsh --cmd cd)"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$HOME/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin

# opencode
export PATH=/home/aymen/.opencode/bin:$PATH

lazy_load_nvm() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
}
nvm() { lazy_load_nvm; nvm "$@"; }
node() { lazy_load_nvm; node "$@"; }
npm() { lazy_load_nvm; npm "$@"; }
npx() { lazy_load_nvm; npx "$@"; }

export ZED_ALLOW_EMULATED_GPU=0
export MESA_VK_DEVICE_SELECT=8086:46a6

eval "$(starship init zsh)"
# starship preset nerd-font-symbols -o ~/.config/starship.toml
# starship preset pure-preset -o ~/.config/starship.toml

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

export FZF_DEFAULT_OPTS="--height=30 --reverse --cycle --color=bg+:#3B4252,bg:#2E3440,spinner:#81A1C1,hl:#616E88,fg:#D8DEE9,header:#616E88,info:#81A1C1,pointer:#81A1C1,marker:#81A1C1,fg+:#D8DEE9,prompt:#81A1C1,hl+:#ebcb8b"

# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

source ~/git-repos/fzf-tab/fzf-tab.plugin.zsh

export PATH=$HOME/.local/bin:$PATH
export PATH="$HOME/tmp/zig/zig-x86_64-linux-0.15.2:$PATH"
export PATH="$HOME/.local/share/nvim-install/nvim-linux-x86_64/bin/:$PATH"
export PATH="/usr/local/texlive/2025/bin/x86_64-linux/:$PATH"
