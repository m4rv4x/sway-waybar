# Maintainer: Your Name <your.email@example.com>
pkgname=sway-waybar-config
pkgver=1.0.0
pkgrel=1
pkgdesc="Sway window manager and Waybar configuration with scripts"
arch=('any')
url="https://github.com/dirtyak/sway-waybar"
license=('MIT')
depends=(
    'sway'
    'waybar'
    'alacritty'
    'wofi'
    'swaylock'
    'swayidle'
    'swaynag'
    'grim'
    'slurp'
    'mako'
    'pulseaudio'
    'pulseaudio-alsa'
    'pavucontrol'
    'alsa-utils'
    'networkmanager'
    'network-manager-applet'
    'power-profiles-daemon'
    'upower'
    'htop'
    'thunar'
    'firefox'
    'rofi'
    'libnotify'
    'ttf-font-awesome'
    'ttf-nerd-fonts-symbols'
    'ttf-jetbrains-mono-nerd'
    'jq'
    'curl'
    'python'
    'brightnessctl'
    'imagemagick'
)
optdepends=(
    'rofi: alternative launcher for power-profiles script'
    'zenity: alternative launcher for scripts'
)
source=("git+https://github.com/dirtyak/sway-waybar.git")
sha256sums=('SKIP')

package() {
    cd "$srcdir/sway-waybar"

    # Create directories
    install -dm755 "$pkgdir/usr/share/sway-waybar-config"
    install -dm755 "$pkgdir/usr/bin"

    # Install configuration files
    cp -r config/* "$pkgdir/usr/share/sway-waybar-config/"

    # Install scripts
    install -Dm755 scripts/blur-lock "$pkgdir/usr/bin/sway-blur-lock"
    install -Dm755 scripts/power-profiles "$pkgdir/usr/bin/sway-power-profiles"
    install -Dm755 scripts/powermenu "$pkgdir/usr/bin/sway-powermenu"
    install -Dm755 scripts/volume_brightness.sh "$pkgdir/usr/bin/sway-volume-brightness"

    # Install install script
    install -Dm755 install/install.sh "$pkgdir/usr/share/sway-waybar-config/install.sh"

    # Create symlink for backward compatibility
    ln -s /usr/bin/sway-blur-lock "$pkgdir/usr/share/sway-waybar-config/scripts/blur-lock"
    ln -s /usr/bin/sway-power-profiles "$pkgdir/usr/share/sway-waybar-config/scripts/power-profiles"
    ln -s /usr/bin/sway-powermenu "$pkgdir/usr/share/sway-waybar-config/scripts/powermenu"
    ln -s /usr/bin/sway-volume-brightness "$pkgdir/usr/share/sway-waybar-config/scripts/volume_brightness.sh"
}