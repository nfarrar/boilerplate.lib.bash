

# Prompt Commands {{{2
# ---------------
# Some wrapper functions to interact with user input:
#
# - promptexec    "question" "command"
# - promptexecarg "question" "label" "command" "var"
# - promptval     "question" "varname"
#
#
# Promptexecarg asks the user a question and waits for input.
#

# Prompt the user with a question and wait for a single keypress. If 'y' is
# pressed, execute the specified command.
# Usage: promptexec "question" "command"
promptexec() {
  [[ $# -lt 2 ]] && errexit "Bad # arguments for prompt_exec()."
  local question=$1 command=$2 answer=""

  # local command=$2
  # local answer=''

  read -n 1 -p "$question (y/n): " answer
  msg ""

  # if exec == true, only execute on 'y'
  if [[ "$exec" != 'false' && "$answer" == 'y' ]]; then
     msg "promptexec: executing $command" $MSGDEBUG
     eval "$command"
   else
     msg "promptexec: not executing $command" $MSGDEBUG
  fi

}

# Prompt the user with a question and wait for a single keypress. If 'y' is
# pressed, then display the label and wait for an input string. Prompt the user
# for confirmation by pressing 'y'. This executes in a loop so that input may be
# adjusted repeatedly. The loop may be terminated at any time by answering 'n'
# to the first question.
# Usage: promptexecarg "question" "label" "command" "var"
promptargexec() {
  [[ $# -ne 4 ]] && errexit "Bad # arguments for promptargexec()."
  local question=$1 label=$2 cmd=$3 var=$4
  local do_confirm='' answer_arg='' do_arg_confirm=''

  local stop=$FALSE

  while [[ "$do_confirm" != 'n' && $stop != $TRUE ]]; do
    read -n 1 -p "$question (y/n)? : " do_confirm
    msg ""

    if [[ "$do_confirm" == 'y' ]]; then
      # prompt user for argument
      read -p "$label: " answer_arg

      # prompt user to confirm arg
      read -n 1 -p "$answer_arg is correct? (y/n): " do_arg_confirm
      msg ""

      if [[ "$do_arg_confirm" == y ]]; then
        command=$(echo "$command" | sed "s/$var/$answer_arg/g")
        msg "prompt_exec executing $command $MSGDEBUG"
        # eval $command
        stop=$TRUE
      fi

    else
     stop=$TRUE
    fi

  done
}

# Prompt the user with a question, then wait for an input string. Prompt the
# user to confirm input is correct with a single 'y' keypress. This executes in
# a loop so that input may be adjusted repeatedly. The loop may be terminated at
# any point by entering a null string: "" and then answering 'y'.
#
# The variable name is set dynamically by this function - be careful not to
# overwrite an existing variable.
#
# This is commonly used as a workaround when promptexec & promptexecarg aren't
# robust enough to handle the user input scenario.
#
# Note: This is really only necessary due to the complexities involved with
# gathering user input in a function being used as a command substitution.
#
# Usage: promptarg "question" "varname"
promptarg() {
  [[ $# -ne 2 ]] && errexit "Bad # arguments for prompt_value()."
  local question=$1 varname=$2 arg_confirm=$FALSE

  while true; do

    read -p "$question: " "$varname"
    [[ "${!varname}" == "" ]] && break

    read -n 1 -p "Is ${!varname} correct? (y/n): " arg_confirm
    [[ "$arg_confirm" == 'y' ]] && break

  done

}

# Prompt the user if would like to quit (non 'y/Y' response triggers exit).
promptquit() {
  local response

  read -n 1 -p "Would you like to quit? (Y/n): " response
  msg ""

  if [[ "$response" =~ ^[y|Y] ]]; then
    msg "Thank you, come again!" "$MSGINFO"
    exit 0
  fi
}

# Prompt the user to continue by pressing any key.
promptcontinue() {
  local response
  read -n1 -p "Press any key to continue ... "
}
