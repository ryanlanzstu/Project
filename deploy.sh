#!/bin/bash

# Ensuring the script is run with sudo or root privileges
if [[ $(id -u) -ne 0 ]]; then
  echo "This script must be run as root or with sudo."
  exit 1
fi

# Update system and install Node.js and npm
echo "Updating system packages and installing Node.js and npm..."
sudo apt update && sudo apt install -y nodejs npm
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

# Install Ruby dependencies
echo "Installing Ruby gems..."
bundle install
if [[ $? -ne 0 ]]; then
  echo "Failed to install Ruby gems. Exiting."
  exit 1
fi

# Precompile assets with a dummy secret key base
echo "Precompiling assets..."
SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile
if [[ $? -ne 0 ]]; then
  echo "Failed to precompile assets. Exiting."
  exit 1
fi

# Set the actual SECRET_KEY_BASE environment variable
export SECRET_KEY_BASE=your_generated_secret_key

# Install PRIV & SERVER KEYS
echo $PRIVATE_KEY > privatekey.pem
echo $SERVER > server.crt

# Start the app with PM2 in production mode
echo "Starting the app in production mode with PM2..."
pm2 start --name calendar -- bundle exec rails server -b 0.0.0.0 -p 3000
if [[ $? -ne 0 ]]; then
  echo "Failed to start the application with PM2. Exiting."
  exit 1
fi

echo "Deployment successful."
