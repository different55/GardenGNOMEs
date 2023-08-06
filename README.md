# GardenGNOMEs
A messy handful of scripts to get GNOME up and running on the Steam Deck.

![Screenshot of GNOME running on the Steam Deck](https://github.com/different55/GardenGNOME/assets/585419/d6b4790a-2c74-41aa-a4fc-c958401157c5)

Sticking on the Stable update channel is HIGHLY recommended. Both to minimize the number of updates and because Beta and Preview are often subtly broken. Not even Stable is immune though, so do all of this at your own risk.

## desktopgnome.sh

`desktopgnome.sh` installs GNOME and makes it the default Desktop Mode. Just log out to return to Game Mode. To set Plasma back to being the default, run:

`sudo mv /usr/bin/startplasma-x11.bak /usr/bin/startplasma-x11`

Currently, `desktopgnome.sh` needs to be manually run every OS update. It's possible to set up a systemd unit to automatically run it on boot, but that work hasn't been done yet. Pull requests are welcomed with open arms!

Here's a few more snippets that might come in handy:

`xinput set-prop "FTS3528:00 2808:1015" Coordinate\ Transformation\ Matrix 1 0 0 0 1 0 0 0 1`

This doesn't seem to be needed anymore, but in the past the touchscreen would be rotated 90 degrees, and this resets the orientation. It needed to be run every time you booted into Desktop Mode.

`steam -silent`

This launches Steam entirely silently and entirely in the background, the same way the KDE session does. This gives you the full desktop input mappings and on-screen keyboard that you have in Plasma.

## Troubleshooting

You can usually get back to a sane-ish state by switching your update channel to Preview, installing all updates, then switching back to Stable and again installing all updates.
