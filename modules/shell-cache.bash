#!/usr/bin/env bash

# Subshells & command testing are *really* slow. They account for the majority
# of startup times, typically. Rather than performing all my tests *every* time
# I start up a shell, this library provides a clean mechanism for caching status
# codes & loading them from the cached value on subsequent startups.

# The cache is intended to be unique for each host and should not be
# synchronized. It's a snapshot of the runtime environment at the time in which
# each value was cached and allows us to perform lots of runtime checks without
# sacrificing startup times.
CRIB_CACHEFILE="$CRIB_TMPFILES/cache"

# If we have a cache file, source it - otherwise create an empty cache file.
if [[ -f "$CRIB_CACHEFILE" ]]; then
  _crib_log "Loading cache file ..." "$CRIB_LLDBG"
  source "$CRIB_CACHEFILE"
else
  _crib_log "Creating cache file." "$CRIB_LLINFO"
  touch "$CRIB_CACHEFILE"
fi

_crib_cache_command() {
  [[ $# -ne 2 ]] && error "Invalid number of arguments."
  local var=$1
  local cmd=$2
  local val=${!var:-}

  if [[ -n "$val" ]]; then
    _crib_log "Using cached value for $var: $val." "$CRIB_LLDBG"
  else
    # Bash's eval is not know for being secure. However, it's the only way
    # I know to do this.  Whatever command is passed as the second argument is
    # executed and the status code from that command is cached in in the
    # variable's name that was specified in $1. The name and value are written
    # to the cache file, which is sourced on subsequent startups. If debugging
    # is enabled, pause it while executing the command since it may
    # (intentionally) fail.
    _crib_debug_pause
    eval "$cmd &> /dev/null"
    local result=$?
    _crib_debug_resume

    _crib_log "Caching value $1=$result ($2)"
    echo "export $var=$result" >> "$CRIB_CACHEFILE"
    export "${var}"="$result"
  fi
}
