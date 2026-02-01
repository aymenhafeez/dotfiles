bind --erase --preset \cf

function zi_key
    zi $argv
end

bind -M insert  \cf 'zi; commandline -f repaint'
bind -M default \cf 'zi; commandline -f repaint'

bind -M insert \cp history-search-backward
bind -M insert \cn history-search-forward
bind -M default \cp history-search-backward
bind -M default \cn history-search-forward

bind -M insert \c] accept-autosuggestion
bind -M default \c] accept-autosuggestion
