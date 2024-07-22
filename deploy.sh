#!/usr/bin/env bash
sudo apt update && sudo apt install -y nodejs npm

# Install pm2
sudo npm install -g pm2

# Stop any running instances of the app
pm2 stop calendar || true

# Navigate to the project directory
cd ~/Project

# Install dependencies
bundle install
npm install

# Run pending migrations
bundle exec rails db:migrate RAILS_ENV=production

# Start the app
pm2 start "bundle exec rails server -b 0.0.0.0 -p 3000" --name calendar
