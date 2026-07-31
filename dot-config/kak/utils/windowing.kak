define-command vsplit -params .. -command-completion \
    -docstring "vsplit [<commands>]: split tmux vertically" %{
    "%opt{windowing_module}-terminal-horizontal" \
    kak -c %val{session} -e "%arg{@}"
}

define-command split -params .. -command-completion \
    -docstring "split [<commands>]: split tmux horizontally" %{
    "%opt{windowing_module}-terminal-vertical" \
    kak -c %val{session} -e "%arg{@}"
}

define-command tabnew -params .. -command-completion \
    -docstring "tabnew [<commands>]: create new tmux window" %{
    "%opt{windowing_module}-terminal-window" \
    kak -c %val{session} -e "%arg{@}"
}
