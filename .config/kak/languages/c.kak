hook global BufSetOption filetype=(c|cpp) %{
    set-option buffer formatcmd "clang-format -style='{BasedOnStyle: LLVM, IndentCaseLabels: true, IndentCaseBlocks: true, IndentWidth: 4}' "
}
