#!/usr/bin/env fish
# Plug for my personal favorite shell: fish, which pleasantly comes preinstalled on SteamOS.
# chsh -s (which fish)

# Disable read-only status
if test (sudo steamos-readonly status) != "disabled" 
    sudo steamos-readonly disable
end

# Prepare system for the pacman repos
sudo pacman-key --init
sudo pacman-key --populate archlinux

# Install GNOME packages
sudo pacman --overwrite "*" -Syu gnome-keyring gnome-screenshot gnome-shell-extensions gnome-shell gnome-control-center gnome-tweaks gnome-software nautilus sushi xdg-user-dirs-gtk xdg-desktop-portal-gnome xorg-xinput

# Backup startplasma-x11
sudo mv --no-clobber /usr/bin/startplasma-x11 /usr/bin/startplasma-x11.bak

# Create startgnome-x11
echo "\
#!/bin/sh
export XDG_SESSION_TYPE=x11
export GDK_BACKEND=x11
exec gnome-session
" | sudo tee /usr/bin/startgnome-x11
sudo chmod 755 /usr/bin/startgnome-x11

# Replace startplasma-x11 with startgnome-x11
sudo ln -s /usr/bin/startgnome-x11 /usr/bin/startplasma-x11

# Disable HiDPI 2x scaling
gsettings set org.gnome.desktop.interface scaling-factor 1
