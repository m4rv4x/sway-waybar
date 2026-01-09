# Sway + Waybar Configuration

A complete, professional Sway window manager configuration with Waybar status bar, featuring custom scripts and themes optimized for Arch Linux.

![Screenshot](https://github.com/user-attachments/assets/473d7df3-43b8-40dd-8f02-00b59573e631)

## Features

- **Complete Sway Configuration**: Fully configured window manager with workspaces, keybindings, and window rules
- **Beautiful Waybar**: Custom status bar with system information, workspaces, and media controls
- **Custom Scripts**: Power management, volume/brightness controls, and screen locking
- **Theme Integration**: Consistent theming across all components
- **Arch Linux Optimized**: Specifically designed for Arch Linux with proper package management

## Installation

### Method 1: Automated Install (Recommended)

```bash
git clone https://github.com/dirtyak/sway-waybar.git
cd sway-waybar
./install/install.sh
```

The installer will:
- Install all required packages via pacman
- Backup your existing configuration
- Install configuration files to `~/.config/`
- Install scripts to `/usr/local/bin/`
- Configure system services

### Method 2: Manual Installation

#### Install Required Packages

```bash
# Core packages
sudo pacman -S sway waybar alacritty wofi swaylock swayidle swaynag grim slurp mako

# Audio
sudo pacman -S pulseaudio pulseaudio-alsa pavucontrol alsa-utils

# Network
sudo pacman -S networkmanager network-manager-applet

# Power management
sudo pacman -S power-profiles-daemon upower

# System utilities
sudo pacman -S htop thunar firefox rofi libnotify

# Fonts
sudo pacman -S ttf-font-awesome ttf-nerd-fonts-symbols ttf-jetbrains-mono-nerd

# Additional utilities
sudo pacman -S jq curl python brightnessctl imagemagick
```

#### Install Configuration

```bash
git clone https://github.com/dirtyak/sway-waybar.git
cd sway-waybar

# Backup existing config (optional)
cp -r ~/.config/sway ~/.config/sway.backup 2>/dev/null || true
cp -r ~/.config/waybar ~/.config/waybar.backup 2>/dev/null || true

# Install configuration
cp -r config/* ~/.config/

# Install scripts
sudo cp scripts/* /usr/local/bin/
sudo chmod +x /usr/local/bin/sway-*

# Enable services
sudo systemctl enable NetworkManager.service power-profiles-daemon.service
sudo systemctl start NetworkManager.service power-profiles-daemon.service
```

### Method 3: AUR Package (Future)

Once the PKGBUILD is published to AUR:

```bash
yay -S sway-waybar-config
```

## Keybindings

### Window Management
- `Mod4 + Enter` - Open terminal (Alacritty)
- `Mod4 + D` - Application launcher (Wofi)
- `Mod4 + Shift + Q` - Close window
- `Mod4 + Shift + E` - Power menu
- `Mod4 + L` - Lock screen

### Workspaces
- `Mod4 + 1-9` - Switch to workspace
- `Mod4 + Shift + 1-9` - Move window to workspace

### Media Controls
- `XF86AudioRaiseVolume` - Volume up
- `XF86AudioLowerVolume` - Volume down
- `XF86AudioMute` - Toggle mute
- `XF86MonBrightnessUp` - Brightness up
- `XF86MonBrightnessDown` - Brightness down

### Layout
- `Mod4 + S` - Stacking layout
- `Mod4 + W` - Tabbed layout
- `Mod4 + E` - Default layout
- `Mod4 + Shift + Space` - Toggle floating

## Scripts

The configuration includes several utility scripts:

- `sway-blur-lock` - Locks screen with blurred screenshot
- `sway-powermenu` - Power management menu (shutdown, reboot, etc.)
- `sway-power-profiles` - CPU power profile switcher
- `sway-volume-brightness` - Volume and brightness controls

## Customization

### Sway Configuration
Main config: `~/.config/sway/config`
- Keybindings in `config.d/keybinding.conf`
- Workspaces in `config.d/workspaces.conf`
- Autostart in `config.d/autostart.conf`

### Waybar Configuration
Config: `~/.config/waybar/config.jsonc`
Style: `~/.config/waybar/style.css`

### Alacritty Configuration
Config: `~/.config/alacritty/alacritty.toml`

## Troubleshooting

### Common Issues

1. **Screen doesn't lock properly**
   - Ensure `swaylock` is installed
   - Check that `grim` and `imagemagick` are available

2. **Volume controls don't work**
   - Install `pulseaudio` and `pavucontrol`
   - Check that `brightnessctl` is installed for brightness

3. **Power profiles not available**
   - Install `power-profiles-daemon`
   - Start the service: `sudo systemctl start power-profiles-daemon`

### Getting Help

- Check Sway logs: `journalctl -xe`
- Sway debug mode: `sway -d 2>&1 | tee sway.log`
- Waybar debug: `waybar -l debug`

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This configuration is released under the MIT License. See LICENSE file for details.

## Credits

- Original scripts based on i3pystatus wiki examples
- Icons from Font Awesome
- Fonts from Nerd Fonts
