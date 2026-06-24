define-command file-picker-prompt %{
    prompt -menu -shell-script-candidates \
        'fd . --exclude ".git" --exclude "*.pdf" --hidden --type f --follow --ignore-file=.kakignore' \
        open: %{ edit -existing %val{text} }
}

define-command -params 1.. file-picker %{
    edit -existing %arg{@}
}
complete-command -menu file-picker shell-script-candidates \
    'fd . --exclude ".git" --exclude "*.pdf" --hidden --type f --follow --ignore-file=.kakignore'

define-command buffer-picker %{
    prompt -menu -buffer-completion 'open buffer:' %{ buffer %val{text} }
}

define-command delete-buffer-picker %{
    prompt -menu -buffer-completion 'delete buffer:' %{ delete-buffer %val{text} }
}
