# Author: Eric Moore <esmoore.com>
# License: MIT
#
# Improves sentence navigation using object modes.
# No longer gets stuck on sentences that end a line
# ---common when working with hard-wrapped text
#================================================
declare-option str surr_object_mode ''

hook global NormalKey (\[|\]|\{|\}|<a-\[>|<a-\]>|<a-\{>|<a-\}>) %{
    set-option global surr_object_mode %val{hook_param}
}

define-command -params 1 sentence %@
    evaluate-commands %sh~
        mode="$1"
        keys="$mode""s"

        case "$mode" in
            '['|'{'|'<a-[>'|'<a-{')
                printf "execute-keys '%s'" "$keys"
                exit
        esac

        case $kak_cursor_char_value in
            46|59|33|63)
                printf "execute-keys 'l%s'" "$keys" ;;
            *)
                printf "execute-keys '%s'" "$keys" ;;
        esac
    ~
@

map global object s '<esc>:sentence "%opt{surr_object_mode}"<ret>' -docstring 'sentence'
