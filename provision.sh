#!/bin/bash

#
# Install the requisite packages
#
sudo apt-get update
sudo apt-get install -y curl

curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -

sudo echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" | sudo tee -a /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y vim wget git autoconf automake build-essential libtool libyaml-dev libssl-dev libsasl2-dev libldap2-dev pkg-config libxslt-dev libxml2-dev libsqlite3-dev nodejs postgresql-9.6 postgresql-contrib-9.6 postgresql-client-9.6 libpq-dev apache2 libxmlsec1 redis-server

echo 'deb http://ftp.de.debian.org/debian testing main' | sudo tee -a /etc/apt/sources.list
echo 'APT::Default-Release "stable";' | sudo tee -a /etc/apt/apt.conf.d/00local
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -t testing install -y python3.6 python3.6-dev python3-pip python3.6-venv libxmlsec1-dev

# 
# Case complete off
# 
echo "set completion-ignore-case On" > ~/.inputrc

# 
# aliases and env vars
#
tee ~/.bash_profile <<EOF
if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

# COLORS!
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
CLEAR='\033[0m'

# Bashhistory settings
HISTSIZE=1000000
HISTCONTROL=ignoreboth

# [[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

export PATH
shopt -s nocaseglob

# Change prompt
export PS1="${CYAN}\h:\W \$ ${CLEAR}"

#
# functions
#

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

helpMessage () {
	cat <<MSG
	------------------------------------------------------
	Welcome to Debian 9!

	Ports forwared:
	  - guest: 3000, host: 3000
	  - guest: 5432, host: 5432 (psql)
	  - guest: 6379, host: 6379 (redis)
	  - guest: 8000, host: 8000
	  # - guest: 8080, host: 8080
	  # - guest: 8090, host: 8090

	Aliases:
	  - psqluser         # switch to postgres
	  - ll               # ls -lah
	  - runredis         # run redis server
	  - pyenv	           # ativate python env
	  - startpsql	       # postgres client

	Functions:
        - hlp             # rerun this help message
        - srv <port>      # simple python server at <port>, default: 8080
        - tz <directory>  # tar and gzip given file
        - utz <file>	  # unzip zipped tarball
	------------------------------------------------------
MSG
}

#
# aliases
#

# sudo pip install django
# sudo pip install psycopg2
# # one or the other
# # sudo pip install django_compressor
# sudo pip install pipeline
# sudo npm -g install yuglify
# sudo pip install django-angular

alias srv='pyServer $1'
alias hlp='helpMessage'
alias psqluser="su -s /bin/bash postgres"
alias ll="ls -lah"
alias runredis="redis-server /etc/redis/redis.conf --daemonize yes"
alias pyenv="source ~/.venv/bin/activate"
alias startpsql="sudo -u postgres psql"

export N_PREFIX=/home/vagrant/.npm-global/bin
export PATH=/home/vagrant/.npm-global/bin:/home/vagrant/.local/bin:$PATH
EOF

source /home/vagrant/.bash_profile

#
# Make a symbolic link to the synced directory.
#
ln -s /vagrant ~/workspace

# 
# npm setup
# 
mkdir ~/.npm-global
npm config set prefix ~/.npm-global

npm i -g npm@latest
npm i -g n

# 
# python env
#
sudo ln -sf /usr/bin/python3.6 /usr/bin/python
python -m venv .venv
echo "export PATH=$(pwd)/bin:$PATH" >> .venv/bin/activate
echo "export PATH=/home/vagrant/.local/bin:$PATH"
