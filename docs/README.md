Notes
=====



Strict Execution
----------------
These settings ensure that bash doesn't execute like a lunatic:

    set -o nounset      # generate an error if we attempt to modify an unset variable
    set -o pipefail     # propogate non-zero return values through pipelines
    set -o errtrace     # builtins & command substitutions inherit error handling
    set -o errexit      # exit whenever an error occurs (non-zero value is returned anywhere)

- These are suitable for executing shell scripts
- These are *not* suitable for use your startup files.


Source Detection
----------------

- https://stackoverflow.com/questions/3664225/determining-whether-shell-script-was-executed-sourcing-it


Operating Systems
-----------------

### Cygwin
Cygwin's zsh doesn't setup system paths until /etc/zprofile is sourced. On that platform, we cannot
access non-builtins in the startup process until that point.
