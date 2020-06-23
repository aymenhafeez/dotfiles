# aymenhafeez zshrc

# oh-my-zsh path
export ZSH="/home/aymen/.oh-my-zsh"

if [[ "$TERM" == "dumb" ]]; then
    PROMPT='%{$fg[green]%}%B%n%b:%{$fg[blue]%}%~%{$reset_color%}%{$reset_color%}%(!.#.$) '
    RPROMPT='$(vi_mode_prompt_info)%B${return_code}%b%{$fg[yellow]%}$(git_prompt_info)'
else
    ZSH_THEME="bira"
fi

# PROMPT='%{$fg[green]%}%B%n%b:%{$fg[blue]%}%~%{$reset_color%}%{$fg[yellow]%}$(git_prompt_info)%{$reset_color%}%(!.#.$) '
# RPROMPT='$(vi_mode_prompt_info)%B${return_code}%b'

# PROMPT='╭─%{$fg[green]%}%B%n@%m%b %{$terminfo[bold]$fg[blue]%}%~ %{$fg[yellow]%}$(git_prompt_info)%{$reset_color%}
# ╰─%(!.#.$) '
# RPROMPT='$(vi_mode_prompt_info)%B${return_code}%b'

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS=true

ENABLE_CORRECTION='false'

COMPLETION_WAITING_DOTS='true'

plugins=(git vi-mode zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# stop vim freezing on C-s
stty -ixon

# preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='gvim'
fi

cd() { builtin cd "$@" && ls -alh --group-directories-first; }

alias python=python3
alias tmn='tmux new -s'
alias tma='tmux a -t'
alias zc='vim ~/.zshrc'
alias szc='source ~/.zshrc'
alias vc='vim ~/.vimrc'
alias cvim='vim ~/.vim/'
alias jc='vim ~/.jwmrc'
alias vxs='vim ~/.Xresources'
alias xxs='xrdb ~/.Xresources'
alias sx='sxiv'
alias rng='ranger'
alias cl='clear'
alias lla='ls -lha'
alias ..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias d='cd ~/Documents'
alias dt='cd ~/Desktop'
alias dp='cd ~/Documents/python_files'
alias dw='cd ~/Documents/website'
alias dn='cd ~/Dropbox//notes/'
alias ds='cd ~/Documents/scripts/'
alias cv='cd ~/.vim'
alias ytd='youtube-dl -o "~/Music/%(title)s.%(ext)s" -x --audio-format mp3 $1'
alias kybrd='source ~/Documents/scripts/keyboard.sh'
alias open='xdg-open'
alias sx='sxiv'
alias autoremove='sudo pacman -Rcns $(pacman -Qdtq)'

source /home/aymen/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# search pacman with fzf
# press space to view package info
pacs() {
    sudo pacman -Syy $(pacman -Ssq | fzf -m --preview="pacman -Si {}" --preview-window=:hidden --bind=space:toggle-preview)
}

export VISUAL=vim
export EDITOR="$VISUAL"
export NVM_DIR="/home/aymen/.nvm"
export PATH="$PATH:/home/aymen/.local/bin/"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export FZF_DEFAULT_OPTS='--height 35% --layout=reverse'

export FZF_DEFAULT_COMMAND='find .'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
