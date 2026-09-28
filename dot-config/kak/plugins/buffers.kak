# based on kakoune-buffers
# https://github.com/Delapouite/kakoune-buffers
# License: MIT
#
# modified/cut by Eric Moore <esmoore.com>

# buflist++: names AND modified bool
# debug buffers (like *debug*, *lint*…) are excluded
define-command delete-buffers -docstring 'delete all saved buffers' %{
  evaluate-commands %sh{
    deleted=0
    eval "set -- $kak_quoted_buflist"
    while [ "$1" ]; do
      echo "try %{delete-buffer '$1'}"
      echo "echo -markup '{Information}$deleted buffers deleted'"
      deleted=$((deleted+1))
      shift
    done
  }
}

define-command delete-buffers-force -docstring 'delete all buffers' %{
  evaluate-commands %sh{
    deleted=0
    eval "set -- $kak_quoted_buflist"
    while [ "$1" ]; do
      echo "delete-buffer! '$1'"
      echo "echo -markup '{Information}$deleted buffers deleted'"
      deleted=$((deleted+1))
      shift
    done
  }
}

define-command buffer-only -docstring 'delete all saved buffers except current one' %{
  evaluate-commands %sh{
    deleted=0
    eval "set -- $kak_quoted_buflist"
    while [ "$1" ]; do
      if [ "$1" != "$kak_bufname" ]; then
        echo "try %{delete-buffer '$1'}"
        echo "echo -markup '{Information}$deleted buffers deleted'"
        deleted=$((deleted+1))
      fi
      shift
    done
  }
}

define-command buffer-only-force -docstring 'delete all buffers except current one' %{
  evaluate-commands %sh{
    deleted=0
    eval "set -- $kak_quoted_buflist"
    while [ "$1" ]; do
      if [ "$1" != "$kak_bufname" ]; then
        echo "delete-buffer! '$1'"
        echo "echo -markup '{Information}$deleted buffers deleted'"
        deleted=$((deleted+1))
      fi
      shift
    done
  }
}

define-command buffer-only-directory -docstring 'delete all saved buffers except the ones in the same current buffer directory' %{
  evaluate-commands %sh{
    deleted=0
    current_buffer_dir=$(dirname "$kak_bufname")
    eval "set -- $kak_quoted_buflist"
    while [ "$1" ]; do
      dir=$(dirname "$1")
      if [ $dir != "$current_buffer_dir" ]; then
        echo "try %{delete-buffer '$1'}"
        echo "echo -markup '{Information}$deleted buffers deleted'"
        deleted=$((deleted+1))
      fi
      shift
    done
  }
}

define-command edit-kakrc -docstring 'open kakrc in a new buffer' %{
  edit "%val{config}/kakrc"
}

alias global dbo buffer-only
alias global dbo! buffer-only-force
alias global dba delete-buffers
alias global dba! delete-buffers-force
