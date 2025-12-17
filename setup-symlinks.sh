#!/bin/bash

# Dotfiles setup script
# This script creates symbolic links for all dotfiles from /common and /mac directories
# to appropriate locations in the user's home directory

set -e

# Configuration
DOTFILES_DIR="$(pwd)"
HOME_DIR="$HOME"
COMMON_DIR="$DOTFILES_DIR/common"
MAC_DIR="$DOTFILES_DIR/mac"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Create symbolic link with proper error handling
create_symlink() {
    local source_file="$1"
    local target_file="$2"

    # Create target directory if it doesn't exist
    local target_dir=$(dirname "$target_file")
    mkdir -p "$target_dir"

    # Check if target already exists
    if [ -e "$target_file" ]; then
        if [ -L "$target_file" ]; then
            # Target is already a symlink, check if it points to the right place
            if [ "$(readlink "$target_file")" = "$source_file" ]; then
                log_warning "Symlink already exists: $target_file -> $source_file"
                return 0
            else
                log_warning "Symlink exists but points elsewhere: $target_file"
                read -p "Do you want to replace it? (y/n) " -n 1 -r
                echo
                if [[ $REPLY =~ ^[Yy]$ ]]; then
                    rm "$target_file"
                else
                    log_warning "Skipping: $target_file"
                    return 0
                fi
            fi
        else
            log_warning "File already exists: $target_file"
            read -p "Do you want to replace it with a symlink? (y/n) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                rm -rf "$target_file"
            else
                log_warning "Skipping: $target_file"
                return 0
            fi
        fi
    fi

    # Create the symlink
    ln -sf "$source_file" "$target_file"
    log_success "Created symlink: $target_file -> $source_file"
}

# Process files from a directory and its subdirectories
process_directory() {
    local source_dir="$1"
    local prefix="$2"  # Added prefix for the target path (like .config for configs)

    if [ ! -d "$source_dir" ]; then
        log_warning "Directory does not exist: $source_dir"
        return
    fi

    log_info "Processing directory: $source_dir"

    # Find all items in the directory (excluding hidden directories like .git)
    find "$source_dir" -type f \( ! -path "*/.git/*" \) -o -type d \( ! -path "*/.git" \) \
    \( ! -path "*/.git" \) | while read -r item; do
        # Calculate relative path from source_dir
        local relative_path="${item#$source_dir/}"
        local target_path="$HOME_DIR/$prefix"

        # Determine the full target path
        if [[ "$relative_path" == "$source_dir" ]]; then
            # This is the directory itself
            target_path="$HOME_DIR/$prefix"
        else
            target_path="$HOME_DIR/$prefix/$relative_path"
        fi

        # Skip directories - they will be created as needed for files
        if [ -d "$item" ]; then
            continue
        fi

        # Create the symlink
        create_symlink "$item" "$target_path"
    done
}

# Setup function for nvim config
setup_nvim_config() {
    local nvim_source="$COMMON_DIR/nvim"
    local nvim_target="$HOME_DIR/.config/nvim"

    if [ -d "$nvim_source" ]; then
        create_symlink "$nvim_source" "$nvim_target"
    fi
}

# Setup function for ghostty config
setup_ghostty_config() {
    local ghostty_source="$COMMON_DIR/ghostty_config"
    local ghostty_target="$HOME_DIR/.config/ghostty/config"

    if [ -f "$ghostty_source" ]; then
        # Create the parent directory if it doesn't exist
        mkdir -p "$(dirname "$ghostty_target")"
        create_symlink "$ghostty_source" "$ghostty_target"
    fi
}

# Setup yazi config
setup_yazi_config() {
    local yazi_source="$COMMON_DIR/yazi.toml"
    local yazi_target="$HOME_DIR/.config/yazi/config.toml"

    if [ -f "$yazi_source" ]; then
        # Create the parent directory if it doesn't exist
        mkdir -p "$(dirname "$yazi_target")"
        create_symlink "$yazi_source" "$yazi_target"
    fi
}

# Setup gemini config
setup_gemini_config() {
    local gemini_source="$DOTFILES_DIR/.gemini"
    local gemini_target="$HOME_DIR/.gemini"

    # Create .gemini directory if it doesn't exist
    mkdir -p "$gemini_target"

    if [ -f "$gemini_source/settings.json" ]; then
        create_symlink "$gemini_source/settings.json" "$gemini_target/settings.json"
    fi

    if [ -d "$gemini_source/commands" ]; then
        create_symlink "$gemini_source/commands" "$gemini_target/commands"
    fi
}

# Process dotfiles in common directory
log_info "Setting up common dotfiles..."

# Set up individual dotfiles
for file in "$COMMON_DIR"/.*; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        # Skip special files
        if [[ "$filename" == "." || "$filename" == ".." || "$filename" == ".git" || "$filename" == ".DS_Store" ]]; then
            continue
        fi
        
        create_symlink "$file" "$HOME_DIR/$filename"
    fi
done

# Set up nvim config
setup_nvim_config

# Set up ghostty config
setup_ghostty_config

# Set up yazi config
setup_yazi_config

# Set up gemini config
setup_gemini_config

# Process files in mac directory (macOS specific)
if [[ "$OSTYPE" == "darwin"* ]]; then
    log_info "Setting up macOS-specific dotfiles..."
    
    # Handle .aerospace.toml
    if [ -f "$MAC_DIR/.aerospace.toml" ]; then
        create_symlink "$MAC_DIR/.aerospace.toml" "$HOME_DIR/.config/aerospace/aerospace.toml"
    fi
    
    # Handle Brewfile (link to ~/ for easy access)
    if [ -f "$MAC_DIR/Brewfile" ]; then
        create_symlink "$MAC_DIR/Brewfile" "$HOME_DIR/Brewfile"
    fi
    
    # Handle Raycast config (special case with spaces in filename)
    raycast_config=$(find "$MAC_DIR" -name "*rayconfig*" 2>/dev/null | head -1)
    if [ -n "$raycast_config" ] && [ -f "$raycast_config" ]; then
        create_symlink "$raycast_config" "$HOME_DIR/.config/raycast/raycast.rayconfig"
    fi
    
    # Handle BTT (BetterTouchTool) config (special case with spaces in filename)
    btt_config=$(find "$MAC_DIR" -name "*.bttpreset" 2>/dev/null | head -1)
    if [ -n "$btt_config" ] && [ -f "$btt_config" ]; then
        create_symlink "$btt_config" "$HOME_DIR/.config/btt/config.bttpreset"
    fi
fi

log_success "Dotfiles setup complete!"
log_info "Don't forget to reload your shell configuration: source ~/.zshrc"