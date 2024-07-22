#!/bin/bash
sudo apt update && sudo apt install nodejs npm -y
# Install pm2
sudo npm install -g pm2
# Stop instances running
pm2 stop calendar
# Change directory
cd /home/ubuntu/Project
# Install dependencies
bundle install
# Start app
pm2 start --name calendar -- bundle exec rails server -b 0.0.0.0 -p 3000
