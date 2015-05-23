Bashisms
========


Exit Codes
----------
Shell exit codes are inverse to the standard boolean conventions. When a statement executes in a shell
it generates a status code ($?). Zero indicates it executed correctly and a non-zero
value indicates it failed *and* the type of error. This was confusing at first - since
standard conventions dictate `TRUE=` and `FALSE=0`. The key is that these exit code
statuses only `SUCCESS=0` and `FAILURE!=0`.


Exports
-------

- non-exported variables *are* available in sourced scripts
- non-exported variables *are not* available in subshells
- available in command substitutions?


Exit vs. Return
---------------

- exit in a sourced script causes the entire shell to terminate
- return in a sourced script prevents the rest of the sourced script
from executing, causing execution to resume from sourcing script.

Sourcing Guarding
-----------------
This library is intended to be sourced by another script. This can be done in
many ways. Here's a basic solution:

    if [[ ! -f "${BASHLIB:-$HOME/.crib/lib/lib.bash}" ]]; then
      echo -e "\e[0;31mUnable to locate ${BASHLIB}.\e[0;30m"; exit 1
    fi
    source "$BASHLIB"

