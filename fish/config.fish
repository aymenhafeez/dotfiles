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

set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
