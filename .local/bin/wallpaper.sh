#!/usr/bin/env bash

kill -9 $(top -b -n 1 | grep wal | cut -d ' ' -f3)
# wal -i ~/.local/wallpapers/"$(ls ~/.local/wallpapers/ | shuf | head -n 1)" 
wal -i ~/.local/wallpapers/wallpaper.jpg
cp ~/.cache/wal/colors.Xresources ~/.Xresources

# fixing some urxvt settings since the previous command overwrites them
echo "URxvt.font: xft:AnonymicePro Nerd Font Mono:size=15:antialias=true" >> ~/.Xresources
echo "URxvt.scrollBar: false" >> ~/.Xresources
echo "URxvt.geometry: 400x400" >> ~/.Xresources
xrdb -merge ~/.Xresources
