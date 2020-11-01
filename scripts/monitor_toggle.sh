#!/bin/zsh

if [[ ! -e /tmp/HDMI_ONLY ]] ; then
    xrandr --output eDP-1 --off --output HDMI-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal
    touch /tmp/HDMI_ONLY
else
    xrandr --output eDP-1 --mode 1920x1080 --pos 0x125 --rotate normal --output HDMI-1 --primary --mode 1920x1080 --pos 1920x0 --rotate normal
    rm /tmp/HDMI_ONLY
fi
