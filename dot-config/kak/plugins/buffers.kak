# based on kakoune-buffers
# https://github.com/Delapouite/kakoune-buffers
# License: MIT
#
# modified by Eric Moore <esmoore.com>

# buflist++: names AND modified bool
# debug buffers (like *debug*, *lint*…) are excluded
declare-option -hidden str-list buffers_info

declare-option int buffers_total

# keys to use for buffer picking
declare-option str buffer_keys "1234567890qwertyuiopasdfghjklzxcvbnm"

# used to handle [+] (modified) symbol in list
define-command -hidden refresh-buffers-info %{
  set-option global buffers_info
  set-option global buffers_total 0
  # iteration over all buffers (except debug ones)
  evaluate-commands -no-hooks -buffer * %{
    set-option -add global buffers_info "%val{bufname}_%val{modified}"
  }
  evaluate-commands %sh{
    total=$(printf '%s\n' "$kak_opt_buffers_info" | tr ' ' '\n' | wc -l)
    printf "set-option global buffers_total $total"
  }
}

# used to handle # (alt) symbol in list
declare-option str alt_bufname
declare-option str current_bufname
# adjust this number to display more buffers in info
declare-option int max_list_buffers 42

hook global WinDisplay .* %{
  set-option global alt_bufname %opt{current_bufname}
  set-option global current_bufname %val{bufname}
}

declare-user-mode buffers
define-command pick-buffers -docstring 'enter buffer pick mode' %{
  refresh-buffers-info
  unmap global buffers
  evaluate-commands %sh{
    docstring() {
      if [ "$1" = true ]; then
        printf "%s+ %s" "$2" "$3"
      else
        printf "%s  %s" "$2" "$3"
      fi
    }
    index=0
    keys=" $kak_opt_buffer_keys"
    num_keys=${#kak_opt_buffer_keys}
    eval "set -- $kak_quoted_opt_buffers_info"
    while [ "$1" ]; do
      # limit lists too big
      index=$((index + 1))
      if [ "$index" -gt "$num_keys" ]; then
        break
      fi

      buf_id=$(echo ${keys} | cut -c${index})
      name=${1%_*}
      modified=${1##*_}
      if [ "$name" = "$kak_bufname" ]; then
        printf "map global buffers %s ': buffer-by-index %s<ret>' -docstring '%s'\n" ${buf_id} $index "$(docstring $modified '>' "$name")"
      elif [ "$name" = "$kak_opt_alt_bufname" ]; then
        printf "map global buffers %s ': buffer-by-index %s<ret>' -docstring '%s'\n" ${buf_id} $index "$(docstring $modified '#' "$name")"
      else
        printf "map global buffers %s ': buffer-by-index %s<ret>' -docstring '%s'\n" ${buf_id} $index "$(docstring $modified ':' "$name")"
      fi

      shift
    done
  }
  enter-user-mode buffers
}

define-command -hidden -params 1 buffer-by-index %{
  refresh-buffers-info
  evaluate-commands %sh{
    target=$1
    index=0
    eval "set -- $kak_quoted_opt_buffers_info"
    while [ "$1" ]; do
      index=$((index+1))
      name=${1%_*}
      if [ $index = $target ]; then
        printf "buffer '$name'"
      fi
      shift
    done
  }
}

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
