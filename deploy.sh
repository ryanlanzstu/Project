#!/usr/bin/env bash
sudo apt update && sudo apt install -y nodejs npm
# Install pm2
sudo npm install -g pm2
# Stop instances running
pm2 stop calendar || true
# Change directory
cd ~/Project/
# Install dependencies
npm install
# Start app
pm2 start ./bin/www --name calendar
