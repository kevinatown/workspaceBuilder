#!/bin/bash

#
# Set up Scott's favorite prompt.
#
echo "export PS1='\h:\W \$ '" >> ~/.bashrc

#
# Set up case-insensitive autocompletion.
#
echo "shopt -s nocaseglob" >> ~/.bashrc
echo "set completion-ignore-case On" > ~/.inputrc

#
# Install the requisite Ubuntu packages.
#
sudo apt-get update
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get -y install git libyaml-dev libxslt-dev libxml2-dev libsqlite3-dev nodejs nodejs-dev postgresql postgresql-contrib libpq-dev python-pip apache2 mysql-server php5-mysql python-dev coffeescript

sudo -u postgres createuser -s $USER
sudo -u postgres createdb $USER

# npm install coffee-script -g 

#
# Install RVM.
#
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable

#
# Use RVM to install the latest Ruby 2.2 release.
#
~/.rvm/bin/rvm --quiet-curl install ruby-2.2

#
# install django
#
sudo pip install django
sudo pip install psycopg2
# one or the other
# sudo pip install django_compressor
sudo pip install pipeline
sudo npm -g install yuglify
sudo pip install django-angular

#
# Make a symbolic link to the synced directory.
#
ln -s /vagrant ~/workspace
