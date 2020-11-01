#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 

# Launch bottom bar
echo "---" | tee -a  /tmp/bottom.log


for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#    MONITOR=$m polybar --reload top &
    MONITOR=$m polybar --reload bottom &
done

echo "Bars launched..."
