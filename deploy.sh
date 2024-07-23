
# Update system and install nodejs and npm
sudo apt update && sudo apt install nodejs npm -y

# Install pm2
sudo npm install -g pm2

# Stop any running instances
pm2 stop calendar

# Change directory to the project
cd /home/ubuntu/Project


# Install dependencies
npm install

# Start the app with PM2 in production mode
pm2 start ./bin/www --name calendar
