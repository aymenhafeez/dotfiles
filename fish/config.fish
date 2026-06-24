if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_history main
set -g fish_save_history 100000

fish_vi_key_bindings
set -g fish_vi_force_cursor 1
set -g fish_cursor_default block
set -g fish_cursor_insert line
set -g fish_cursor_replace_one underscore
set -g fish_cursor_visual block

set -l system_ssh_agent "/run/user/"(id -u)"/ssh-agent.socket"
if test -S $system_ssh_agent
    set -gx SSH_AUTH_SOCK $system_ssh_agent
end

zoxide init fish | source

if status is-interactive; and not set -q TMUX
    source ~/.config/fish/functions/ts.fish
    ts
    # If ts exits (like hitting ESC in fzf), close the window cleanly:
    exit
end
