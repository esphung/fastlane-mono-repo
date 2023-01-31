#!/bin/bash

#---------------------------------------------------------------------------------------
#  Script to install rbenv, Ruby, nodejs and yarn
#  Source: https://gist.github.com/alexishida/655fb139c759393ae5fe47dacd163f99
#
#  Author: Alex Ishida <alexishida@gmail.com>
#  Version: 1.5.7 - 30/12/2022
#---------------------------------------------------------------------------------------
#
#  HOW TO INSTALL A SCRIPT
#
#  - Ruby <= 2.6 require Ubuntu <= 20.04 (require openssl1.1.1 don't work on openssl3.0)
#  - Ruby 3.0 works with Ubuntu 22.04
#
#  - Download Raw rbenv-ruby-rails-install.sh from Gist
#
#  - Change permission to run script
#    $ chmod +x rbenv-ruby-rails-install.sh
#
#  - Execute script with sudo
#    $ sudo ./rbenv-ruby-rails-install.sh
#
#  - Reload terminal (Bash or Zsh)
#    $ bash or $ zsh
#
#  If you want update rbenv and last ruby version please using this script:
#  https://gist.github.com/alexishida/015b074ae54e1c7101335a2a63518924
#
#---------------------------------------------------------------------------------------

# Ruby Stable Versions https://www.ruby-lang.org/en/downloads/releases/
# Set variables
RUBY_VERSION=2.7.6
SCRIPT_USER=$SUDO_USER

# Checking if script running with sudo
if [[ $(id -u) -ne 0 ]]
    then echo "Please run with sudo ..."
    exit 1
fi

echo 'Well, here we go! Running the script...'

# Update Ubuntu and install core libraries
add-apt-repository main
add-apt-repository universe
add-apt-repository restricted
add-apt-repository multiverse
apt update
apt install -y curl unzip wget zsh git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev

# Install Node.js LTS (v16.x):
# https://github.com/nodesource/distributions#debinstall
curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
apt install -y nodejs
apt autoremove -y

# Install yarn
npm -g install yarn

# Change crlf git
git config --global core.autocrlf false

# Install rbenv
cd /usr/local
git clone https://github.com/rbenv/rbenv.git rbenv
chgrp -R staff rbenv
chmod -R g+rwxXs rbenv

echo 'export RBENV_ROOT=/usr/local/rbenv' >> /home/"$SCRIPT_USER"/.bashrc
echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /home/"$SCRIPT_USER"/.bashrc
echo 'eval "$(rbenv init -)"' >> /home/"$SCRIPT_USER"/.bashrc

echo 'export RBENV_ROOT=/usr/local/rbenv' >> /home/"$SCRIPT_USER"/.zshrc
echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /home/"$SCRIPT_USER"/.zshrc
echo 'eval "$(rbenv init -)"' >> /home/"$SCRIPT_USER"/.zshrc

echo 'export RBENV_ROOT=/usr/local/rbenv' >> /root/.bashrc
echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /root/.bashrc
echo 'eval "$(rbenv init -)"' >> /root/.bashrc

export RBENV_ROOT=/usr/local/rbenv
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"

# Install ruby-build
git clone https://github.com/rbenv/ruby-build.git /root/.rbenv/plugins/ruby-build
git clone https://github.com/rbenv/ruby-build.git /home/"$SCRIPT_USER"/.rbenv/plugins/ruby-build

echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> /root/.bashrc
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> /home/"$SCRIPT_USER"/.bashrc
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> /home/"$SCRIPT_USER"/.zshrc

export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

# Install Ruby
rbenv install -v "$RUBY_VERSION"
rbenv global "$RUBY_VERSION"
rbenv rehash

# Install Bundler and Rails
gem install bundler

# Install gems to use in vscode
gem install ruby-debug-ide
gem install debase
gem install readapt
gem install solargraph
gem install rufo # Ruby Formater

# Install Rails
gem install rails

# Change folder and files owner
chown -R "$SCRIPT_USER":"$SCRIPT_USER" /home/"$SCRIPT_USER"
chown -R "$SCRIPT_USER":root /usr/local/rbenv

echo 'Installation completed :D'

