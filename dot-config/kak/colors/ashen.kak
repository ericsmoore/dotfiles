# Ashen for Kakoune
# Supports kak-tree-sitter and kak-lsp
# Author: Daniel Fichtinger
# License: MIT
# Upstream: https://codeberg.org/ficd/kak-ashen

## private
try %{
    define-command true nop
    define-command false fail
}

# palette
declare-option str cursorline "rgb:151515"
declare-option str text "rgb:b4b4b4"
declare-option str red_flame "rgb:C53030"
declare-option str red_glowing "rgb:DF6464"
declare-option str red_ember "rgb:B14242"
declare-option str orange_glow "rgb:D87C4A"
declare-option str orange_blaze "rgb:C4693D"
declare-option str orange_muted "rgb:6D3B22"
declare-option str orange_smolder "rgb:E49A44"
declare-option str orange_golden "rgb:E5A72A"
declare-option str golden_muted "rgb:6D4D0D"
declare-option str brown "rgb:89492a"
declare-option str brown_dark "rgb:322119"
declare-option str brown_darker "rgb:22150F"
declare-option str blue "rgb:4A8B8B"
declare-option str background "rgb:000000"
declare-option str g_1 "rgb:e5e5e5"
declare-option str g_2 "rgb:d5d5d5"
declare-option str g_3 "rgb:b4b4b4"
declare-option str g_4 "rgb:a7a7a7"
declare-option str g_5 "rgb:949494"
declare-option str g_6 "rgb:737373"
declare-option str g_7 "rgb:535353"
declare-option str g_8 "rgb:323232"
declare-option str g_9 "rgb:212121"
declare-option str g_10 "rgb:1d1d1d"
declare-option str g_11 "rgb:191919"
declare-option str g_12 "rgb:151515"

# Built-in Code Highlighting
set-face global value         "%opt{blue}"
set-face global type          "%opt{blue}"
set-face global variable      "%opt{g_3}"
set-face global module        "%opt{orange_glow}+b"
set-face global function      "%opt{g_3}+b"
set-face global string        "%opt{red_glowing}"
set-face global keyword       "%opt{red_ember}"
set-face global operator      "%opt{orange_glow}"
set-face global attribute     "%opt{g_4}+i"
set-face global comment       "%opt{g_6}+i"
set-face global documentation comment
set-face global meta          "%opt{red_ember}"
set-face global builtin       function

# Markdown Highlighting
set-face global title     "%opt{red_glowing}+b"
set-face global header    "%opt{red_glowing}"
set-face global mono      "%opt{g_2},%opt{g_10}"
set-face global block     "%opt{g_2},%opt{g_10}"
set-face global link      "%opt{red_glowing}+ui"
set-face global bullet    "%opt{orange_glow}"
set-face global list      "%opt{orange_glow}"

# SPECIAL CURSOR BLOCK
# We implement a Helix-like cursor changing color.
# Off by default; ashen_dynamic_cursor option must be set to true.

try %{
    declare-option bool ashen_dynamic_cursor false
    declare-option bool ashen_eol_cursor false
}
# Helix-like insert/normal mode cursor
set-face global PrimaryCursorNormal   "%opt{background},%opt{orange_blaze}+b"
set-face global SecondaryCursorNormal "%opt{background},%opt{orange_muted}"
set-face global PrimaryCursorInsert   "%opt{background},%opt{g_5}+b"
set-face global SecondaryCursorInsert "%opt{background},%opt{g_7}"

set-face global PrimaryCursorNormalEol   "%opt{background},%opt{orange_smolder}+b"
set-face global SecondaryCursorNormalEol "%opt{background},%opt{golden_muted}"
set-face global PrimaryCursorInsertEol   "%opt{background},%opt{g_3}+b"
set-face global SecondaryCursorInsertEol "%opt{background},%opt{g_7}"

set-face global PrimaryCursor   PrimaryCursorNormal
set-face global SecondaryCursor SecondaryCursorNormal

# try %{
#     hook -always global WinCreate .* %{
#         try %{
#             %opt{ashen_eol_cursor}
#             set-face window PrimaryCursorEol   PrimaryCursorNormalEol
#             set-face window SecondaryCursorEol SecondaryCursorNormalEol
#         } catch %{
#             set-face window PrimaryCursorEol   PrimaryCursorNormal
#             set-face window SecondaryCursorEol SecondaryCursorNormal
#         }
#     }

#     define-command -hidden ashen-set-cursor-mode -params 1 %{
#         try %{
#             %opt{ashen_dynamic_cursor}
#             set-face window PrimaryCursor %exp{PrimaryCursor%arg{1}}
#             set-face window SecondaryCursor %exp{SecondaryCursor%arg{1}}
#             try %{
#                 %opt{ashen_eol_cursor}
#                 set-face window PrimaryCursorEol %exp{PrimaryCursor%arg{1}Eol}
#                 set-face window SecondaryCursorEol %exp{SecondaryCursor%arg{1}Eol}
#             } catch %{
#                 set-face window PrimaryCursorEol %exp{PrimaryCursor%arg{1}}
#                 set-face window SecondaryCursorEol %exp{SecondaryCursor%arg{1}}
#             }
#         }
#     }

#     hook global ModeChange (push|pop):.*insert %{
#     	ashen-set-cursor-mode "Insert"
#     }

#     hook global ModeChange (push|pop):insert:.* %{
#     	ashen-set-cursor-mode "Normal"
#     }
# }

# Built-in UI
set-face global Default            "%opt{text},%opt{background}"
set-face global PrimarySelection      ",%opt{brown_dark}+g"
set-face global SecondarySelection    ",%opt{brown_darker}+g"
set-face global PrimaryCursorEol   PrimaryCursor
set-face global SecondaryCursorEol SecondaryCursor
set-face global LineNumbers        "%opt{g_8}"
set-face global LineNumberCursor   "%opt{g_5}"
set-face global LineNumbersWrapped LineNumbers
set-face global MenuForeground     "%opt{background},%opt{orange_blaze}+b"
set-face global MenuBackground     "%opt{g_3},%opt{g_9}"
set-face global MenuInfo           "%opt{text},%opt{g_9}"
set-face global Information        MenuInfo
set-face global InlineInformation  "%opt{g_6}+i"
set-face global Error              "%opt{red_flame},%opt{background}"
set-face global DiagnosticError    ",,%opt{red_flame}+c"
set-face global DiagnosticWarning  ",,%opt{orange_golden}+c"
set-face global StatusLine         "%opt{g_3},%opt{g_9}"
set-face global StatusLineMode     "%opt{orange_glow}+b"
set-face global StatusLineInfo     "%opt{red_ember}"
set-face global StatusLineValue    "%opt{blue}"
set-face global StatusCursor       "%opt{background},%opt{g_3}+b"
set-face global Prompt             "%opt{orange_glow}"
set-face global MatchingChar       "%opt{orange_smolder}+uf"
set-face global BufferPadding      LineNumbers
set-face global Whitespace         "%opt{g_7}+f"
set-face global WrapMarker         "%opt{g_7}+f"

# kak-lsp
set-face global InlayHint "%opt{g_5},%opt{g_12}+i"
set-face global parameter "@ts_variable_paramter"
set-face global enum "@ts_type_enum_variant"
set-face global InlayDiagnosticError Error
set-face global InlayDiagnosticWarning "%opt{orange_golden}"
set-face global InlayDiagnosticInfo "%opt{g_2}"
set-face global InlayDiagnosticHint "%opt{g_4}"
set-face global LineFlagError "%opt{red_flame}"
set-face global LineFlagWarning "%opt{orange_golden}"
set-face global LineFlagInfo "%opt{g_2}"
set-face global LineFlagHint "%opt{g_4}"
set-face global DiagnosticError ",,%opt{red_flame}+c"
set-face global DiagnosticWarning ",,%opt{orange_golden}+c"
set-face global DiagnosticInfo ",,%opt{g_2}+c"
set-face global DiagnosticHint ",,%opt{g_4}+c"
# Infobox faces
set-face global InfoDefault Information
set-face global InfoBlock block
set-face global InfoBlockQuote block
set-face global InfoBullet bullet
set-face global InfoHeader header
set-face global InfoLink link
set-face global InfoLinkMono header
set-face global InfoMono mono
set-face global InfoRule comment
set-face global InfoDiagnosticError InlayDiagnosticError
set-face global InfoDiagnosticHint InlayDiagnosticHint
set-face global InfoDiagnosticInformation InlayDiagnosticInfo
set-face global InfoDiagnosticWarning InlayDiagnosticWarning
