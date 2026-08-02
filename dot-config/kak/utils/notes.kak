declare-option str notes_dir %sh{echo "$HOME/notes"}
declare-option -hidden str note_date ""
declare-user-mode notes
declare-user-mode daily-notes

define-command cd-notes -docstring "change directory to notes" %{
    cd %opt{notes_dir}
}

define-command open-todo-note -docstring "open todos" %{
    edit "%opt{notes_dir}/todo.md"
}

define-command new-daily-note -docstring "open daily note" %{
    evaluate-commands %sh{
        today=$(date +%F)
        touch "$kak_opt_notes_dir/daily/$today.md"
        printf 'open-daily-note %s\n' "$today"
    }
}

define-command -params 1 -hidden open-daily-note %{
    try %{
        edit -existing "%opt{notes_dir}/daily/%arg{1}.md"
        set-option buffer note_date %arg{1}
    } catch %{
        echo 'no such note exists'
    }
}

define-command -hidden open-daily-mode %{
    evaluate-commands %sh{
        if [ -z $kak_opt_note_date ]; then
            printf 'new-daily-note\n'
        else
            printf 'enter-user-mode daily-notes'
        fi
    }
}

map global daily-notes n "<esc>:daily-note-next<ret>" -docstring "next day"
map global daily-notes p "<esc>:daily-note-prev<ret>" -docstring "previous day"

define-command -hidden daily-note-next %{
    open-daily-note %sh{date -d "$kak_opt_note_date +1 day" +%F}
    echo 'no next note'
}

define-command -hidden daily-note-prev %{
    open-daily-note %sh{date -d "$kak_opt_note_date -1 day" +%F}
    echo 'no previous note'
}

map global user n ":enter-user-mode notes<ret>" -docstring "notes mode"
map global notes n "<esc>:open-daily-mode<ret>" -docstring "daily"
map global notes t "<esc>:open-todo-note<ret>" -docstring "todos"
