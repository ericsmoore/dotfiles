hook global WinCreate .* %{
    add-highlighter window/line-numbers number-lines
}

hook global WinSetOption filetype=.* %{
    try %{ remove-highlighter window/line-numbers }
    try %{ add-highlighter window/line-numbers number-lines -relative -hlcursor -separator ""}
}

hook global WinSetOption filetype=(markdown|) %{
    try %{ remove-highlighter window/line-numbers }
}
