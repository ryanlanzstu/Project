#!/bin/bash

#Run with sudo to fix issues
if [[ $(id -u) -ne 0 ]]; then
  echo "Must run as root/sudo"
  exit 1
fi

echo "Deploying app"

#Install Node.js and npm
echo "Install node&npm"
sudo apt update && sudo apt install -y nodejs npm ruby-full build-essential zlib1g-dev
if [[ $? -ne 0 ]]; then
  echo "Failed to install Node.js or npm"
  exit 1
fi

#Install pm2 
echo "Installing PM2 globally..."
sudo npm install -g pm2
if [[ $? -ne 0 ]]; then
  echo "Failed to install PM2"
  exit 1
fi

#Go to directory
echo "Going to project directory"
cd /home/ubuntu/Project
if [[ $? -ne 0 ]]; then
  echo "Failed to find project."
  exit 1
fi

#Load rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

#Check env running
echo "rbenv version: $(rbenv -v)"
echo "ruby version: $(ruby -v)"
echo "bundler version: $(bundle -v)"

#Stop running insts
echo "Stopping any running instances"
pm2 stop calendar || true

#Install dependencies
echo "Installing depdendencies"
npm install
if [[ $? -ne 0 ]]; then
  echo "Failed to install npm dependencies."
  exit 1
fi

echo "Installing gems"
bundle install
if [[ $? -ne 0 ]]; then
  echo "Failed to install gems."
  exit 1
fi

#Precomp assets
echo "Precompiling assets..."
SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile
if [[ $? -ne 0 ]]; then
  echo "Failed to precompile assets."
  exit 1
fi

#Start pm2 in prod mode
echo "Starting the app in production mode with PM2..."
pm2 start --name calendar -- bundle exec rails server -b 0.0.0.0 -p 3000
if [[ $? -ne 0 ]]; then
  echo "Failed to start the application with PM2."
  exit 1
fi

echo "Deployment successful."
