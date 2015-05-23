


# Download & Sync {{{2
# ---------------
# Commands to download & sync data from remote sources.
# - So for I've only implimented a git clone wrapper that prompts for input and
#   offers an optional argument to run a script after the clone is complete.

# Clone a git repository to a specific path & optionally run a post-clone hook.
# Usage: clone_repo "name" "repo" "path" "hook"
clone_repo() {
  msg "$#" $MSGDEBUG
  [[ $# -lt 3 ]] && errexit "Bad # arguments for clone_repo."
  local name"=$1" repo="$2" path="$3" hook="${4:-}"

  if [[ ! -d "$path" ]]; then
    msg "The $name repo is not present." $MSGDEBUG
    promptexec "Clone $name to $path" "git clone $repo $path"
  else
    msg "The $name repository is already present." $MSGVERBOSE
  fi

  if [[ -n "$hook" ]]; then
    msg "Repo post-clone-hook set to $hook." $MSGDEBUG

    if [[ -x "$hook" ]]; then
      msg "Executing the post-clone-hook." $MSGDEBUG
      # eval $hook
    else
      msg "The post-clone-hook command is not present." $MSGERROR
    fi
  fi
}