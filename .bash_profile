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
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
CLEAR='\033[0m'

#Bashhistory settings
HISTSIZE=1000000
HISTCONTROL=ignoreboth

# [[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

shopt -s nocaseglob

# Change prompt
# export PS1='\h:\w \u $ '
export PS1="${MAGENTA}\W \$ ${CLEAR}"

# set npm global
export PATH=~/.npm-global/bin:$PATH

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
		echo -e "${RED}Please profide a file to unzip${CLEAR}"
	fi
}

tz () {
	if [ $# -eq 1 ]; then
		tar -czvf $1.tar.gz $1
	else
		echo -e "${RED}Please profide a dir to tar${CLEAR}"
	fi
}

# aliases
alias ll='ls -lah'
alias subl='open -a /Applications/Sublime\ Text.app'
alias srv='pyServer $1'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
