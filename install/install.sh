#!/bin/bash
# Sway + Waybar Configuration Installer for Arch Linux
# Author: dirtyak
# Description: Installs and configures Sway window manager with Waybar

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d_%H%M%S)"

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

# Check if running on Arch Linux
check_archlinux() {
    if ! command -v pacman &> /dev/null; then
        log_error "This installer is designed for Arch Linux systems only."
        exit 1
    fi
}

# Backup existing configuration
backup_configs() {
    log_info "Creating backup of existing configurations..."

    mkdir -p "$BACKUP_DIR"

    local configs=("sway" "waybar" "alacritty" "wofi")
    for config in "${configs[@]}"; do
        if [ -d "$CONFIG_DIR/$config" ]; then
            log_info "Backing up $config configuration..."
            cp -r "$CONFIG_DIR/$config" "$BACKUP_DIR/"
        fi
    done

    log_success "Backup created in: $BACKUP_DIR"
}

# Install required packages
install_packages() {
    log_info "Installing required packages..."

    local packages=(
        # Core packages
        sway waybar alacritty wofi swaylock swayidle swaynag
        grim slurp mako

        # Audio
        pulseaudio pulseaudio-alsa pavucontrol alsa-utils

        # Network
        networkmanager network-manager-applet

        # Power management
        power-profiles-daemon upower

        # System utilities
        htop thunar firefox rofi libnotify

        # Fonts
        ttf-font-awesome ttf-nerd-fonts-symbols ttf-jetbrains-mono-nerd

        # Additional utilities
        jq curl python brightnessctl imagemagick
    )

    if ! pacman -Q "${packages[@]}" &>/dev/null; then
        log_info "Installing packages with pacman..."
        sudo pacman -S --needed "${packages[@]}"
    else
        log_success "All required packages are already installed."
    fi
}

# Install configuration files
install_configs() {
    log_info "Installing configuration files..."

    # Create config directories if they don't exist
    mkdir -p "$CONFIG_DIR"

    # Copy configurations
    cp -r "$REPO_DIR/config/"* "$CONFIG_DIR/"

    # Make scripts executable
    chmod +x "$CONFIG_DIR/sway/scripts/"*

    log_success "Configuration files installed."
}

# Install scripts to PATH
install_scripts() {
    log_info "Installing scripts to /usr/local/bin..."

    sudo mkdir -p /usr/local/bin

    # Install scripts with sway- prefix
    sudo install -m755 "$REPO_DIR/scripts/blur-lock" /usr/local/bin/sway-blur-lock
    sudo install -m755 "$REPO_DIR/scripts/power-profiles" /usr/local/bin/sway-power-profiles
    sudo install -m755 "$REPO_DIR/scripts/powermenu" /usr/local/bin/sway-powermenu
    sudo install -m755 "$REPO_DIR/scripts/volume_brightness.sh" /usr/local/bin/sway-volume-brightness

    log_success "Scripts installed to /usr/local/bin/"
}

# Configure system services
configure_services() {
    log_info "Configuring system services..."

    # Enable NetworkManager
    sudo systemctl enable NetworkManager.service
    sudo systemctl start NetworkManager.service

    # Enable power-profiles-daemon
    sudo systemctl enable power-profiles-daemon.service
    sudo systemctl start power-profiles-daemon.service

    log_success "System services configured."
}

# Post-installation instructions
post_install() {
    cat << 'EOF'

🎉 Installation completed successfully!

Next steps:
1. Log out and select "Sway" from your display manager login screen
2. Or start Sway manually by running: sway
3. If you encounter any issues, check the logs with: journalctl -xe

Keybindings:
- Mod4+Enter: Open terminal (Alacritty)
- Mod4+D: Open application launcher (Wofi)
- Mod4+Shift+Q: Close window
- Mod4+Shift+E: Open power menu
- Mod4+L: Lock screen
- XF86Audio*: Volume controls
- XF86MonBrightness*: Brightness controls

Configuration files are located in: ~/.config/sway/
Scripts are available in: /usr/local/bin/

If you need to restore your previous configuration, it's backed up in:
EOF
    echo "$BACKUP_DIR"
}

# Main installation function
main() {
    echo "========================================"
    echo "  Sway + Waybar Configuration Installer"
    echo "========================================"

    check_archlinux

    read -p "This will install Sway window manager and Waybar. Continue? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log_info "Installation cancelled."
        exit 0
    fi

    backup_configs
    install_packages
    install_configs
    install_scripts
    configure_services

    post_install
}

# Run main function
main "$@"