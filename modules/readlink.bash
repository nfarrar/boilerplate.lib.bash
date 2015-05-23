
function _readlink() {
  # Get the *physical* path to the target file, resolving any symlinks. This
  # works just like readlink -f, which is not available on BSD/OSX systems by
  # default.
  if [[ $# -ne 1 ]]; then
    echo "ERROR: _readlink called with wrong # of arguments."
    exit ${_EX_USAGE:-64}
  fi

  local filename="$1"

  cd "$(dirname $filename)"
  local filename="$(basename $target)"

  # iterate down a (possible) chain of symlinks
  while [ -L "$target" ]; do
    target="$(readlink $TARGET_FILE)"
      cd "$(dirname $target)"
      target="$(basename $target)"
  done

  # Compute the canonicalized name by finding the physical path
  # for the directory we're in and appending the target file.
  local filedir="$(pwd -P)"
  echo "$(filedir/$target)"
}