hook global WinSetOption filetype=(c|cpp) %{
    set-option window formatcmd "clang-format -style='{BasedOnStyle: LLVM, IndentCaseLabels: true, IndentCaseBlocks: true, IndentWidth: 4}' "
}
hook global WinSetOption filetype=(haskell) %{
    set-option window tabstop 2
    set-option window indentwidth 2
}
hook global WinSetOption filetype=(html|css) %{
    set-option window indentwidth 2
}
hook global WinSetOption filetype=(latex) %{
    set-option window tabstop 2
    set-option window indentwidth 2
    set-option window formatcmd 'fmt -w 80'

    map window user = "<a-i>p:format-selections<ret>" -docstring "wrap in paragraph"
}
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

hook global WinSetOption filetype=(markdown) %{
    remove-highlighter window/ruler
    remove-highlighter window/line-numbers

    set-option window autowrap_column 66
    # set-option window autowrap_format_paragraph yes
    set-option window formatcmd 'fmt -w 66'
    # autowrap-enable

    set-option window autocomplete prompt

    set-option window comment_block_begin '<!--'
    set-option window comment_block_end '-->'

    map window user c ":markdown_toggle_checkbox<ret>" -docstring "toggle checkbox"
    map window user = "<a-i>p:format-selections<ret>" -docstring "wrap in paragraph"
}
hook global WinSetOption filetype=python %{
    set-option window formatcmd "ruff format -"
}
