#!/bin/bash

# Ensure the tablet is connected and recognized
lsusb | grep -i wacom
if [ $? -ne 0 ]; then
    echo "Wacom tablet not detected. Please check the connection."
    exit 1
fi

# Map the tablet to the HDMI display (HDMI-1)
xsetwacom set "Wacom Co.,Ltd. Wacom One pen display 11.6\" Stylus stylus" MapToOutput HDMI-1
xsetwacom set "Wacom Co.,Ltd. Wacom One pen display 11.6\" Stylus eraser" MapToOutput HDMI-1

echo "Wacom tablet has been mapped to mirror the HDMI display (HDMI-1)."
