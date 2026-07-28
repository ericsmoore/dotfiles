define-command vsplit -params .. -command-completion \
    -docstring "vsplit [<commands>]: split sway vertically" %{
    sway-terminal-horizontal kak -c %val{session} -e "%arg{@}"
}

define-command split -params .. -command-completion \
    -docstring "split [<commands>]: split sway horizontally" %{
    sway-terminal-vertical kak -c %val{session} -e "%arg{@}"
}

define-command tabnew -params .. -command-completion \
    -docstring "tabnew [<commands>]: create new sway window" %{
    sway-terminal-window kak -c %val{session} -e "%arg{@}"
}
