#!/usr/bin/env bash

# Notes: {{{
# - http://echoreply.us/tech/2008/01/14/simple-bash-toupper-and-tolower-functions/  
# }}}

toupper() {
  local char="$*"
  out=$(echo $char | tr [:lower:] [:upper:])
  local retval=$?
  echo "$out"
  unset out
  unset char
  return $retval
}

tolower() {
  local char="$*"
  out=$(echo $char | tr [:upper:] [:lower:])
  local retval=$?
  echo "$out"
  unset out
  unset char
  return $retval
}

# lowercase() {
#   echo "$1" | sed "y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/"
# }

#vim: set fdm=marker
