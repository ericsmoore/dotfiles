hook global BufSetOption filetype=python %{
    set-option buffer formatcmd "ruff format -"
}
