function ts --description "Select or create tmux sessions with fzf"
    # Ensure fzf connects directly to the terminal tty
    set -l target (tmux list-sessions -F '#{session_name}' 2>/dev/null | fzf --print-query --query="$argv" </dev/tty | tail -1)

    if test -z "$target"
        return 1
    end

    tmux new-session -A -s "$target"
end
