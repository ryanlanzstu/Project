#!/bin/bash
# Ensure the script is executed with administrative privileges
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Update system and install nodejs and npm
apt update && apt install -y nodejs npm

# Install pm2 globally
npm install -g pm2

# Stop any running instances of the app
pm2 stop calendar

# Navigate to the project directory
cd /home/ubuntu/Project

# Install rbenv and ruby-build if not already installed
if ! command -v rbenv &> /dev/null; then
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  cd ~/.rbenv && src/configure && make -C src
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc
  source ~/.bashrc
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
  source ~/.bashrc
fi

# Install the correct Ruby version using rbenv
rbenv install -s 3.1.4
rbenv local 3.1.4

# Install Ruby dependencies
bundle install

# Start the app with PM2 in production mode
pm2 start --name calendar -- bundle exec rails server -b 0.0.0.0 -p 3000 -e production
