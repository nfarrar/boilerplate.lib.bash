# ========================================================================== #
# FILE:        $BOILERPLATE_MODULES_HOME/log.bash
# AUTHOR:      Nathan Farrar <nathan.farrar.@gmail.com>
# DESCRIPTION: {{{
#
# }}}
# ========================================================================== #


# --- [ DEFAULTS ] --------------------------------------------------------- #

_BOILERPLATE_LOG_FILE=${LOGFILE:-/tmp/boilerplate.log}
_BOILERPLATE_LOG_LEVEL=${LOGLEVEL:-info}


# Write messages to the log file if logging is enabled.
function _log_msg() {
  local _level=${1:-UNDEFINED}
  local _msg=${2:-Undefined message}

  if [[ ${LOGMSGS} == true ]]; then

    # Automatically write a log separator when the first log line is written.
    if [[ ${_LOGSTART} == false ]]; then
      _log_separator
    fi
    printf "$(_get_timestamp) %-12s%s\n" "${_level}" "${_msg}" &>> "${LOGFILE}"
  fi
}

# Display information messages (these are always displayed).
function _info() {
  local _msg="$*"
  _log_msg "INFO" "${_msg}"
  echo -e "${_GREEN}${_msg}${_NORMAL}" 1>&2
}

# Display error messages (these are always displayed).
function _error() {
  local _msg="$*"

  _log_msg "ERROR" "${_msg}"
  echo -e "${_RED}${_msg}${_NORMAL}" 1>&2
}

# Display warning messages (these are always displayed).
function _warning() {
  local _msg="$*"

  _log_msg "WARNING" "${_msg}"
  echo -e "${_MAGENTA}${_msg}${_NORMAL}" 1>&2
}

# Display debug messages (these are only displayed if DEBUG is true).
function _debug() {
  local _msg="$*"

  _log_msg "DEBUG" "${_msg}"
  if [[ ${DBGMSGS:-false} == true ]]; then
    local _msg="$*"
    echo -e "${_CYAN}${_msg}${_NORMAL}" 1>&2
  fi
}

# Displays relevant internal bash variables. Useful for verify bash internals
# are properly during execution.
function _dump_debug_state() {
  info "BASH_VERSION:   $BASH_VERSION"
  info "BASH_VERSINFO:  ${BASH_VERSINFO[@]}"
  info "PROCESS ID:     $$"
  info "ERREXIT:        $(set -o | grep errexit | cut -f2 -d$'\t')"
  info "ERRTRACE:       $(set -o | grep errtrace | cut -f2 -d$'\t')"
  info "FUNCTRACE:      $(set -o | grep functrace | cut -f2 -d$'\t')"
  info "NOUNSET:        $(set -o | grep nounset | cut -f2 -d$'\t')"
  info "PIPEFAIL:       $(set -o | grep pipefail | cut -f2 -d$'\t')"
}