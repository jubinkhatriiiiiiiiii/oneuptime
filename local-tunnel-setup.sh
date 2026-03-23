#!/bin/bash

# Local OneUptime with Public Access Setup
echo "🏠 Setting up OneUptime locally with public access..."

# Install ngrok for tunneling (alternative to paid services)
echo "📡 Installing ngrok..."
curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null
echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list
sudo apt update && sudo apt install ngrok

# Alternative: Install localtunnel (completely free)
echo "📡 Installing localtunnel as backup..."
npm install -g localtunnel

# Start OneUptime locally
echo "🚀 Starting OneUptime..."
npm start &

# Wait for OneUptime to start
sleep 30

# Create public tunnel
echo "🌐 Creating public tunnel..."
echo "Choose your tunneling method:"
echo "1. ngrok (requires free account): ngrok http 80"
echo "2. localtunnel (no account needed): lt --port 80 --subdomain yoursite"

# Example with localtunnel
lt --port 80 --subdomain oneuptime-yourname