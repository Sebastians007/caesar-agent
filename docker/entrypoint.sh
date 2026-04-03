#!/bin/bash
# Docker entrypoint: bootstrap config files into the mounted volume, then run caesar.
set -e

CAESAR_HOME="/opt/data"
INSTALL_DIR="/opt/caesar"

# Create essential directory structure.  Cache and platform directories
# (cache/images, cache/audio, platforms/whatsapp, etc.) are created on
# demand by the application — don't pre-create them here so new installs
# get the consolidated layout from get_caesar_dir().
mkdir -p "$CAESAR_HOME"/{cron,sessions,logs,hooks,memories,skills}

# .env
if [ ! -f "$CAESAR_HOME/.env" ]; then
    cp "$INSTALL_DIR/.env.example" "$CAESAR_HOME/.env"
fi

# config.yaml
if [ ! -f "$CAESAR_HOME/config.yaml" ]; then
    cp "$INSTALL_DIR/cli-config.yaml.example" "$CAESAR_HOME/config.yaml"
fi

# SOUL.md
if [ ! -f "$CAESAR_HOME/SOUL.md" ]; then
    cp "$INSTALL_DIR/docker/SOUL.md" "$CAESAR_HOME/SOUL.md"
fi

# Sync bundled skills (manifest-based so user edits are preserved)
if [ -d "$INSTALL_DIR/skills" ]; then
    python3 "$INSTALL_DIR/tools/skills_sync.py"
fi

exec caesar "$@"
