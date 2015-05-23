
# Runtime Event Handling {{{1
# ----------------------
#
# http://www.alittlemadness.com/2012/06/25/bash-tip-reliable-clean-up-with-trap/
# http://stackoverflow.com/questions/64786/error-handling-in-bash
# http://linuxcommand.org/wss0160.php
# http://redsymbol.net/articles/bash-exit-traps/
# http://phaq.phunsites.net/2010/11/22/trap-errors-exit-codes-and-line-numbers-within-a-bash-script/
# http://fvue.nl/wiki/Bash:_Error_handling

# http://tldp.org/LDP/abs/html/exitcodes.html

# force an exit on a critcal error
errexit() {
  local errmsg=${1:-An unexpected error occurred.}

  # This function is explicitly called, so we don't need our
  # onexit and onerr traps to fire.
  trap - ERR
  trap - EXIT

  msg "$errmsg" "$MSGERROR"
  exit 1
}

# exit handler
onexit() {
  local exit_status=$?

  if [[ $exit_status -ne $TRUE ]]; then
    msg "An unexpected error occurred. Exiting with status $exit_status." "$MSGCRITICAL"
  else
    msg "Executed successfully." "$MSGINFO"
  fi
}

# error handler
onerr() {
  local exit_status=$?
  msg "An unexpected error occurred. Exiting with status $exit_status." "$MSGCRITICAL"
}

trap onexit EXIT
trap onerr  ERR

# trap "error_exit 'Received signal SIGHUP'" SIGHUP
# trap "error_exit 'Received signal SIGINT'" SIGINT
# trap "error_exit 'Received signal SIGTERM'" SIGTERM

