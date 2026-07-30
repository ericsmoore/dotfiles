define-command vsplit -params .. -command-completion \
    -docstring "vsplit [<commands>]: split tmux vertically" %{
    tmux-terminal-horizontal kak -c %val{session} -e "%arg{@}"
}

define-command split -params .. -command-completion \
    -docstring "split [<commands>]: split tmux horizontally" %{
    tmux-terminal-vertical kak -c %val{session} -e "%arg{@}"
}

define-command tabnew -params .. -command-completion \
    -docstring "tabnew [<commands>]: create new tmux window" %{
    tmux-terminal-window kak -c %val{session} -e "%arg{@}"
}
