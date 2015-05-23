#!/usr/bin/env bash

# -n STRING     the length of STRING is nonzero
# -z STRING     the length of STRING is zero

# Set 'strict' execution - if unset variables are referenced, an error will be
# generated and the script will execute.
set -euo pipefail

## VARIABLES
# - FROM_SET_VAR is initialized using the value from $SET_VAR.
# - FROM_UNSET_VAR tries to initialize from the value $UNSET_VAR, which does not
#   exist. Since it does not exist, it's initialized to an empty string.
SET_VAR='DEFAULT_VALUE'
FROM_SET_VAR=${DEFAULT_VAR:-}
FROM_UNSET_VAR=${UNSET_VAR:-}

# Display values.
echo "SET_VAR:              $SET_VAR"
echo "FROM_SET_VAR:         $FROM_SET_VAR"
echo "FROM_UNSET_VAR:       $FROM_UNSET_VAR"

# $SET_VAR is set and has a non-zero length.
[[ -n $SET_VAR ]]           && echo "TEST -n \$SET_VAR TRUE"
[[ -n $SET_VAR ]]           || echo "TEST -n \$SET_VAR FALSE"
[[ -z $SET_VAR ]]           && echo "TEST -z \$SET_VAR TRUE"
[[ -z $SET_VAR ]]           || echo "TEST -z \$SET_VAR FALSE"

# $FROM_SET_VAR is set and has a non-zero length.
[[ -n $FROM_SET_VAR ]]      && echo "TEST -n \$FROM_SET_VAR TRUE"
[[ -n $FROM_SET_VAR ]]      || echo "TEST -n \$FROM_SET_VAR FALSE"
[[ -z $FROM_SET_VAR ]]      && echo "TEST -z \$FROM_SET_VAR TRUE"
[[ -z $FROM_SET_VAR ]]      || echo "TEST -z \$FROM_SET_VAR FALSE"

# $FROM_UNSET_VAR is set, but has a zero length.
[[ -n $FROM_UNSET_VAR ]]    && echo "TEST -n \$FROM_UNSET_VAR TRUE"
[[ -n $FROM_UNSET_VAR ]]    || echo "TEST -n \$FROM_UNSET_VAR FALSE"
[[ -z $FROM_UNSET_VAR ]]    && echo "TEST -z \$FROM_UNSET_VAR TRUE"
[[ -z $FROM_UNSET_VAR ]]    || echo "TEST -z \$FROM_UNSET_VAR FALSE"