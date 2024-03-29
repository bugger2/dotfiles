#!/bin/sh

pipewire &
pipewire-pulse &
wireplumber &
mpv /opt/sounds/startup-01.mp3 &
xsetroot -cursor_name left_ptr
setxkbmap -option ctrl:nocaps
xset r rate 200 65
xcompmgr &
if [ $1 != "--no-polybar" ]; then ~/.config/polybar/launch.sh; fi
emacs --daemon &
#wallpaper.sh
feh --bg-scale ~/.local/share/wallpapers/wallpaper.jpg
natScroll.sh
batsignal -M 'dunstify' &
mpd

# make java apps work
export _JAVA_AWT_WM_NONREPARENTING=1
wmname "LG3D"
