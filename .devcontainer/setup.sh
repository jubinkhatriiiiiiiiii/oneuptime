#!/bin/bash

# GitHub Codespaces setup script for OneUptime
echo "🚀 Setting up OneUptime in GitHub Codespaces..."

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Copy configuration if it doesn't exist
if [ ! -f "config.env" ]; then
    echo "📝 Creating config.env from example..."
    cp config.example.env config.env
fi

# Install npm dependencies
echo "📦 Installing npm dependencies..."
npm install

# Make scripts executable
chmod +x configure.sh || true
chmod +x .devcontainer/codespaces-start.sh
chmod +x start-codespaces.sh

echo "✅ Setup complete!"
echo ""
echo "🎯 To start OneUptime, run:"
echo "   ./start-codespaces.sh"
echo ""
echo "🌐 Your app will be available at the forwarded port 80"