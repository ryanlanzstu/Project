#!/bin/bash
# Update system and install nodejs and npm
sudo apt update && sudo apt install nodejs npm -y

# Install pm2
sudo npm install -g pm2

# Stop any running instances
pm2 stop calendar

# Change directory to the project
cd /home/ubuntu/Project

# Install rbenv and ruby-build if not already installed
if ! command -v rbenv &> /dev/null; then
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  cd ~/.rbenv && src/configure && make -C src
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc
  exec $SHELL
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
  exec $SHELL
fi

# Install the correct Ruby version
rbenv install -s 3.1.4
rbenv local 3.1.4

# Install dependencies
bundle install

# Start the app with PM2 in production mode
pm2 start --name calendar -- bundle exec rails server -b 0.0.0.0 -p 3000 -e production
