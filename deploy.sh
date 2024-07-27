#!/bin/bash

# Ensuring the script is run with sudo or root privileges
if [[ $(id -u) -ne 0 ]]; then
  echo "This script must be run as root or with sudo."
  exit 1
fi

echo "Deploying application..."

# Update system packages and install Node.js and npm
echo "Updating system packages and installing Node.js and npm..."
sudo apt update && sudo apt install -y nodejs npm ruby-full build-essential zlib1g-dev
if [[ $? -ne 0 ]]; then
  echo "Failed to install Node.js or npm. Exiting."
  exit 1
fi

# Install PM2 globally
echo "Installing PM2 globally..."
sudo npm install -g pm2
if [[ $? -ne 0 ]]; then
  echo "Failed to install PM2. Exiting."
  exit 1
fi

# Navigate to the project directory
echo "Changing directory to the project..."
cd /home/ubuntu/Project
if [[ $? -ne 0 ]]; then
  echo "Failed to navigate to /home/ubuntu/Project. Exiting."
  exit 1
fi

# Load rbenv automatically
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Stop any running instances of the app
echo "Stopping any running PM2 processes for 'calendar'..."
pm2 stop calendar || true

# Install project dependencies
echo "Installing project dependencies via npm..."
npm install
if [[ $? -ne 0 ]]; then
  echo "Failed to install npm dependencies. Exiting."
  exit 1
fi

echo "Installing Ruby gems..."
bundle install
if [[ $? -ne 0 ]]; then
  echo "Failed to install Ruby gems. Exiting."
  exit 1
fi

# Precompile assets
echo "Precompiling assets..."
SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile
if [[ $? -ne 0 ]]; then
  echo "Failed to precompile assets. Exiting."
  exit 1
fi

# Start the app with PM2 in production mode
echo "Starting the app in production mode with PM2..."
pm2 start --name calendar -- bundle exec rails server -b 0.0.0.0 -p 3000
if [[ $? -ne 0 ]]; then
  echo "Failed to start the application with PM2. Exiting."
  exit 1
fi

echo "Deployment successful."
