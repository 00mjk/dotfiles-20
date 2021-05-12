# vim: set ft=zsh:

# bravoecho.zsh-theme
#
# Lightweight theme that:
#
#   * colorises the info about user and host
#   * displays the current path
#   * displays the current git branch if it's in a repo
#   * puts the prompt into a new line
#
# Originally based on the kphoen theme.

function _bravoecho_git_branch() {
  local branch_name=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

  if [[ -n "${branch_name}" ]]; then
    echo " on %{$fg[green]%}${branch_name}%{$reset_color%}"
  fi
}

if [[ "$TERM" != "dumb" ]] && [[ "$DISABLE_LS_COLORS" != "true" ]]; then
  PROMPT='[%{$fg[red]%}%n%{$reset_color%}@%{$fg[magenta]%}%m%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}$(_bravoecho_git_branch)]
%# '
else
  PROMPT='[%n@%m:%]
%# '
fi
