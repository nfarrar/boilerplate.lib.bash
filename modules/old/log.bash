#!/usr/bin/env bash

# _crib_require "$CRIB_BASHLIB/color.sh"

# Standard logging levels.
CRIB_LLDBG=0
CRIB_LLINFO=1
CRIB_LLWARN=2
CRIB_LLERR=3

# The default log level is set to LOG_LEVEL_INFO.
CRIB_LOG_LEVEL=${CRIB_LOG_LEVEL:-$CRIB_LLINFO}

# Usage: log "msg" "LOG_LEVEL"
_crib_log() {
  if [[ $# -lt 1 ]]; then
    _crib_error "Bad # of arguments for call to message"
  fi

  local _msg=$1
  local _msg_level=${2:-$CRIB_LLDBG}

  if [[ $_msg_level -ge $CRIB_LOG_LEVEL ]]; then
    case $_msg_level in
      $CRIB_LLINFO) echo -en "$FGGREEN"    >&2;;
      $CRIB_LLWARN) echo -en "$FGYELLOW"   >&2;;
       $CRIB_LLERR) echo -en "$FGRED"      >&2;;
                 *) echo -en "$FGMAGENTA"  >&2;;
    esac

    echo -en "$_msg"  >&2
    echo -e  "$RESET" >&2
  fi
}
