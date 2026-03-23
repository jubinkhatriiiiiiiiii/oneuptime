#!/bin/bash

# Oracle Cloud Instance Setup Script for OneUptime
echo "Setting up Oracle Cloud instance for OneUptime..."

# Update system
sudo apt update && sudo apt upgrade -y

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install Git
sudo apt install git -y

# Install Nginx (for reverse proxy)
sudo apt install nginx -y

# Install Certbot for SSL
sudo apt install certbot python3-certbot-nginx -y

# Create OneUptime directory
mkdir -p /opt/oneuptime
cd /opt/oneuptime

echo "Basic setup complete! Now clone your OneUptime repository."
echo "Run: git clone https://github.com/OneUptime/oneuptime.git ."