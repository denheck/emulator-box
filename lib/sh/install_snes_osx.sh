#!/bin/bash
# TODO: support for multiple emulators
# TODO: configuration file for snes9x
# TODO: maybe don't install emulators to Applications

######## OSX Specific Install Script ########

source helper.sh

# TODO: check multiple download sources in case of 404s
download_file http://www.geocities.co.jp/SiliconValley-PaloAlto/2560/release/snes9x-1.53-macosx-113.dmg.gz /tmp/snes9x.dmg.gz
extract /tmp/snes9x.dmg.gz
hdiutil mount /tmp/snes9x.dmg

snes9x_volume=$(ls /Volumes | grep -i snes9x | awk '{ print $0 }')
snes9x_app=$(ls /Volumes/"$snes9x_volume" | grep -i snes9x | grep .app | head -n1)

cp -R /Volumes/"$bsnes_volume"/"$bsnes_app" /Applications

# TODO: detect "/Volumes/BSNES v0.6.8" unmounted successfully.
hdiutil unmount /Volumes/"$bsnes_volume"

export SNES_PATH="/Applications/Snes9x 1.53/Snes9x.app/Contents/MacOS/Snes9x"
