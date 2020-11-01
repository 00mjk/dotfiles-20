# vim: set ft=zsh:

# bravoecho.zsh-theme
#
# A fork of kphoen that doesn't use the git plugin, and only prints the current
# branch, no info about the status.
#
# This is because the `git_prompt_info` function from the git plugin is very
# slow on large repositories.
#
# See https://github.com/win0err/aphrodite-terminal-theme for improvements on
# this basic effort.

function _bravoecho_git_branch() {
  if [[ -d "$(pwd)/.git" ]]; then
    echo " on %{$fg[green]%}$(git rev-parse --abbrev-ref HEAD)%{$reset_color%}"
  fi
}

if [[ "$TERM" != "dumb" ]] && [[ "$DISABLE_LS_COLORS" != "true" ]]; then
  PROMPT='[%{$fg[red]%}%n%{$reset_color%}@%{$fg[magenta]%}%m%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}$(_bravoecho_git_branch)]
%# '
  # display exitcode on the right when >0
  return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
  RPROMPT='${return_code}%{$reset_color%}'
else
  PROMPT='[%n@%m:%]
%# '
fi
