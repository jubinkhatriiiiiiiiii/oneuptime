#!/bin/bash

# GitHub Codespaces OneUptime startup script
echo "🚀 Starting OneUptime in GitHub Codespaces..."

# Set environment variables for Codespaces
export CODESPACE_URL="https://${CODESPACE_NAME}-80.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"

# Update config.env with Codespace URL
echo "⚙️ Updating configuration for Codespaces..."
sed -i "s|HOST=.*|HOST=${CODESPACE_NAME}-80.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}|g" config.env
sed -i "s|HTTP_PROTOCOL=.*|HTTP_PROTOCOL=https|g" config.env
sed -i "s|ONEUPTIME_HTTP_PORT=.*|ONEUPTIME_HTTP_PORT=80|g" config.env

# Update probe URLs
sed -i "s|GLOBAL_PROBE_1_ONEUPTIME_URL=.*|GLOBAL_PROBE_1_ONEUPTIME_URL=${CODESPACE_URL}|g" config.env
sed -i "s|GLOBAL_PROBE_2_ONEUPTIME_URL=.*|GLOBAL_PROBE_2_ONEUPTIME_URL=${CODESPACE_URL}|g" config.env

echo "🐳 Starting Docker services..."

# Start services using the simplified compose file
export $(grep -v '^#' config.env | xargs)
docker-compose -f .devcontainer/docker-compose.codespaces.yml up -d

echo "⏳ Waiting for services to start..."
sleep 30

echo "✅ OneUptime is starting up!"
echo "🌐 Your app will be available at: ${CODESPACE_URL}"
echo "📊 Check status with: docker-compose -f .devcontainer/docker-compose.codespaces.yml ps"
echo "📝 View logs with: docker-compose -f .devcontainer/docker-compose.codespaces.yml logs -f"