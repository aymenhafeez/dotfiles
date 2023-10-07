# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

PROMPT=' %F{243}%(!.#.) %{$fg[cyan]%}%1d%{$reset_color%}%{$fg[green]%} %(!.#.) '
RPROMPT='$(vi_mode_prompt_info)%B${return_code}%b%{$fg[yellow]%}$(git_prompt_info)'

# ZSH_THEME="sorin"

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS=true

ENABLE_CORRECTION='false'

COMPLETION_WAITING_DOTS='true'

plugins=(git vi-mode)

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source $ZSH/oh-my-zsh.sh

stty -ixon

# preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='nvim'
else
    export EDITOR='gvim'
fi

cd() { builtin cd "$@" && ls -alh; }

alias lg="lazygit"
alias python=python3
alias pip=pip3
alias tmux='env TERM=screen-256color tmux'
alias tmn='tmux new -s'
alias tma='tmux a -t'
alias zc='nvim ~/.zshrc'
alias szc='source ~/.zshrc'
alias cn='cd ~/.config/nvim'
alias nv='nvim'
alias ni='nvim ~/.config/nvim/init.lua'
alias cl='clear'
alias lla='ls -lha'
alias ..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ytd='youtube-dl -o "~/Music/%(title)s.%(ext)s" -x --audio-format mp3 $1'

export VISUAL=vim
export EDITOR="$VISUAL"
export NVM_DIR="/home/aymen/.nvm"
export PATH="$PATH:/home/aymen/.local/bin/"
export HOMEBREW_NO_AUTO_UPDATE=1
export PATH="$PATH:/Users/aymen/Library/Python/3.8/bin"
export PATH="$PATH:/usr/local/bin/python3.10"
export PATH="$PATH:/usr/local/bin/ltex-ls"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export FZF_DEFAULT_OPTS='--height 35% --layout=reverse'

export FZF_DEFAULT_COMMAND='find .'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(zoxide init zsh)"
