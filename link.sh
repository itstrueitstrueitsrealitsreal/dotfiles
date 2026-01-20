#!/bin/bash

# link.sh - Create symlinks for dotfiles
# This script creates symlinks from:
#   - home/ files -> ~/
#   - config/ directories -> ~/.config/

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' 

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="$HOME"
CONFIG_DIR="$HOME/.config"

# Check if we're in the dotfiles directory
if [ ! -d "$SCRIPT_DIR/home" ] || [ ! -d "$SCRIPT_DIR/config" ]; then
    echo -e "${RED}Error: This script must be run from the dotfiles repository root.${NC}"
    echo "Expected directories: home/ and config/"
    exit 1
fi

# Function to create symlink with backup
create_symlink() {
    local source="$1"
    local target="$2"
    local name=$(basename "$target")
    
    # Check if target already exists
    if [ -e "$target" ] || [ -L "$target" ]; then
        if [ -L "$target" ]; then
            # Check if it's already the correct symlink
            local current_link=$(readlink "$target")
            if [ "$current_link" = "$source" ]; then
                echo -e "${BLUE}✓${NC} $name is already linked correctly"
                return 0
            else
                echo -e "${YELLOW}⚠${NC} $name exists as symlink to different location: $current_link"
            fi
        else
            echo -e "${YELLOW}⚠${NC} $name already exists (not a symlink)"
        fi
        
        # Ask user what to do
        echo -e "${YELLOW}What would you like to do?${NC}"
        echo "  [b]ackup and replace"
        echo "  [s]kip"
        echo "  [o]verwrite (delete existing)"
        read -p "Choice (b/s/o): " choice
        
        case $choice in
            b|B)
                local backup="${target}.backup.$(date +%Y%m%d_%H%M%S)"
                echo -e "${BLUE}Backing up to: $backup${NC}"
                mv "$target" "$backup"
                ;;
            o|O)
                echo -e "${YELLOW}Removing existing $name${NC}"
                rm -rf "$target"
                ;;
            s|S|*)
                echo -e "${BLUE}Skipping $name${NC}"
                return 0
                ;;
        esac
    fi
    
    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$target")"
    
    # Create symlink
    ln -sfn "$source" "$target"
    echo -e "${GREEN}✓${NC} Linked $name -> $source"
}

# Process files in home/
echo -e "${BLUE}=== Linking files from home/ to ~/${NC}"
if [ -d "$SCRIPT_DIR/home" ]; then
    for file in "$SCRIPT_DIR/home"/.* "$SCRIPT_DIR/home"/*; do
        # Skip . and .. entries
        [ -e "$file" ] || continue
        filename=$(basename "$file")
        # Skip .git and other hidden system files if needed
        [ "$filename" = "." ] && continue
        [ "$filename" = ".." ] && continue
        
        source="$file"
        target="$HOME_DIR/$filename"
        create_symlink "$source" "$target"
    done
else
    echo -e "${YELLOW}Warning: home/ directory not found${NC}"
fi

# Process directories in config/
echo ""
echo -e "${BLUE}=== Linking directories from config/ to ~/.config/${NC}"
if [ -d "$SCRIPT_DIR/config" ]; then
    # Ensure ~/.config exists
    mkdir -p "$CONFIG_DIR"
    
    for item in "$SCRIPT_DIR/config"/*; do
        # Skip if no matches
        [ -e "$item" ] || continue
        
        name=$(basename "$item")
        source="$item"
        target="$CONFIG_DIR/$name"
        create_symlink "$source" "$target"
    done
else
    echo -e "${YELLOW}Warning: config/ directory not found${NC}"
fi

echo ""
echo -e "${GREEN}=== Done!${NC}"

