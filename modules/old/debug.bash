#!/usr/bin/env bash

# - https://docwhat.org/tracebacks-in-bash/
# - https://gist.github.com/ahendrix/7030300
# - https://stackoverflow.com/questions/13213254/how-to-get-the-original-caller-lineno-when-executing-a-function-returning-a-non
# - https://gist.github.com/docwhat/5889193

_crib_debug_on () {
  export CRIB_DEBUG_ON=$TRUE
  shopt -s extdebug
  set -o errtrace
  set -o nounset
  set -o pipefail
  trap _crib_err_handler ERR
  _crib_log "Debugging enabled." "$CRIB_LLDBG"
}

_crib_debug_off() {
  if [[ ${CRIB_DEBUG_ON:-$FALSE} -eq $TRUE ]]; then
    export CRIB_DEBUG_ON=$FALSE
    shopt -u extdebug
    set -o errtrace
    set +o nounset
    set +o pipefail
    trap - ERR
    _crib_log "Debugging enabled." "$CRIB_LLDBG"
  fi
}

_crib_debug_pause() {
  if [[ $CRIB_DEBUG_ON -eq $TRUE ]]; then
    CRIB_DEBUG_PAUSED=$TRUE
    _crib_log "Debugging paused." "$CRIB_LLDBG"
    _crib_debug_off
  fi
}

_crib_debug_resume() {
  if [[ $CRIB_DEBUG_ON -eq $TRUE && $CRIB_DEBUG_PAUSED -eq $TRUE ]]; then
    CRIB_DEBUG_PAUSED=$FALSE
    _crib_log "Debugging resumed." "$CRIB_LLDBG"
    _crib_debug_on
  fi
}

_crib_err_handler() {
  trap - ERR
  local _ec="$?"
  local _cmd="${BASH_COMMAND:-unknown}"
  local _cmd=$(eval echo "${_cmd}")
  _crib_stacktrace 1
  _showed_stacktrace=t
  _crib_log "The command ${_cmd} exited with exit code ${_ec}." "$CRIB_LLERR"
}


_crib_stacktrace () {
  # Hide the traceback() call.
  local -i start=$(( ${1:-0} + 1 ))
  local -i end=${#BASH_SOURCE[@]}
  local -i i=0
  local -i j=0

  _crib_log "Traceback (last called is first):" "$CRIB_LLERR"
  for ((i=${start}; i < ${end}; i++)); do
    j=$(( $i - 1 ))
    local function="${FUNCNAME[$i]}"
    local file="${BASH_SOURCE[$i]}"
    local line="${BASH_LINENO[$j]}"
    _crib_log "     ${function}() in ${file}:${line}" "$CRIB_LLERR"
  done
}
