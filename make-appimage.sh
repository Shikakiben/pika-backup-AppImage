#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q pika-backup | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/scalable/apps/org.gnome.World.PikaBackup.svg
export DESKTOP=/usr/share/applications/org.gnome.World.PikaBackup.desktop

# Deploy dependencies
quick-sharun /usr/bin/pika-backup \
             /usr/bin/borg \
             /usr/lib/python3.13/site-packages/borg \
             /usr/bin/ssh

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage
