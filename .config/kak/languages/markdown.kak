define-command markdown_toggle_checkbox %{
    evaluate-commands -draft %{
        execute-keys -save-regs "" xs\[.\]<ret>h
        evaluate-commands -itersel %{
            execute-keys -save-regs "" y
            set-register dquote %sh{
                if [ "$kak_reg_dquote" = " " ]; then echo "x"; else echo " "; fi
            }
            execute-keys R
        }
    }
}

hook global WinSetOption filetype=(markdown|) %{
    add-highlighter window/wrap wrap -word -width 80
    map buffer user c ":markdown_toggle_checkbox<ret>" -docstring "toggle checkbox"
}
