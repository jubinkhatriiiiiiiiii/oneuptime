# Render Free Deployment Guide

## Setup Steps

1. **Sign Up**
   - Go to render.com
   - Sign up with GitHub (no credit card needed)

2. **Create Web Service**
   - Click "New" → "Web Service"
   - Connect your OneUptime GitHub repo
   - Choose "Docker" as environment

3. **Configure Service**
   ```
   Name: oneuptime
   Region: Oregon (US West)
   Branch: release
   Build Command: (leave empty)
   Start Command: npm start
   ```

4. **Add Environment Variables**
   Copy from your config.env:
   ```
   ONEUPTIME_SECRET=your-secret
   DATABASE_PASSWORD=your-db-password
   REDIS_PASSWORD=your-redis-password
   HOST=your-app-name.onrender.com
   ```

5. **Add Database**
   - Create PostgreSQL service (free 90 days)
   - Create Redis service (free 90 days)

6. **Deploy**
   - Click "Create Web Service"
   - Wait for deployment (5-10 minutes)

## Free Tier Limits
- ✅ 750 hours/month
- ✅ Custom domains supported
- ⚠️ Spins down after 15 minutes of inactivity
- ⚠️ Cold start delay