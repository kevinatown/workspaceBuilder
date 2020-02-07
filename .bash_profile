# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

export PATH=$PATH:$HOME/.local/bin:$HOME/bin

# Uncomment to change to Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
# PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
# export PATH

# COLORS!

# unix
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
CLEAR='\033[0m'

# OSX Terminal settings
REDT='\[\e[31m\]'
GREENT='\[\e[32m\]'
YELLOWT='\[\e[33m\]'
BLUET='\[\e[34m\]'
MAGENTAT='\[\e[35m\]'
CYANT='\[\e[36m\]'
CLEART='\[\e[0m\]'

#Bashhistory settings
HISTSIZE=1000000
HISTCONTROL=ignoreboth

# [[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

shopt -s nocaseglob

# Change prompt
# export PS1='\h:\w \u $ '
export PS1="${MAGENTAT}\W \$ ${CLEART}"

# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'

# Tell ls to be colourful
export CLICOLOR=1
export LSCOLORS=Exfxcxdxbxegedabagacad

# set npm global
export PATH=~/.npm-global/bin:$PATH
export N_PREFIX=~/.npm-global/

# python server
pyServer () {
  if [ $# -eq 0 ]; then
    python -m SimpleHTTPServer 8080
  else 
    python -m SimpleHTTPServer $1
  fi
}

utz () {
  if [ $# -eq 1 ]; then
    tar -xzvf $1
  else
    printf "${RED}Please profide a file to unzip${CLEAR}\n"
  fi
}

tz () {
  if [ $# -eq 1 ]; then
    tar -czvf $1.tar.gz $1
  else
    printf "${RED}Please profide a dir to tar${CLEAR}\n"
  fi
}

findProcess() {
  if [ $# -eq 1 ]; then
    ps aux | grep -i $1
  else
    printf "${RED}Please profide one provide name to find (case insensitive)${CLEAR}\n"
  fi
}

killProcess() {
  if [ $# -eq 1 ]; then
    findProcess $1 | awk '{ print $2 }' | xargs kill -9
  else
    printf "${RED}Please provide one process name to kill (case insensitive)${CLEAR}\n"
  fi
}

mkGif() {
  if [ $# -eq 0 ]; then
    printf "${RED}Please provide a .mov file to convert to gif (do not add file format and output is same name)${CLEAR}\n"
  else
    SIZE="600x400"
    if [ $# -eq 2 ]; then
      SIZE="$2"
    else
      printf "\n\n${CYAN}Size not Provided ${SIZE} will be used. ${CLEAR}\n\n"
    fi
    # old options 
    # -s 600x400 -pix_fmt rgb24 -r 10
    # maybe want to change -r (rate) or -pix_fmt (pixel format options)
    ffmpeg -i "$1.mov" -s "${SIZE}" -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > "$1.gif"
  fi
}

# aliases
alias ll='ls -lah'
alias subl='open -a /Applications/Sublime\ Text.app'
alias srv='pyServer $1'
alias gitsync='git fetch upstream && git checkout -f master && git merge upstream/master'
alias kp='killProcess $1'
