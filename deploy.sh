sudo apt update && sudo apt install nodejs npm -y
# Install pm2
sudo npm install -g pm2
# Stop instances running
pm2 stop calendar
# Change directory
cd Project/
# Install dependencies
npm install
# Start app
pm2 start bin/rails --name calendar -- start
