# Messages & Logging
# ------------------


# Message Levels.
MSGDEBUG=0
MSGVERBOSE=1
MSGINFO=2
MSGWARN=3
MSGERROR=4
MSGCRITICAL=5


# Set the default message level to display INFO+ messages.
MSGLEVEL=${MSGLEVEL:-2}


msg() {
  [[ $# -lt 1 ]] && errexit "Missing argument for msg()."
  local msg=$1
  local msgtype=${2:-MSGINFO}
  local msgcolor=$FGMAGENTA

  case "$msgtype" in
       $MSGDEBUG) msgcolor=$FGMAGENTA;;
     $MSGVERBOSE) msgcolor=$FGGREEN;;
        $MSGINFO) msgcolor=$FGBRGREEN;;
       $MSGERROR) msgcolor=$FGRED;;
    $MSGCRITICAL) msgcolor=$FGBRRED;;
               *) msgcolor=$FGDEFAULT;;
  esac

  if [[ ${MSGLVL:-0} -le $msgtype ]]; then
    echo "$msgcolor$msg$RESET" >&2
  fi

}