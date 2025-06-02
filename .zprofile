# Created by `pipx` on 2025-05-14 20:35:39
export PATH="$PATH:/home/dirtyak/.local/bin"

# For GTK apps
export GTK_THEME="Arc-Dark"

# For Qt5 apps
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_STYLE_OVERRIDE=kvantum

if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
  exec sway
fi
