# oh-my-zsh path
export ZSH='/Users/aymen/.oh-my-zsh'

# -----------------------------------------------------------------------------
# appearance 
# -----------------------------------------------------------------------------

export CLICOLOR=1

ZSH_THEME="powerlevel10k/powerlevel10k"

# POWERLEVEL9K_MODE='nerdfont-complete'

# left prompt
# .............................................................................
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir_joined vcs)

POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR="%F{030}\uf101%f"
POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR="%F{030}\uf101%f"

POWERLEVEL9K_CONTEXT_TEMPLATE='%n'
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND='clear'

POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='clear'
POWERLEVEL9K_DIR_HOME_BACKGROUND='clear'
POWERLEVEL9K_DIR_HOME_FOREGROUND='006'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='clear'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='006'
POWERLEVEL9K_DIR_ETC_BACKGROUND='clear'
POWERLEVEL9K_DIR_ETC_FOREGROUND='006'
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='#377a8f'
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3

POWERLEVEL9K_VCS_CLEAN_BACKGROUND='none'
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='003'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='none'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='005'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='none'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='166'

# right prompt
# .............................................................................
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vi_mode_joined status_joined)
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=' '
POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR='%F{006}\uf105%f'
POWERLEVEL9K_VI_INSERT_MODE_STRING='%F{015}\uf100 INSERT%f'
POWERLEVEL9K_VI_COMMAND_MODE_STRING='%F{030}\uf100 NORMAL%f'
POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND='clear'
POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='clear'

POWERLEVEL9K_STATUS_OK_BACKGROUND='clear'
POWERLEVEL9K_STATUS_OK_ICON='%F{006}\uf111%f'
POWERLEVEL9K_STATUS_ERROR_BACKGROUND='clear'
POWERLEVEL9K_STATUS_ERROR_ICON='%F{203}\uf111%f'
POWERLEVEL9K_STATUS_ERROR_FOREGROUND='green'
POWERLEVEL9K_STATUS_CROSS=true
POWERLEVEL9K_STATUS_VERBOSE=true

# -----------------------------------------------------------------------------
# general config
# -----------------------------------------------------------------------------

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

# -----------------------------------------------------------------------------
# aliases
# -----------------------------------------------------------------------------

alias python=python3
alias ipython='~/Library/Python/3.7/bin/ipython'
alias jupyter-qtconsole='~/Library/Python/3.7/bin/jupyter-qtconsole'
alias jqt=jupyter-qtconsole
alias jnb='~/Library/Python/3.7/bin/jupyter-notebook'

# Shortcuts
# .............................................................................
alias tmks='tmux kill-server'
alias tma='tmux attach -t tmux || tmux new -s tmux'
alias ci='code-insiders'
alias zshconfig='mate ~/.zshrc'
alias ohmyzsh='mate ~/.oh-my-zsh'
alias rng='ranger'
alias cl='clear'
alias lfa='ls -F -a'
alias zc='vim ~/.zshrc'
alias szc='source ~/.zshrc'
alias vc='vim ~/.vimrc'
alias chk='vim ~/.chunkwmrc'
alias rschk='brew services restart chunkwm'
alias skd='vim ~/.skhdrc'
alias rsskd='brew services restart skhd'

# Navigation
# .............................................................................
alias ..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias d='cd ~/Documents'
alias dt='cd ~/Desktop'
alias de='cd ~/Documents/work-env'
alias dp='cd ~/Documents/python_files'
alias dw='cd ~/Documents/website'
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

# -----------------------------------------------------------------------------
# startup
# -----------------------------------------------------------------------------

cl
neofetch
~/.vocab

source $ZSH/oh-my-zsh.sh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
