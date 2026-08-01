define-command hsplit -params .. -command-completion \
    -docstring "hsplit [<commands>]: new horizontal split" %{
    "%opt{windowing_module}-terminal-horizontal" \
    kak -c %val{session} -e "%arg{@}"
}

define-command vsplit -params .. -command-completion \
    -docstring "vsplit [<commands>]: new vertical split" %{
    "%opt{windowing_module}-terminal-vertical" \
    kak -c %val{session} -e "%arg{@}"
}

define-command newtab -params .. -command-completion \
    -docstring "newtab [<commands>]: new tab" %{
    "%opt{windowing_module}-terminal-window" \
    kak -c %val{session} -e "%arg{@}"
}
