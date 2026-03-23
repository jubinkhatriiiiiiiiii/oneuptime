# GitHub Codespaces OneUptime Deployment

## Setup Steps

1. **Fork OneUptime Repository**
   - Go to https://github.com/OneUptime/oneuptime
   - Click "Fork" to create your copy

2. **Create Codespace**
   - In your forked repo, click "Code" → "Codespaces" → "Create codespace"
   - Wait for environment to load (includes Docker)

3. **Configure OneUptime**
   ```bash
   # Copy configuration
   cp config.example.env config.env
   
   # Edit config.env with your domain
   nano config.env
   ```

4. **Start OneUptime**
   ```bash
   npm start
   ```

5. **Expose Port**
   - In Codespaces, go to "Ports" tab
   - Forward port 80 (OneUptime)
   - Make it public
   - Get the public URL (e.g., https://abc123-80.preview.app.github.dev)

6. **Use Free Domain**
   - Get free domain from Freenom.com
   - Point domain to your Codespace URL using CNAME

## Pros
- ✅ Completely free (60 hours/month)
- ✅ No credit card required
- ✅ Full Docker support
- ✅ Automatic SSL

## Cons
- ⚠️ Limited to 60 hours/month
- ⚠️ Stops when inactive