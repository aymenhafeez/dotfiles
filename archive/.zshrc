# ---------------------------- aymen hafeez zshrc -----------------------------

# oh-my-zsh path
export ZSH='/Users/aymen/.oh-my-zsh'

# -------------------------------- appearance ---------------------------------

ZSH_THEME="mh"
TERM=xterm-256color

# ------------------------------ general config -------------------------------

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS=true

ENABLE_CORRECTION='false'

COMPLETION_WAITING_DOTS='true'

plugins=(
    vi-mode 
    git 
    zsh-autosuggestions 
    web-search 
    osx
    brew
    extract
    history
    sudo 
)

cd() { builtin cd "$@" && exa; }

# fzf via Homebrew
if [ -e /usr/local/opt/fzf/shell/completion.zsh ]; then
  source /usr/local/opt/fzf/shell/key-bindings.zsh
  source /usr/local/opt/fzf/shell/completion.zsh
fi

# ---------------------------------- aliases ----------------------------------

alias python=python3
alias ipython='~/Library/Python/3.7/bin/ipython'
alias jupyter-qtconsole='~/Library/Python/3.7/bin/jupyter-qtconsole'
alias jqt=jupyter-qtconsole
alias jupyter-notebook='~/Library/Python/3.7/bin/jupyter-notebook'
alias jnb=jupyter-notebook

# ................................. shortcuts .................................
alias vimu='vim -u NONE'

# open tmux sessions or create if they don't already exist
alias tma='tmux attach -t tmux || tmux new -s tmux'
alias tmb='tmux attach -t WEBSITE || tmux new -s WEBSITE'
alias tmn='tmux attach -t NOTES || tmux new -s NOTES'
alias tmp='tmux attach -t PYTHON || tmux new -s PYTHON'
alias tmr='tmux attach -t REG || tmux new -s REG'
alias tmt='tmux attach -t TODO || tmux new -s TODO'
alias tmw='tmux attach -t WORK || tmux new -s WORK'

alias zc='vim ~/Documents/work-env/.zshrc'
alias szc='source ~/.zshrc'
alias vc='vim ~/Documents/work-env/vim/.vimrc'
alias tmc='vim ~/Documents/work-env/.tmux.conf'
alias chk='vim ~/Documents/work-env/.chunkwmrc'
alias rschk='brew services restart chunkwm'
alias skd='vim ~/Documents/work-env/.skhdrc'
alias rsskd='brew services restart skhd'
alias pfzf='python $(fzf)'
alias vfzf='vim $(fzf)'

alias rng='ranger'
alias cl='clear'
alias ls='exa'
alias lfa='ls -F -a'

# ................................ navigation .................................
alias ..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias d='cd ~/Documents'
alias dt='cd ~/Desktop'
alias de='cd ~/Documents/work-env'
alias dp='cd ~/Documents/python_files'
alias dw='cd ~/Documents/website'
alias dn='cd ~/Documents/notes/'
alias cv='cd ~/.vim'
alias conf='cd ~/.config'

# show/hidden files in Finder
alias show='defaults write com.apple.finder AppleShowAllFiles -bool true; killall Finder /System/Library/CoreServices/Finder.app'
alias hide='defaults write com.apple.finder AppleShowAllFiles -bool false; killall Finder /System/Library/CoreServices/Finder.app'

# show/hide icons on desktop
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"

# reload shell
alias reload="exec ${SHELL} -l"

# show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# recursively remove '.DS_Store' files
alias clnup="find . -type f -name '*.DS_Store' -ls -delete"

# update Ruby gems, npm and Homebrew packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update; sudo gem cleanup'

bindkey '^e' autosuggest-accept
bindkey '^x' autosuggest-execute

sed -n 1,20p ~/Documents/todos.org

source $ZSH/oh-my-zsh.sh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export FZF_DEFAULT_OPTS='--height 30% --layout=reverse --border'
export FZF_DEFAULT_COMMAND='find .'

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
