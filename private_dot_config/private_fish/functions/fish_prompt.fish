function fish_prompt
    set -l last_status $status

    # PATH
    set_color blue
    if test "$PWD" = "$HOME"
        echo '~'
    else if test "$PWD" = "/"
        echo '/'
    else
        echo (basename "$PWD")"/"
    end

    # CMD
    if test $last_status -ne 0
        set_color red
    else
        set_color magenta
    end
    
    echo -n '❯ '
    set_color normal
end
