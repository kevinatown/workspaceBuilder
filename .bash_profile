# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

PATH=$PATH:$HOME/.local/bin:$HOME/bin

#Easy list hidden attributes in a readable format
alias ll='ls -lah'

# Uncomment to change to Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
# PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
# export PATH

#Easy sublime open from command line
alias subl='open -a /Applications/Sublime\ Text.app'

#Bashhistory settings
HISTSIZE=1000000
HISTCONTROL=ignoreboth

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH
shopt -s nocaseglob

# Change prompt
# \h:\W \u\$
export PS1='\h:\W \$ ' 
