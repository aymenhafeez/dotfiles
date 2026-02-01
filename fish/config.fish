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

zoxide init fish | source
