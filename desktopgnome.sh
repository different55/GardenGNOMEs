#!/usr/bin/env fish
# Plug for my personal favorite shell: fish, which pleasantly comes preinstalled on SteamOS.
# chsh -s (which fish)

# Disable read-only status
if test (sudo steamos-readonly status) != "disabled" 
    echo "Making SteamOS writable for upgrades"
    sudo steamos-readonly disable
end

# Prepare system for the pacman repos
echo "Preparing system for upgrade"
sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman-key --populate holo

# Install GNOME packages
echo "Installing GNOME"
sudo pacman --overwrite "*" -Syu gnome-keyring gnome-screenshot gnome-shell-extensions gnome-shell gnome-control-center gnome-tweaks gnome-software nautilus sushi xdg-user-dirs-gtk xdg-desktop-portal-gnome xorg-xinput

# Backup startplasma-x11
echo "Backing up KDE Plasma"
if not test -e /usr/bin/startplasma-x11.bak
    sudo mv --no-clobber /usr/bin/startplasma-x11 /usr/bin/startplasma-x11.bak
end

# Create startgnome-x11
echo "\
#!/bin/sh
export XDG_SESSION_TYPE=x11
export GDK_BACKEND=x11
export XDG_CURRENT_DESKTOP=GNOME
exec gnome-session
" | sudo tee /usr/bin/startgnome-x11 > /dev/null
sudo chmod 755 /usr/bin/startgnome-x11

# Replace startplasma-x11 with startgnome-x11
echo "Replacing KDE Plasma with GNOME"
sudo ln -s /usr/bin/startgnome-x11 /usr/bin/startplasma-x11

# Disable HiDPI 2x scaling
echo "Fixing UI scaling"
gsettings set org.gnome.desktop.interface scaling-factor 1

# Autostart Steam silently on GNOME
echo "Setting Steam to autostart silently on GNOME"
echo "\
[Desktop Entry]
Name=Steam
Exec=/usr/bin/steam -silent
Icon=steam
Terminal=false
Type=Application
PrefersNonDefaultGPU=true
X-KDE-RunOnDiscreteGpu=true
" > ~/.config/autostart/steam.desktop
chmod 644 ~/.config/autostart/steam.desktop

# Ask if the user wants to launch into GNOME
read -l -P "Do you want to close everything and launch GNOME now? (Y/n) " confirm
switch $confirm
    case Y y Yes yes
        steamos-session-select plasma
    case '*'
        echo "Just log out and come back to Desktop mode whenever you're ready!"
end

echo "To uninstall, switch your update channel to Preview/Stable and then back."
