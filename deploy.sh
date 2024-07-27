#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status.

echo "Deploying application..."

# Ensure the script is run with root privileges
if [[ $(id -u) -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

# Update system packages
echo "Updating system packages..."
sudo apt-get update && sudo apt-get upgrade -y

# Ensure Node.js and npm are installed
echo "Ensuring Node.js and npm are installed..."
sudo apt-get install -y nodejs npm

# Install PM2 globally
echo "Installing PM2 globally..."
sudo npm install -g pm2

# Navigate to the project directory
cd /home/ubuntu/Project
echo "Changed directory to $(pwd)"

# Check if rbenv is installed, install if not
if ! command -v rbenv &> /dev/null; then
    echo "Installing rbenv and ruby-build..."
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc
    cd ~/.rbenv && src/configure && make -C src
    cd ~
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
    echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc
fi

# Install Ruby using rbenv
RUBY_VERSION='3.1.4'
echo "Installing Ruby $RUBY_VERSION..."
rbenv install -s $RUBY_VERSION
rbenv global $RUBY_VERSION

# Restart shell to update paths
exec $SHELL

# Install Ruby dependencies
echo "Installing Ruby gems..."
bundle install

# Precompile Rails assets
echo "Precompiling assets..."
bundle exec rake assets:precompile

# Stop any currently running instances of the application
echo "Stopping any running instances of the application..."
pm2 stop calendar || true  # Ignore errors if 'calendar' is not found

# Start the application with PM2
echo "Starting the application..."
pm2 start --name calendar -- bundle exec rails server -b 0.0.0.0 -p 3000

echo "Deployment completed successfully."
