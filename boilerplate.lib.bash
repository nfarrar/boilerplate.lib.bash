# ========================================================================== #
# FILE:        ~/.crib/lib/bash/boilerplate.lib.bash
# AUTHOR:      Nathan Farrar <nfarrar@crunk.io>
# DESCRIPTION: boilerplate bash scripts {{{
#
#/  This is my general, all purpose, bash library. This script is designed to
#/  be sourced by another script (but not rc files), and provides a library of
#/  reusable code.
#
# }}}
# ========================================================================== #


# --- [ SOURCE GUARD ] ----------------------------------------------------- #
# Prevent the boilerplate library from being loaded multiple times.          #

[[ ${BOILERPLATE_SOURCED:-0} -eq 1 ]] && return 0 || BOILERPLATE_SOURCED=1


# --- [ RUNTIME INFO ] ----------------------------------------------------- #
# The runtime information changes as we call functions do perform tasks, so  #
# take a quick snapshot of it here, for later reference.                     #

BP_BASH_STACK=${BASH_SOURCE[@]}
BP_BASH_ARGSTRING="$*"
BP_BASH_ARGLIST="$@"
BP_BASH_VERSION="$BASH_VERSION"
BP_BASH_PID="$$"


# --- [ SETTINGS ] --------------------------------------------------------- #
# Optional, user configurable settings. These settings need to be set prior  #
# to sourcing the boilerplate.lib.bash script.                               #

BP_CALLER_PATH=${SCRIPT_PATH:-}               # script path
BP_SCRIPT_PATH=${BOILERPLATE_PATH:-}          # boilerplate script path
BP_MODULES_PATH=${MODULES_PATH:-}             # modules path

BP_REQ_POSIX=${REQUIRE_POSIX:-0}              # require posix compatibility
BP_REQ_BASH32=${REQUIRE_BASH32:-0}            # require bash32 compatibility
BP_REQ_STRICT=${REQUIRE_STRICT:-0}            # require strict execution
BP_REQ_SUDO=${REQUIRE_SUDO:-0}                # require root euid
BP_REQ_INTERACTIVE=${REQUIRE_INTERACTIVE:-0}  # require interactive tty

BP_TTYLOG_ENABLE=${CONSOLE_LOGGING:-1}        # enable console logging
BP_TTYLOG_LEVEL=${CONSOLE_LOGLEVEL:-info}     # log level to display in console

BP_SYSLOG_ENABLE=${SYSLOG_LOGGING:-0}         # enable syslog messages
BP_SYSLOG_LEVEL=${SYSLOG_LEVEL:-error}        # log level to write to syslog

BP_FILELOG_ENABLE=${FILE_LOGGING=:0}          # enable file logging
BP_FILELOG_LEVEL=${FILE_LOGLEVEL:-debug}      # log level to write to filelog
BP_FILELOG_PATH=${FILE_LOGPATH:-}             # file to write logs to



# --- [ EXIT CODES ] ------------------------------------------------------- #

_EX_SUCCESS=0               # process terminated successfully
_EX_FAILURE=1               # general-purpose failure code
_EX_BUILTIN_MISUSE=2        # misuse of shell builtins
_EX_USAGE=64                # command invoked with invalid usage arguments
_EX_DATAERR=65              # input data error
_EX_NOINPUT=66              # required input file not provided or available
_EX_NOUSER=67               # specified user does not exist
_EX_NOHOST=68               # specied host does not exist
_EX_UNAVAILABLE=69          # required service not available
_EX_SOFTWARE=70             # internal software error
_EX_OSERR=71                # general purpose operating system error
_EX_OSFILE=72               # required operating system file unavailable
_EX_CANTCREAT=73            # unable to create output file
_EX_IOERR=74                # general purpose IO error
_EX_TEMPFAIL=75             # general purpose temporary error
_EX_PROTOCOL=76             # remote system protocol error
_EX_NOPERM=77               # insufficient permissions
_EX_CONFIG=78               # general purpose configuration error

EX_NOEXEC=126               # invoked command cannot executed
EX_NOCMD=127                # command not found

# export 128+n  Fatal error signal "n"  kill -9 $PPID of script $? returns 137 (128 + 9)

EX_BADEXIT=128              # invalid argument for exit command
EX_CTRLC=130                # process terminated by control-c

# --- [ COLORS ] ----------------------------------------------------------- #

# CSC=csc='\e'
# CSC='\033'
_CSC='\x1b'
_TTY_RESET="${_CSC}[0m"
_TTY_BOLD="${_CSC}[1m"
_TTY_DIM="${_CSC}[2m"
_TTY_UNDERLINE="${_CSC}[4m"
_TTY_BLINK="${_CSC}[5m"
_TTY_REVERSE="${_CSC}[7m"
_TTY_HIDDEN="${_CSC}[8m"

_TTY_BOLD_OFF="${_CSC}[21m"
_TTY_DIM_OFF="${_CSC}[22m"
_TTY_UNDERLINE_OFF="${_CSC}[24m"
_TTY_BLINK_OFF="${_CSC}[25m"

_FG_BLACK="${_CSC}[30m"
_FG_RED="${_CSC}[31m"
_FG_GREEN="${_CSC}[32m"
_FG_YELLOW="${_CSC}[33m"
_FG_BLUE="${_CSC}[34m"
_FG_MAGENTA="${_CSC}[35m"
_FG_CYAN="${_CSC}[36m"
_FG_LIGHTGRAY="${_CSC}[37m"
# [38m is used to define extended foreground colors
_FG_DEFAULT="${_CSC}[39m"

_BG_BLACK="${_CSC}[40m"
_BG_RED="${_CSC}[41m"
_BG_GREEN="${_CSC}[42m"
_BG_YELLOW="${_CSC}[43m"
_BG_BLUE="${_CSC}[44m"
_BG_MAGENTA="${_CSC}[45m"
_BG_CYAN="${_CSC}[46m"
_BG_LIGHTGRAY="${_CSC}[47m"
# [48m is used to define extended background colors
_BG_DEFAULT="${_CSC}[49m"

_FG_DARKGRAY="${_CSC}[90m"
_FG_LIGHTRED="${_CSC}[91m"
_FG_LIGHTGREEN="${_CSC}[92m"
_FG_LIGHTYELLOW="${_CSC}[93m"
_FG_LIGHTBLUE="${_CSC}[94m"
_FG_LIGHTMAGENTA="${_CSC}[95m"
_FG_LIGHTCYAN="${_CSC}[96m"
_FG_WHITE="${_CSC}[97m"

_BG_DARKGRAY="${_CSC}[100m"
_BG_LIGHTRED="${_CSC}[101m"
_BG_LIGHTGREEN="${_CSC}[102m"
_BG_LIGHTYELLOW="${_CSC}[103m"
_BG_LIGHTBLUE="${_CSC}[104m"
_BG_LIGHTMAGENTA="${_CSC}[105m"
_BG_LIGHTCYAN="${_CSC}[106m"
_BG_WHITE="${_CSC}[107m"

# --- [ LIB ] -------------------------------------------------------------- #

# "Print" function. Wraps printf and redirects tty output to to stderr.
function _print() {
  printf "${*:-}\n" 1>&2
}

# "Return function". Dumps $1 to stdout.
function _return() {
  printf "${*:-}" 1>&1
}

# Wrapper for pushd.
function _pushd() {
  _pushd "$1" > /dev/null
}

# Wrapper for popd.
function _popd() {
  _popd "$1" > /dev/null
}

# Collapse sequential combinations of spaces and tabs into a single space.
function _collapse_whitespace() {
  _return "$(echo "$1" | sed -e "s/[[:space:]]\+/ /g")"
}

# Escape special characters in a string.
function _get_escaped_string() {
  local _unescaped="$*"
  _return "$(echo "${somevar}" | sed -e 's/[^][a-zA-Z0-9/.:?,;(){}<>=*+-]/\\&/g' )"
}

# Returns a standard timestamp with the current time.
function _get_timestamp() {
  _return "$(date +%FT%T%Z)"
}

# "Returns" true or false, depending on whether the specified command is available
# using the user's current $PATH value.
function _has_cmd() {
  if type "$1" >/dev/null 2>&1; then
    _return true
  else
    _return false
  fi
}

# Wrapper for source.
function _require_module() {
  [[ $# -ne 1 ]] && return ${_EX_USAGE}
  local _module_name="$1"
}


# --- [ COMPATIBILITY ] ---------------------------------------------------- #

if [[ $BP_REQ_POSIX -eq 1 ]]; then
  set -o posix
fi

if [[ $BP_REQ_BASH32 -eq 1 ]]; then
  [[ $BASH_VERSINFO -gt 4 ]] && shopt -s compat32 on
fi

if [[ $BP_REQ_STRICT -eq 1 ]]; then
  set -o errexit
  set -o nounset
  set -o pipefail
  set -o errtrace
  set -o functrace
fi

if [[ $BP_REQ_SUDO -eq 1 ]]; then
  if [[ "$EUID" -ne 0 ]]; then
    printf "\x1b[31m%s\x1b[0m\n" "ERROR: This script requires root privileges."
    exit 64
  fi
fi

if [[ $BP_REQ_INTERACTIVE -eq 1 ]]; then
  if [[ $- != *i* ]]; then
    printf "\x1b[31m%s\x1b[0m\n" "ERROR: This script requires an interactive TTY."
    exit 64
  fi
fi


# --- [ SCRIPT RUNTIME ] --------------------------------------------------- #

if [[ -n "$BP_CALLER_PATH" ]]; then
  BP_CALLER_NAME="$(basename "$BP_CALLER_PATH")"
  BP_CALLER_DIR="$(dirname "$BP_CAPPER_PATH")"
else
  BP_CALLER_NAME="${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]##*/}"
  BP_CALLER_DIR="$(cd "$(dirname "$BP_CALLER_NAME")" && pwd)"
  BP_CALLER_PATH="$BP_CALLER_DIR/$BP_CALLER_NAME"
fi

if [[ -n "$BP_SCRIPT_PATH" ]]; then
  BP_SCRIPT_NAME="$(basename "$BP_SCRIPT_PATH")"
  BP_SCRIPT_DIR="$(dirname "$BP_SCRIPT_PATH")"
else
  BP_SCRIPT_NAME="$(basename ${BASH_SOURCE[0]})"
  BP_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  BP_SCRIPT_PATH="$BP_SCRIPT_DIR/$BP_SCRIPT_NAME"
fi

if [[ -z "$BP_MODULES_PATH" ]]; then
  BP_MODULES_PATH="$BP_SCRIPT_DIR/modules"
fi

if [[ ! -f "$BP_CALLER_PATH" ]]; then
  _print "ERROR: $BP_CALLER_PATH does not exist."
   exit ${_EX_CONFIG}
elif [[ ! -f "$BP_SCRIPT_PATH" ]]; then
  _print "ERROR: $BP_SCRIPT_PATH does not exist."
   exit ${_EX_CONFIG}
elif [[ ! -d "$BP_MODULES_PATH" ]]; then
  _print "ERROR: $BP_MODULES_PATH does not exist."
   exit ${_EX_CONFIG}
fi


# --- [ ERROR & SIGNAL HANDLING ] ----------------------------------------- #

# Global flag used by exit & error handlers to prevent duplicate tracebacks
# from being displayed.
_DISPLAYED_TRACEBACK=false

# Display an error message and exit. This is called when things go wrong,
# so it intentionally depends on nothing else.
function errexit() {
  local _errmsg=${1:-An unexpected error occurred. Terminating.}
  local _errstatus=${2:-1}
  printf "\x1b[31;1m%s\x1b[0m\n" "${_errmsg}" 1>&2
  _traceback 1
  _DISPLAYED_TRACEBACK=true
  exit ${_errstatus}
}

# Called by errexit and exit signal handlers executed during non-successful
# termination. Displays a python-style stacktrace.
function _traceback() {
  # Hide the traceback() call.
  local -i _start_frame=$(( ${1:-0} + 1 ))
  local -i _end_frame=${#BASH_SOURCE[@]}
  local -i i=0
  local -i j=0

  printf "\x1b[31m" 1>&2
  echo "Traceback (last called is first):" 1>&2
  for ((i=${_start_frame}; i < ${_end_frame}; i++)); do
    j=$(( $i - 1 ))
    local function="${FUNCNAME[$i]}"
    local file="${BASH_SOURCE[$i]}"
    local line="${BASH_LINENO[$j]}"
    echo "     ${function}() in ${file}:${line}" 1>&2
  done
  printf "\x1b[0m" 1>&2
}

# Called on exit signal. If exit status is non-zero, the traceback function
# is called to display a python-style stacktrace.
function _exit_trap() {
  local _exit_code="$?"
  local _stack_frame=1

  if [[ $_exit_code != 0 && "${_DISPLAYED_TRACEBACK}" != true ]]; then
    _traceback ${_stack_frame}
  fi
}

# Called on error signal. Calls the _traceback function to display a
# python-style stacktrace.
function _err_trap() {
  local _exit_code="$?"
  local _stack_frame=1
  local _err_cmd="${BASH_COMMAND:-unknown}"
  local _err_msg="The command ${_err_cmd} exited with exit code ${_exit_code}." 1>&2

  _traceback ${_stack_frame}
  _DISPLAYED_TRACEBACK=true
  printf "\x1b[31m%s\x1b[0m\n" "${_err_msg}" 1>&2

  # Force exit on any errors (not currently working).
  exit ${_exit_code}
}

# Set the EXIT and ERR signal handling functions.
trap _exit_trap EXIT
trap _err_trap ERR


# --- [ DEBUG ] ------------------------------------------------------------ #

BOILERPLATE_DEBUG_ENABLED=${DEBUG:-1}

if [[ ${BOILERPLATE_DEBUG:-0} -eq 1 ]]; then
  _print "BOILERPLATE_CALLER_NAME:    $BOILERPLATE_CALLER_NAME"
  _print "BOILERPLATE_CALLER_DIR:     $BOILERPLATE_CALLER_DIR"
  _print "BOILERPLATE_CALLER_PATH:    $BOILERPLATE_CALLER_PATH"
  _print "BOILERPLATE_SCRIPT_NAME:    $BOILERPLATE_SCRIPT_NAME"
  _print "BOILERPLATE_SCRIPT_DIR:     $BOILERPLATE_SCRIPT_DIR"
  _print "BOILERPLATE_SCRIPT_PATH:    $BOILERPLATE_SCRIPT_PATH"
fi