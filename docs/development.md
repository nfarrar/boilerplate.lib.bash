Development
===========

Tools
-----

| Development Tools         | Description                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------- |
| [assert.sh][]             | Bash unit testing framework.                                                                  |
| [bash-support-vim][]      | BASH IDE -- Write and run BASH-scripts using menus and hotkeys.                               |
| [bash-tap-functions][]    | TAP functiosn for bash.                                                                       |
| [bashate][]               | A pep8 equivalent for bash scripts.                                                           |
| [bashcov][]               | Code coverage tool for Bash.                                                                  |
| [bashdb][]                | A source-code debugger for bash that follows the gdb command syntax.                          |
| [bashdoc][]               | A frontend that parses a bash file and create a documentation in specified format.            |
| [bashful][]               | A collection of libraries to simplify writing bash scripts.                                   |
| [bashprof][]              | Bash profiler.                                                                                |
| [basht][]                 | Minimalist Bash test runner.                                                                  |
| [bats][]                  | Bash Automated Testing System.                                                                |
| [beautify_bash][]         | Code formatter / beautifier for bash written in python.                                       |
| [chocomint][]             | Testing Framework for command-line tools and bash4 shell scripts.                             |
| [roundup][]               | Eliminate bugs and weeds from shell scripts (http://bmizerany.github.com/roundup).            |
| [shebang-unit][]          | Automated test framework for Bash.                                                            |
| [shellcheck][]            | ShellCheck, a static analysis tool for shell scripts (http://www.shellcheck.net).             |
| [shcov][]                 | Coverage test tool for Bourne-Again SHell.                                                    |
| [shocco][]                | A quick-and-dirty, literate-programming-style documentation generator.                        |
| [shunit2][]               | An xUnit unit test framework for Bourne based shell scripts.                                  |
| [stub.sh][]               | Helpers for bash script testing to stub/fake binaries and functions.                          |
| [vim-script-runner][]     | A vim plugin for running perl, python, ruby, bash, etc. scripts inside of vim.                |


Cheatsheets & Guides
--------------------

- http://guide.bash.academy/
- https://github.com/progrium/bashstyle
- https://github.com/NisreenFarhoud/Bash-Cheatsheet
- https://github.com/bahamas10/bash-style-guide
- https://github.com/pkrumins/bash-redirections-cheat-sheet
- https://github.com/azet/community_bash_style_guide
- https://github.com/pkrumins/bash-history-cheat-sheet
- https://github.com/icy/bash-coding-style
- https://github.com/shawncplus/bash-classes
- https://github.com/rafalchmiel/bash-cheat-sheet
- https://github.com/pkrumins/bash-one-liners


Tips
----

- Don't forget about simple traces with -x trace, I find that sensible usage of xtrace is typically more efficient than running bashdb ~ 90% of the time.

- You can hide specific error messages with shellcheck by passing it the argument: -e <CODE,CODE1..CODE99>. For some scripts (such as this shell library) this is useful for hiding things like export warnings (SC2034).

- Setup continuous integration testing using travis-ci with bash scripts: https://www.sysorchestra.com/2014/10/12/travisshunit2/

<!-- References -->

[assert.sh]:                https://github.com/lehmannro/assert.sh
[bash-support-vim]:         https://github.com/vim-scripts/bash-support.vim
[bash-tap-functions]:       https://github.com/goozbach/bash-tap-functions
[bashate]:                  https://github.com/openstack-dev/bashate
[bashcov]:                  https://github.com/infertux/bashcov
[bashdb]:                   http://bashdb.sourceforge.net/
[bashdoc]:                  https://github.com/ajdiaz/bashdoc
[bashful]:                  https://github.com/jmcantrell/bashful
[bashprof]:                 https://github.com/sstephenson/bashprof
[basht]:                    https://github.com/progrium/basht
[bats]:                     https://github.com/sstephenson/bats
[beautify_bash]:            https://github.com/ewiger/beautify_bash
[chocomint]:                https://github.com/toromoti/chocomint
[roundup]:                  https://github.com/bmizerany/roundup
[shebang-unit]:             https://github.com/arpinum-oss/shebang-unit
[shellcheck]:               https://github.com/koalaman/shellcheck
[shcov]:                    https://github.com/SimonKagstrom/shcov
[shocco]:                   https://github.com/rtomayko/shocco
[shunit2]:                  https://code.google.com/p/shunit2/
[stub.sh]:                  https://github.com/jimeh/stub.sh
[vim-script-runner]:        https://github.com/ironcamel/vim-script-runner
