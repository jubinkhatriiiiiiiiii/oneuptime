# OneUptime on GitHub Codespaces

## 🚀 Quick Start Guide

### Step 1: Fork the Repository
1. Go to your OneUptime repository on GitHub
2. Click the "Fork" button to create your own copy

### Step 2: Create a Codespace
1. In your forked repository, click the green "Code" button
2. Select the "Codespaces" tab
3. Click "Create codespace on main" (or your branch)
4. Wait for the environment to load (2-3 minutes)

### Step 3: Start OneUptime
Once your Codespace is ready:

```bash
# Start OneUptime services
./start-codespaces.sh
```

### Step 4: Access Your Application
1. Go to the "Ports" tab in VS Code
2. Find port 80 (OneUptime Web)
3. Click the globe icon to make it public
4. Click the link to open your OneUptime instance

## 🌐 Getting Your Public URL

Your OneUptime instance will be available at:
```
https://CODESPACE_NAME-80.preview.app.github.dev
```

## 📊 Monitoring

Check service status:
```bash
docker-compose -f .devcontainer/docker-compose.codespaces.yml ps
```

View logs:
```bash
docker-compose -f .devcontainer/docker-compose.codespaces.yml logs -f
```

Stop services:
```bash
docker-compose -f .devcontainer/docker-compose.codespaces.yml down
```

## 🆓 Free Domain Setup

### Option 1: Use Codespace URL Directly
Your Codespace provides a free HTTPS URL that you can use immediately.

### Option 2: Custom Domain (Freenom)
1. Get a free domain from [Freenom.com](https://freenom.com)
2. Create a CNAME record pointing to your Codespace URL
3. Update the `HOST` variable in `config.env`

## ⚠️ Important Notes

- **Free Tier**: 60 hours per month for free accounts
- **Auto-sleep**: Codespaces sleep after 30 minutes of inactivity
- **Persistence**: Your files and configuration are saved between sessions
- **Restart**: Run `./start-codespaces.sh` after waking up from sleep

## 🔧 Troubleshooting

### Services won't start
```bash
# Check Docker status
sudo systemctl status docker

# Restart Docker if needed
sudo systemctl restart docker

# Try starting again
./start-codespaces.sh
```

### Port not accessible
1. Go to "Ports" tab in VS Code
2. Right-click on port 80
3. Select "Port Visibility" → "Public"

### Configuration issues
```bash
# Reset configuration
cp config.example.env config.env
./start-codespaces.sh
```