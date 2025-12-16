#!/bin/bash
# Backup DESIGN_PORTFOLIO_FINAL to external backups folder, excluding any 'psyche' folders

SOURCE="$(cd "$(dirname "$0")" && pwd)"
DEST="$HOME/backups/DESIGN_PORTFOLIO_FINAL_backup_$(date +%Y-%m-%d_%H-%M-%S)"

# Create destination folder
mkdir -p "$DEST"

# Use rsync to copy all files, excluding 'psyche' folders and this script
rsync -av --exclude 'psyche' --exclude 'backup_project.bat' --exclude 'backup_project.sh' "$SOURCE/" "$DEST/"

# Done
echo "Backup complete! Files copied to $DEST"
