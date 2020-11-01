# A little script to make megasync app start when the system is already prepared, so it goes into the system tray
# I execute it in the i3 config file
#!/bin/bash
sleep 3 && /usr/bin/megasync & disown
