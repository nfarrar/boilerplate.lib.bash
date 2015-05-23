#!/usr/bin/env bash

function print_01() {
  echo      "  \$0:                      $0"
  echo      "  \${BASH_SOURCE[@]}:       ${BASH_SOURCE[@]}"
  echo      "  \${BASH_SOURCE[0]}:       ${BASH_SOURCE[0]}"
  echo -e   "  \${BASH_SOURCE[@]:(-1)}:  ${BASH_SOURCE[@]:(-1)}\n"
}

function wrap_print_02() {
  print_02
}

echo -e     "print-01.bash: inline\n"
echo        "  \$0:                      $0"
echo        "  \${BASH_SOURCE[@]}:       ${BASH_SOURCE[@]}"
echo        "  \${BASH_SOURCE[0]}:       ${BASH_SOURCE[0]}"
echo -e     "  \${BASH_SOURCE[@]:(-1)}:  ${BASH_SOURCE[@]:(-1)}\n"

echo -e     "print-01.bash: print_01()\n"
print_01

echo -e     "print-01.bash: 'sourcing print-02.bash'\n"
source print-02.bash

echo -e     "print-01.bash: inline\n"
echo        "  \$0:                      $0"
echo        "  \${BASH_SOURCE[@]}:       ${BASH_SOURCE[@]}"
echo        "  \${BASH_SOURCE[0]}:       ${BASH_SOURCE[0]}"
echo -e     "  \${BASH_SOURCE[@]:(-1)}:  ${BASH_SOURCE[@]:(-1)}\n"

# print the bash source stack, using a function contained in a separate file
echo -e     "print-01.bash: print_02()\n"
print_02

echo -e     "print-01.bash: wrap_print_02() -> print_02()\n"
print_02