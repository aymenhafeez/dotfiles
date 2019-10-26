# oh-my-zsh path
export ZSH='/Users/AymenHafeez/.oh-my-zsh'

ZSH_THEME="powerlevel9k/powerlevel9k"

# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"
#POWERLEVEL9K_PROMPT_ON_NEWLINE=true
# POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
POWERLEVEL9K_STATUS_DEFAULT_BACKGROUND='blue'
POWERLEVEL9K_VI_INSERT_MODE_STRING='INSERT'
POWERLEVEL9K_VI_COMMAND_MODE_STRING='NORMAL'
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status vi_mode time)
POWERLEVEL9K_HOST_NAME_FOREGROUND='white'

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

cd() { builtin cd "$@" && ls -F -a; }

alias python=python3.7

# Shortcuts
alias ci='code-insiders'
alias c='code'
alias zshconfig='mate ~/.zshrc'
alias ohmyzsh='mate ~/.oh-my-zsh'
alias rng='ranger'
alias cl='clear'
# alias ls='ls -F -a'
alias z='vim ~/.zshrc'
alias sz='source ~/.zshrc'
alias v='vim ~/.vimrc'
alias sv='source ~/.vimrc'
alias chk='vim ~/.chunkwmrc'
alias rschk='brew services restart chunkwm'
alias skd='vim ~/.skhdrc'
alias rsskd='brew services restart skhd'

# Navigation
alias ..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias d='cd ~/Documents'
alias dt='cd ~/Desktop'
alias dd='cd ~/Documents/DESKTOP'
alias ddp='cd ~/Documents/DESKTOP/PythonStuff'
alias ddw='cd ~/Documents/DESKTOP/website-files'
alias conf='cd ~/.config'

# Show/hidden files in Finder
alias show='defaults write com.apple.finder AppleShowAllFiles -bool true; killall Finder /System/Library/CoreServices/Finder.app'
alias hide='defaults write com.apple.finder AppleShowAllFiles -bool false; killall Finder /System/Library/CoreServices/Finder.app'

# Show/hide icons on desktop
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"

# Reload shell
alias reload="exec ${SHELL} -l"

# Show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# Recursively remove '.DS_Store' files
alias clnup="find . -type f -name '*.DS_Store' -ls -delete"

# Update Ruby gems, npm and Homebrew packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update; sudo gem cleanup'


neofetch

source $ZSH/oh-my-zsh.sh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
