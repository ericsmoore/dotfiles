hook global WinSetOption filetype=(c|cpp) %{
    set-option window formatcmd "clang-format -style='{BasedOnStyle: LLVM, IndentCaseLabels: true, IndentCaseBlocks: true, IndentWidth: 4}' "
}
