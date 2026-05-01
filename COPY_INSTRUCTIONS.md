# Copy Project to /fsc_portal

## Quick Copy

Run this command:

```bash
cd /home/jwhite3321/vyrevault-website/portal
bash COPY_TO_FSC_PORTAL.sh
```

This will:
1. Create `/fsc_portal` directory
2. Copy all project files (excluding node_modules, .env, dist)
3. Set proper ownership

## Manual Copy

If you prefer to do it manually:

```bash
# Create directory
sudo mkdir -p /fsc_portal
sudo chown jwhite3321:jwhite3321 /fsc_portal

# Copy files
cd /home/jwhite3321/vyrevault-website
rsync -av portal/ /fsc_portal/ \
    --exclude 'node_modules' \
    --exclude '.env' \
    --exclude 'dist' \
    --exclude '.git'
```

## After Copying

1. **Install dependencies:**
   ```bash
   cd /fsc_portal/server
   npm install
   ```

2. **Copy .env file:**
   ```bash
   cp /home/jwhite3321/vyrevault-website/portal/server/.env /fsc_portal/server/.env
   ```

3. **Continue setup:**
   ```bash
   cd /fsc_portal/server
   npm run db:generate
   npm run db:migrate
   npm run db:seed
   npm run dev
   ```

## What Gets Copied

- ✅ All source code (.ts, .js, .prisma files)
- ✅ Configuration files (package.json, tsconfig.json, etc.)
- ✅ Documentation (.md files)
- ✅ Scripts (.sh files)
- ✅ Database schemas (.sql files)

## What Gets Excluded

- ❌ node_modules (will be reinstalled)
- ❌ .env (copy manually for security)
- ❌ dist (build output)
- ❌ .git (version control)
