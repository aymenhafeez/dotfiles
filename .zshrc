# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# # Path to your oh-my-zsh installation.
# export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME="spaceship"
#
source "$HOME/antigen.zsh"

# # Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# ENABLE_CORRECTION='true'
#
# COMPLETION_WAITING_DOTS='true'

antigen bundle git
antigen bundle vi-mode
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zdharma-continuum/fast-syntax-highlighting

antigen apply

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

stty -ixon

bindkey '^ ' autosuggest-accept
bindkey '^n' autosuggest-accept

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'

# preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='nvim'
else
    export EDITOR='gvim'
fi

# cd() {
#     if ! z "$@"; then
#         builtin cd "$@" || return
#     fi
#     echo -e "\n $(pwd)\n"
#     ls -alh
# }

# ls_func() { ls -alh; }
# chpwd_functions+=(ls_func)

# alias python=python3
alias python='QT_QPA_PLATFORM=wayland python3'
alias pip=pip3
alias jqt='QT_QPA_PLATFORM=wayland jupyter qtconsole'
alias ltmk='latexmk -interaction=nonstopmode -halt-on-error -pdf -output-directory=build'

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

eval "$(starship init zsh)"
starship preset nerd-font-symbols -o ~/.config/starship.toml

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
