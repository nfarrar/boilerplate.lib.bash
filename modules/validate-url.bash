#!/usr/bin/env bash

function validurl() {
  # http://stackoverflow.com/a/190405
  # http://blog.mattheworiordan.com/post/13174566389/url-regular-expression-for-links-with-or-without
  [[ $# -ne 1 ]] && return 64

  curl -s --head "$1" | head -n 1 | grep "HTTP/1.[01] [23].." > /dev/null
  if [[ $? -eq 0 ]]; then
    return 0
  else
    return 1
  fi
}

