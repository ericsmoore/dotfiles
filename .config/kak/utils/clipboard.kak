declare-option -docstring %{
    Command for copying to system clipboard.
} str clipboard_copy_cmd ''

declare-option -docstring %{
    Command for copying to system clipboard.
} str clipboard_paste_cmd ''


declare-option int clip_selcount 0

define-command -hidden clip-trim %{
    try %{
        execute-keys <a-k>\n<ret>
        execute-keys bjGjd
    }
}

define-command -docstring %{
    clip-copy [-split]: copy selections to system clipboard
        Set the clipboard_copy_cmd option to change the command
    Switches:
        -split  ensure each selection separated by newline
} -params 0..1 clipboard-copy %{
    # preserve registers
    evaluate-commands -save-regs 'a|' %{
        set-option local clip_selcount %val{selection_count}
        # copy selections
        execute-keys '"ay'
        # set shell register to copy command
        set-register | %opt{clipboard_copy_cmd}
        # branch based on switch
        execute-keys %sh{
            if [ "$kak_opt_clip_selcount" -gt 1 ]; then
                echo ': edit -scratch<ret>'
                if [ ${#} = 1 ] && [ ${1} = '-split' ]; then
                    # paste all
                    # reduce selections to those without newline
                    # append a newline
                    # delete extra newlines
                    # select all, pipe to copy cmd
                    echo '"a<a-P><a-K>\n<ret>a<ret><esc>'
                    echo 'gj: clip-trim<ret>'
                    echo '%<a-|><ret>'
                else
                    # paste all, select all, pipe to copy cmd
                    echo '"a<a-P>%<a-|><ret>'
                fi
                echo ": delete-buffer<ret>"
            else
                echo '<a-|><ret>'
            fi
        }
    }
}
evaluate-commands %sh{
    case $(uname) in
        Linux)
            if [ -n "$WAYLAND_DISPLAY" ]; then
                copy="wl-copy -p"; paste="wl-paste -p";
            else
                copy="xclip -i"; paste="xclip -o";
            fi
            ;;
        Darwin) copy="pbcopy"; paste="pbpaste";
    esac

    printf "set-option global clipboard_copy_cmd '%s'\n" "$copy"
    printf "set-option global clipboard_paste_cmd '%s'\n" "$paste"
}

map global user p "<a-!>%opt{clipboard_paste_cmd}<ret>" -docstring "paste (after) from clipboard" 
map global user P "!%opt{clipboard_paste_cmd}<ret>" -docstring "paste (before) from clipboard"
map global user Y ":clipboard-copy<ret>:echo -markup %{{Information}copied selections to system clipboard}<ret>" -docstring "yank to system"
map global user y ":clipboard-copy -split<ret>:echo -markup %{{Information}copied selections by line to system clipboard}<ret>" -docstring "yank to system"
map global user R "|%opt{clipboard_paste_cmd}<ret>" -docstring "replace from clipboard"

