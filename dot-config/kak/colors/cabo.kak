# Cabo for Kakoune
# Author: Eric Moore <esmoore.com>

# Based on: 
# Ashen for Kakoune
# Author: Daniel Fichtinger
# License: MIT
# Upstream: https://codeberg.org/ficd/kak-ashen

declare-option str cursorline "rgb:e4e4e4"
declare-option str text "rgb:1b1b1b"

declare-option str green_light "rgb:06856B"
declare-option str green_dark "rgb:015240"
declare-option str greener "rgb:028050"
declare-option str lapis "rgb:214D70"
declare-option str lapis_light "rgb:557FA1"
# declare-option str rust "rgb:702121"

declare-option str error "rgb:B33535"
declare-option str warning "rgb:E39C17"

declare-option str background "rgb:f5f5f5"

declare-option str g_1 "rgb:191919"
declare-option str g_2 "rgb:2a2a2a"
declare-option str g_3 "rgb:4b4b4b"
declare-option str g_4 "rgb:585858"
declare-option str g_5 "rgb:6b6b6b"
declare-option str g_6 "rgb:8c8c8c"
declare-option str g_7 "rgb:acacac"
declare-option str g_8 "rgb:cdcdcd"
declare-option str g_9 "rgb:dedede"
declare-option str g_10 "rgb:e2e2e2"
declare-option str g_11 "rgb:e4e4e4"
declare-option str g_12 "rgb:e8e8e8"

# Built-in Code Highlighting
set-face global value         "%opt{lapis}"
set-face global type          "%opt{lapis}"
set-face global variable      "%opt{g_1}"
set-face global module        "%opt{greener}"
set-face global function      "%opt{g_2}+b"
set-face global string        "%opt{green_light}"
set-face global keyword       "%opt{green_dark}"
set-face global operator      "%opt{greener}"
set-face global attribute     "%opt{g_2}+i"
# comment is too low constrast
set-face global comment       "%opt{g_6}+i"
set-face global documentation comment
set-face global meta          "%opt{green_dark}"
set-face global builtin       function

# Markdown Highlighting
set-face global title     "%opt{green_light}+b"
set-face global header    "%opt{green_light}"
set-face global mono      "%opt{g_2},%opt{g_10}"
set-face global block     "%opt{g_2},%opt{g_10}"
set-face global link      "%opt{green_light}+ui"
set-face global bullet    "%opt{green_light}"
set-face global list      "%opt{green_light}"

# Built-in UI
set-face global Default            "%opt{text},%opt{background}"
set-face global PrimarySelection      ",%opt{g_8}+g"
set-face global SecondarySelection    ",%opt{g_10}+g"
set-face global PrimaryCursor "%opt{background},%opt{lapis}+b"
set-face global SecondaryCursor "%opt{background},%opt{lapis_light}"
set-face global PrimaryCursorEol   PrimaryCursor
set-face global SecondaryCursorEol SecondaryCursor
set-face global LineNumbers        "%opt{g_6}"
set-face global LineNumberCursor   "%opt{g_2},,"
set-face global LineNumbersWrapped LineNumbers
set-face global MenuForeground     "%opt{background},%opt{green_dark}+b"
set-face global MenuBackground     "%opt{g_2},%opt{g_9}"
set-face global MenuInfo           "%opt{text},%opt{g_9}"
set-face global Information        MenuInfo
set-face global InlineInformation  "%opt{g_6}+i"
set-face global Error              "%opt{error},%opt{background}"
set-face global DiagnosticError    ",,%opt{error}+c"
set-face global DiagnosticWarning  ",,%opt{warning}+c"
set-face global StatusLine         "%opt{g_2},%opt{g_9}"
set-face global StatusLineMode     "%opt{greener}+b"
set-face global StatusLineInfo     "%opt{green_dark}"
set-face global StatusLineValue    "%opt{lapis}"
set-face global StatusCursor       "%opt{background},%opt{g_3}+b"
set-face global Prompt             "%opt{greener}"
set-face global MatchingChar       "%opt{warning}+uf"
set-face global BufferPadding      LineNumbers
set-face global Whitespace         "%opt{g_7}+f"
set-face global WrapMarker         "%opt{g_7}+f"

#### kak-lsp ####
set-face global InlayDiagnosticError "%opt{error}"
set-face global InlayDiagnosticWarning "%opt{warning}"
set-face global InlayDiagnosticInfo "%opt{g_2}"
set-face global InlayDiagnosticHint "%opt{g_4}"
set-face global InlayHint "%opt{g_5},%opt{g_12}+i"
set-face global LineFlagError "%opt{error}"
set-face global LineFlagWarning "%opt{warning}"
set-face global LineFlagInfo "%opt{g_2}"
set-face global LineFlagHint "%opt{g_4}"
# curly underline is unsupported in some terminals
set-face global DiagnosticError ",,%opt{error}+c"
set-face global DiagnosticWarning ",,%opt{warning}+c"
set-face global DiagnosticInfo ",,%opt{g_2}+c"
set-face global DiagnosticHint ",,%opt{g_4}+c"

## Infobox faces ##
set-face global InfoDefault Information
set-face global InfoBlock block
set-face global InfoBlockQuote block
set-face global InfoBullet bullet
set-face global InfoHeader header
set-face global InfoLink link
set-face global InfoLinkMono header
set-face global InfoMono mono
set-face global InfoRule comment

# red text, bright background
set-face global InfoDiagnosticError "%opt{error},%opt{background}"
# default text, bright background
set-face global InfoDiagnosticWarning ",%opt{background}"
# same as inlay, hints and info g_2 and g_4 respectively
set-face global InfoDiagnosticHint InlayDiagnosticHint
set-face global InfoDiagnosticInformation InlayDiagnosticInfo

