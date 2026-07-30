hook global WinSetOption filetype=python %{
    set-option window formatcmd "ruff format -"
}
