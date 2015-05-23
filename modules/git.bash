# ========================================================================== #
# FILE:        $BOILERPLATE_MODULES_HOME/git.bash
# AUTHOR:      Nathan Farrar <nathan.farrar.@gmail.com>
# DESCRIPTION: {{{
# }}}
# ========================================================================== #
_git_is_instance() {
  if [[ "git rev-parse --is-inside-work-tree &> /dev/null)" != 'true' ]] && git rev-parse --quiet --verify HEAD &> /dev/null
  then
    return 0
  fi
  return 1
}

_git_parse_branch() {
  if _git_is_instance
  then
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1 /'
  fi
}

_git_new() {
  if _git_is_instance
  then
    if [[ $(git ls-files --other --exclude-standard 2> /dev/null) ]]
    then
      echo "N "
    fi
  fi
}

_git_staged() {
  if _git_is_instance
  then
    git diff-index --cached --quiet --ignore-submodules HEAD 2> /dev/null
    (( $? && $? != 128 )) && echo "S "
  fi
}

_git_modified() {
  if _git_is_instance
  then
    git diff --no-ext-diff --ignore-submodules --quiet --exit-code || echo "M "
  fi
}

git_root() {
  echo "$(git rev-parse --show-toplevel)"
}

if [[ ${BOILERPLATE_TESTS:-0} -eq 1 ]] || [[ "$BASH_SOURCE" == "$0" ]]; then
  true
fi