function zi
    if not command -sq zoxide
        functions -e zi
        fish_command_not_found zi
        return 127
    end

    set -l result (command zoxide query -i -- $argv)

    if test -n "$result"
        cd "$result"
    end
end
