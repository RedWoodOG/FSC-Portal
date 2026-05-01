#!/bin/bash
# Copy entire project to /fsc_portal
# Run: bash COPY_TO_FSC_PORTAL.sh

set -e

SOURCE="/home/jwhite3321/vyrevault-website/portal"
TARGET="/fsc_portal"

echo "📦 Copying Financial Systems Corp Portal to $TARGET"
echo "=================================================="
echo ""

# Create target directory
echo "Creating target directory..."
sudo mkdir -p "$TARGET"
sudo chown -R jwhite3321:jwhite3321 "$TARGET"

# Copy everything
echo "Copying files..."
rsync -av --progress \
    "$SOURCE/" "$TARGET/" \
    --exclude 'node_modules' \
    --exclude '.env' \
    --exclude 'dist' \
    --exclude '.git' \
    --exclude '*.log' \
    --exclude '.DS_Store' \
    --exclude 'uploads'

echo ""
echo "✅ Copy complete!"
echo ""
echo "Location: $TARGET"
echo ""
echo "To install dependencies:"
echo "  cd $TARGET/server"
echo "  npm install"
echo ""
echo "To copy .env:"
echo "  cp $SOURCE/server/.env $TARGET/server/.env"
