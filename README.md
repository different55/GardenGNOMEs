# GardenGNOMEs
A messy handful of scripts to get GNOME up and running on the Steam Deck.

![Screenshot of GNOME running on the Steam Deck](https://github.com/different55/GardenGNOME/assets/585419/d6b4790a-2c74-41aa-a4fc-c958401157c5)

Sticking on the Stable update channel is HIGHLY recommended. Both to minimize the number of updates and because Beta and Preview are often subtly broken. Not even Stable is immune though, so do all of this at your own risk.

## desktopgnome.sh

`desktopgnome.sh` installs GNOME and makes it the default Desktop Mode.

### Install GNOME

To install GNOME with this script, easiest way is to just run this in your terminal:

```
curl https://raw.githubusercontent.com/different55/GardenGNOMEs/refs/heads/main/desktopgnome.sh | fish
```

But keep in mind that this literally just downloads whatever I have here on GitHub and runs it, which is decidedly insecure. I invite you to read the script before running it.

### Return to Game Mode

To return to Game Mode, just log out of GNOME. The "Return to Game Mode" button in Plasma is just a log out button with a hat, nothing fancier than that.

### Return to Plasma

To set Plasma back to being the default, run:

`sudo mv /usr/bin/startplasma-x11.bak /usr/bin/startplasma-x11`

### Uninstall GNOME

Easiest way to uninstall GNOME is to set your Steam Deck Update channel to something else, apply updates, and then change it back. That'll trigger an OS update that'll wipe out GNOME. Speaking of...

### SteamOS Updates

Currently, `desktopgnome.sh` needs to be manually run every OS update. It's possible to set up a systemd unit to automatically run it on boot, but that work hasn't been done yet. Pull requests are welcomed with open arms!

Steam client updates are no problem, though. If an update says "Applying", you'll need to re-run the script. If it just immediately restarts, you're good.

### Miscellany

Here's a few more snippets that might come in handy:

`xinput set-prop "FTS3528:00 2808:1015" Coordinate\ Transformation\ Matrix 1 0 0 0 1 0 0 0 1`

This doesn't seem to be needed anymore, but in the past the touchscreen would be rotated 90 degrees, and this resets the orientation. It needed to be run every time you booted into Desktop Mode.

## Troubleshooting

You can usually get back to a sane-ish state by switching your update channel to Preview, installing all updates, then switching back to Stable and again installing all updates.
