#!/usr/bin/env bash

function print_02() {
  echo      "  \$0:                      $0"
  echo      "  \${BASH_SOURCE[@]}:       ${BASH_SOURCE[@]}"
  echo      "  \${BASH_SOURCE[0]}:       ${BASH_SOURCE[0]}"
  echo -e   "  \${BASH_SOURCE[@]:(-1)}:  ${BASH_SOURCE[@]:(-1)}\n"
}

function wrap_print_01() {
    print_01
}

echo -e     "print-02.bash: inline\n"
echo        "  \$0:                      $0"
echo        "  \${BASH_SOURCE[@]}:       ${BASH_SOURCE[@]}"
echo        "  \${BASH_SOURCE[0]}:       ${BASH_SOURCE[0]}"
echo -e     "  \${BASH_SOURCE[@]:(-1)}:  ${BASH_SOURCE[@]:(-1)}\n"


echo -e     "print-02.bash: wrap_print_01() -> print_01()\n"
wrap_print_01