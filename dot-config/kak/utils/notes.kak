# todo: load daily template if note isn't existing
# use an interactive menu for accessing date tool strings
# maybe integrate with notes too?
declare-option str notes_dir %sh{echo "$HOME/notes"}
declare-option str dnotes_dir "%opt{notes_dir}/daily"
declare-option str dnotes_temp  "%opt{dnotes_dir}/template.md"

declare-user-mode notes
map global user n "<esc>:enter-user-mode notes<ret>" -docstring "notes"
map global notes n ":dnote<ret>" -docstring "daily"
map global notes t ":edit %opt{notes_dir}/todo.md<ret>" -docstring "todo"
map global notes c ":cd %opt{notes_dir}<ret>" -docstring "cd to notes dir"

define-command dnote -params 0.. -docstring %{
        dnote <date>: opens the daily note for <date> in a buffer

        <date> is a date string compatible with `date -d'. It need not
        be quoted; arguments are stringified.

        Must set %opt{dnotes_dir} to designate location of daily notes. Must
        be a flat directory structure. %opt{dnotes_temp} can be set to
        the path of a note template.
} %{
    evaluate-commands %sh{
        if [ $# -lt 1 ]; then
            date=$(date +%F)
        else
            date=$(date -d "$*" +%F)
        fi
        file="$kak_opt_dnotes_dir/$date.md"
        printf "edit %s\n" $file
        if [ ! -e "$file" ] && [ -e "$kak_opt_dnotes_temp" ]; then
            printf "execute-keys '!cat $kak_opt_dnotes_temp'<ret>\n"
        fi
    }
}
complete-command dnote shell-script-candidates %{
    fd -t f . $kak_opt_dnotes_dir | sed 's,.*/,,; s/\.[^.]*$//' | sort -r
}
