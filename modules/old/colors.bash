# ========================================================================== #
# FILE:        $BOILERPLATE_MODULES_HOME/exit-codes.bash
# AUTHOR:      Nathan Farrar <nathan.farrar.@gmail.com>
# DESCRIPTION: {{{
#
#   ESC[ … 38;2;<r>;<g>;<b> … m Select RGB foreground color
#   ESC[ … 48;2;<r>;<g>;<b> … m Select RGB background color
#
#   RGB:
#   - http://www.permadi.com/tutorial/websafecolor/
#   - http://www.rapidtables.com/web/color/Web_Safe.htm
#   - http://www.rapidtables.com/web/color/RGB_Color.htm
#
#   8-Bit Color:
#
#   - Using 8 bits (2^8) to store color information with the RGB model (RRGGBB),
#     we can define 256 (0.255) unique values.
#   - Out of the 256 possible values, only 216 are mapped via the X11 rgb.txt.
#
#   Control Sequence Character
#   - http://invisible-island.net/xterm/ctlseqs/ctlseqs.html
#   - https://stackoverflow.com/questions/19062315/how-do-i-find-out-what-escape-sequence-my-terminal-needs-to-send
#   - https://unix.stackexchange.com/questions/76566/where-do-i-find-a-list-of-terminal-key-codes-to-remap-shortcuts-in-bash
#
#   Color Distance:
#   - https://stackoverflow.com/questions/11765623/convert-hex-to-closest-x11-color-number
#   - https://stackoverflow.com/questions/1313/followup-finding-an-accurate-distance-between-colors/74033#74033
#
#   Misc:
#   - https://en.wikipedia.org/wiki/List_of_color_palettes
#   - https://en.wikipedia.org/wiki/Color_depth
#   - https://en.wikipedia.org/wiki/X11_color_names
#   - https://en.wikipedia.org/wiki/SRGB
#   - http://cgit.freedesktop.org/xorg/app/rgb/plain/rgb.txt
#   - https://gist.github.com/XVilka/8346728
#   - http://www.robmeerman.co.uk/unix/256colours#so_does_terminal_insert_name_here_do_256_colours
#   - http://www.fifi.org/doc/xterm/xterm.faq.html
#   - http://sixteencolors.net/
#   - http://www.emanueleferonato.com/2009/08/28/color-differences-algorithm/
#   - https://upload.wikimedia.org/wikipedia/en/1/15/Xterm_256color_chart.svg
#   - http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html
#   - http://excess.org/misc/xterm_colour_chart.py.html
#   - http://re-factor.blogspot.com/2012/07/xterm-256color.html
#   - https://superuser.com/questions/270214/how-can-i-change-the-colors-of-my-xterm-using-ansi-escape-sequences
#   - http://www.steike.com/code/xterm-colors/
#   - http://rtfm.etla.org/xterm/ctlseq.html
#   - http://thrysoee.dk/xtermcontrol/
#   - http://gidden.net/tom/2006/08/04/x11-color-list-for-macosx/
#   - https://en.wikipedia.org/wiki/X11_color_names
#   - https://codefodder.github.io/making-an-xterm-256color-chart/
#   - https://unix.stackexchange.com/questions/118806/tmux-term-and-256-colours-support
#   - https://unix.stackexchange.com/questions/23763/checking-how-many-colors-my-terminal-emulator-supports/23789#23789
#   - http://www.tayloredmktg.com/rgb/
#
# }}}
# ========================================================================== #

# --- [ CSC ] -------------------------------------------------------------- #

# CSC=csc='\e'
# CSC='\033'
_CSC='\x1b'

# --- [ MAPPINGS ] --------------------------------------------------------- #

_RESET="${_CSC}[0m"

_BOLD="${_CSC}[1m"
_DIM="${_CSC}[2m"
_UNDERLINE="${_CSC}[4m"
_BLINK="${_CSC}[5m"
_REVERSE="${_CSC}[7m"
_HIDDEN="${_CSC}[8m"

_BOLDOFF="${_CSC}[21m"
_DIMOFF="${_CSC}[22m"
_UNDERLINEOFF="${_CSC}[24m"
_BLINKOFF="${_CSC}[25m"

_FGBLACK="${_CSC}[30m"
_FGRED="${_CSC}[31m"
_FGGREEN="${_CSC}[32m"
_FGYELLOW="${_CSC}[33m"
_FGBLUE="${_CSC}[34m"
_FGMAGENTA="${_CSC}[35m"
_FGCYAN="${_CSC}[36m"
_FGLIGHTGRAY="${_CSC}[37m"

# [38m is used to define extended foreground colors

_FGDEFAULT="${_CSC}[39m"
_BGBLACK="${_CSC}[40m"
_BGRED="${_CSC}[41m"
_BGGREEN="${_CSC}[42m"
_BGYELLOW="${_CSC}[43m"
_BGBLUE="${_CSC}[44m"
_BGMAGENTA="${_CSC}[45m"
_BGCYAN="${_CSC}[46m"
_BGLIGHTGRAY="${_CSC}[47m"

# [48m is used to define extended background colors

_BGDEFAULT="${_CSC}[49m"

_FGDARKGRAY="${_CSC}[90m"
_FGLIGHTRED="${_CSC}[91m"
_FGLIGHTGREEN="${_CSC}[92m"
_FGLIGHTYELLOW="${_CSC}[93m"
_FGLIGHTBLUE="${_CSC}[94m"
_FGLIGHTMAGENTA="${_CSC}[95m"
_FGLIGHTCYAN="${_CSC}[96m"
_FGWHITE="${_CSC}[97m"

_BGDARKGRAY="${_CSC}[100m"
_BGLIGHTRED="${_CSC}[101m"
_BGLIGHTGREEN="${_CSC}[102m"
_BGLIGHTYELLOW="${_CSC}[103m"
_BGLIGHTBLUE="${_CSC}[104m"
_BGLIGHTMAGENTA="${_CSC}[105m"
_BGLIGHTCYAN="${_CSC}[106m"
_BGWHITE="${_CSC}[107m"


# --- [ CONVERSIONS ] ------------------------------------------------------ #


function _rgb_to_esc() {
  # Convert an rgb sequence ("RR,GG,BB") to the equivalent ascii escaped
  # character sequence ("\e[38;2;00,00,00;m").

  [[ $# -ne 1 ]] && return ${_EX_USAGE:-64}
  IFS=',' read -a rgb <<< "$1"
  echo -ne "${_CSC}[38;2;${rgb[0]};${rgb[1]};${rgb[2]};m"
}

function _hexrgb_to_esc() {
  [[ $# -ne 1 ]] && return ${_EX_USAGE:-64}
  echo -ne "\033]11;#53186f\007"
}

function _rgb_to_hex() {
  # Convert an rgb sequence ("RR,GG,BB") to the equivalent 'hexrgb'
  # representation ("#3B3B3B").
  [[ $# -ne 1 ]] && return ${_EX_USAGE:-64}
  IFS=',' read -a rgb <<< "$1"

  #local r=${rgb[0]} g=${rgb[1]} b=${rgb[2]}
  # color = (r*6/256)*36 + (g*6/256)*6 + (b*6/256)

  printf "#%02X%02X%02X" "${rgb[0]}" "${rgb[1]}" "${rgb[2]}"
}

function _h2d() {
  #printf "%d\n" "0x$1"
  echo $((16#${1}))
}

function _rgb_to_xterm() {
  # Convert an rgb sequence ("RR,GG,BB") to the equivalent 'hexrgb'
  # representation
  [[ $# -ne 1 ]] && return ${_EX_USAGE:-64}
  IFS=',' read -a rgb <<< "$1"
  local r=${rgb[0]} g=${rgb[1]} b=${rgb[2]}
  r=$(h2d $r); g=$(h2d $g); b=$(h2d $b)

  echo $(( 16 + (g * 36) + (g * 6) + b ))
  # echo $((16 + 36 * r + 6 * g + b ))
}

function _printcolor() {
  [[ $# -ne 2 ]] && return ${_EX_USAGE:-64}
  local name="$1" rgb="$2"
  local esc="$(rgb_to_esc "$2")"
  local hex="$(rgb_to_hex "$2")"

  # echo -e "$(rgbesc "$2")$(rgbtohex "$2")\t\t${2}\t${1}$(clear)"
  echo "$esc$name\t\t$rgb\t$hex"
}

if [[ ${BOILERPLATE_TESTS:-0} -eq 1 ]] || [[ "$BASH_SOURCE" == "$0" ]]; then

  echo 'jellybeans.vim'
  printcolor 'black'    '59,59,59'
  printcolor 'red'      '207,106,76'
  printcolor 'green'    '153,173,106'
  printcolor 'yellow'   '216,173,76'
  printcolor 'blue'     '89,123,197'
  printcolor 'magenta'  '160,55,176'
  printcolor 'cyan'     '113,185,248'
  printcolor 'white'    '173,173,173'

  echo "$(rgb_to_xterm "0,0,0")"
  echo "$(rgb_to_xterm "255,255,0")"

fi
