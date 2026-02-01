function cd
    if not z $argv
        builtin cd $argv
    end
    echo
    pwd
    echo
    ls -alh
end

