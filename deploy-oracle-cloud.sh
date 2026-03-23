#!/bin/bash

# Complete OneUptime deployment script for Oracle Cloud
set -e

echo "🚀 Starting OneUptime deployment on Oracle Cloud..."

# Variables (replace with your actual values)
DOMAIN="yoursite.tk"
EMAIL="your-email@example.com"

# Update system
echo "📦 Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install Docker if not present
if ! command -v docker &> /dev/null; then
    echo "🐳 Installing Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
    rm get-docker.sh
fi

# Install Docker Compose if not present
if ! command -v docker-compose &> /dev/null; then
    echo "🐳 Installing Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

# Install Node.js
if ! command -v node &> /dev/null; then
    echo "📦 Installing Node.js..."
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt-get install -y nodejs
fi

# Install Nginx
if ! command -v nginx &> /dev/null; then
    echo "🌐 Installing Nginx..."
    sudo apt install nginx -y
fi

# Install Certbot
if ! command -v certbot &> /dev/null; then
    echo "🔒 Installing Certbot..."
    sudo apt install certbot python3-certbot-nginx -y
fi

# Clone OneUptime if not present
if [ ! -d "/opt/oneuptime" ]; then
    echo "📥 Cloning OneUptime..."
    sudo mkdir -p /opt/oneuptime
    sudo chown $USER:$USER /opt/oneuptime
    git clone --depth 1 --single-branch --branch release https://github.com/OneUptime/oneuptime.git /opt/oneuptime
fi

# Navigate to OneUptime directory
cd /opt/oneuptime

# Copy configuration
echo "⚙️ Setting up configuration..."
cp config.example.env config.env

# Update domain in config
sed -i "s/yoursite.tk/$DOMAIN/g" config.env

# Install npm dependencies
echo "📦 Installing dependencies..."
npm install

# Configure Nginx
echo "🌐 Configuring Nginx..."
sudo cp nginx-oneuptime.conf /etc/nginx/sites-available/oneuptime
sudo sed -i "s/yoursite.tk/$DOMAIN/g" /etc/nginx/sites-available/oneuptime
sudo ln -sf /etc/nginx/sites-available/oneuptime /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default

# Test Nginx configuration
sudo nginx -t

# Start Nginx
sudo systemctl enable nginx
sudo systemctl restart nginx

# Configure firewall
echo "🔥 Configuring firewall..."
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw --force enable

# Get SSL certificate
echo "🔒 Getting SSL certificate..."
sudo certbot --nginx -d $DOMAIN -d www.$DOMAIN --non-interactive --agree-tos --email $EMAIL

# Start OneUptime
echo "🚀 Starting OneUptime..."
npm start

# Create systemd service for OneUptime
echo "⚙️ Creating systemd service..."
sudo tee /etc/systemd/system/oneuptime.service > /dev/null <<EOF
[Unit]
Description=OneUptime Monitoring Platform
After=network.target docker.service
Requires=docker.service

[Service]
Type=forking
User=$USER
WorkingDirectory=/opt/oneuptime
ExecStart=/usr/bin/npm start
ExecStop=/usr/bin/npm run stop
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

# Enable and start service
sudo systemctl daemon-reload
sudo systemctl enable oneuptime
sudo systemctl start oneuptime

echo "✅ OneUptime deployment completed!"
echo "🌐 Your site should be available at: https://$DOMAIN"
echo "📊 Check status with: sudo systemctl status oneuptime"
echo "📝 View logs with: sudo journalctl -u oneuptime -f"