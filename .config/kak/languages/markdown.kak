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
    # add-highlighter window/wrap wrap -word -width 80

    # cheap way to cover up jerky scrolling when using wrap mode
    # set-option window scrolloff 999,4

    # map window normal j     "gd"
    # map window normal k     "gu"
    # map window normal J     "Gd"
    # map window normal K     "Gu"

    set-option window autowrap_column 66
    set-option window autowrap_format_paragraph yes
    set-option window formatcmd 'fmt -w 66'
    autowrap-enable

    set-option window autocomplete prompt
    remove-highlighter window/ruler

    set-option window comment_block_begin '<!--'
    set-option window comment_block_end '-->'

    map window normal "#" "x_:comment-block<ret>"
    map window user c ":markdown_toggle_checkbox<ret>" -docstring "toggle checkbox"
}
