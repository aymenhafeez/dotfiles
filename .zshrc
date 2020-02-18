# ---------------------------- aymen hafeez zshrc -----------------------------

# oh-my-zsh path
export ZSH="/home/aymen/.oh-my-zsh"

ZSH_THEME="mh"
# PROMPT='[%{$fg[white]%}%B%n%b:%{$fg[red]%}%~%{$reset_color%}]$(git_prompt_info)%(!.#.$) '
# RPROMPT='$(vi_mode_prompt_info)'
TERM=xterm-256color

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS=true

ENABLE_CORRECTION='false'

COMPLETION_WAITING_DOTS='true'

plugins=(git vi-mode zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

stty -ixon

# preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='gvim'
fi

cd() { builtin cd "$@" && ls -l -a -F; }

alias python=python3
alias ipython='/home/aymen/.local/bin/ipython'
alias jupyter='/home/aymen/.local/bin/jupyter'
alias jupyter-qtconsole='/home/aymen/.local/bin/jupyter-qtconsole'
alias jupyter-notebook='/home/aymen/.local/bin/jupyter-notebook'

# common tmux sessions
alias tma='tmux attach -t tmux || tmux new -s tmux'
alias tmb='tmux attach -t WEBSITE || tmux new -s WEBSITE'
alias tmn='tmux attach -t NOTES || tmux new -s NOTES'
alias tmp='tmux attach -t PYTHON || tmux new -s PYTHON'
alias tmr='tmux attach -t REG || tmux new -s REG'
alias tmt='tmux attach -t TODO || tmux new -s TODO'
alias tmw='tmux attach -t WORK || tmux new -s WORK'
alias tanim='tmux attach -t animplotlib || tmux new -s animplotlib'
alias tvim='tmux attach -t vim-line-motion || tmux new -s vim-line-motion'

alias zc='vim ~/.zshrc'
alias szc='source ~/.zshrc'
alias vc='vim ~/.vimrc'
alias jc='vim ~/.jwmrc'
alias i3c='vim ~/.config/i3/config'
alias tmc='vim ~/.tmux.conf'
alias vxs='vim ~/.Xresources'
alias xxs='xrdb ~/.Xresources'

alias rng='ranger'
alias cl='clear'
alias lfa='ls -l -F -a'

alias ..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias d='cd ~/Documents'
alias dt='cd ~/Desktop'
alias dp='cd ~/Documents/python_files'
alias dw='cd ~/Documents/website'
alias dn='cd ~/Documents/notes/'
alias cv='cd ~/.vim'
alias wm='cd ~/Documents/clones/dwm/'

alias kybrd='./home/aymen/Documents/scripts/keyboard.sh'

alias bp='upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage'

source /home/aymen/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
