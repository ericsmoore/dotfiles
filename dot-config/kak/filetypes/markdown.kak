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

# word count in modeline
declare-option -hidden str modeline_buf_word_count_formatted ''
set-option global modelinefmt '%opt{modeline_buf_word_count_formatted}'

define-command update-modeline-buf-word-count -hidden %{
    set-option buffer modeline_buf_word_count_formatted %sh{
        echo "eval -no-hooks -verbatim write \"$kak_response_fifo\"" > \
            "$kak_command_fifo"
        count="$(wc -w < "$kak_response_fifo")"

        printf " ${count} words | "
    }
}

hook global WinSetOption filetype=(markdown) %{
    remove-highlighter window/ruler
    remove-highlighter window/line-numbers

    set-option window autowrap_column 66
    set-option window autowrap_format_paragraph yes
    set-option window formatcmd 'fmt -w 66'
    autowrap-enable

    set-option window autocomplete prompt

    set-option window comment_block_begin '<!--'
    set-option window comment_block_end '-->'

    map window user c ":markdown_toggle_checkbox<ret>" -docstring "toggle checkbox"

    hook window InsertIdle .* %{ update-modeline-buf-word-count }
    hook window NormalIdle .* %{ update-modeline-buf-word-count }
}
