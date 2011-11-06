#!/bin/bash

# update package list
sudo apt-get update

# upgrade all packages
sudo apt-get upgrade

# install new applications
sudo apt-get install monodevelop monodevelop-nunit mono-vbnc monodevelop-vala monodevelop-database mono-xsp monodevelop-versioncontrol dconf-tools lastfm git git-cola frozen-bubble filezilla pinta audacity pitivi mplayer cryptkeeper compizconfig-settings-manager

# gstreamer
sudo apt-get install gstreamer0.10-plugins-ugly gstreamer0.10-ffmpeg gstreamer0.10-plugins-bad

# clean up unused packages
sudo apt-get autoclean


# Stop auto hiding unity 2d launcher
# You will need to restart the system after doing this.
dconf write /com/canonical/unity-2d/launcher/use-strut true

# To re-enable auto hide run
# dconf write /com/canonical/unity-2d/launcher/use-strut 0

# white list application panel
# Only works with unity 3d
gsettings set com.canonical.Unity.Panel systray-whitelist "['JavaEmbeddedFrame', 'Wine', 'scp-dbus-service', 'Update-notifier', 'cryptkeeper']"
setsid unity




