#!/bin/bash

# Ensure the tablet is connected and recognized
lsusb | grep -i wacom
if [ $? -ne 0 ]; then
    echo "Wacom tablet not detected. Please check the USB-C connection."
    exit 1
fi

# Map the tablet to mirror the primary display (DP-0)
xsetwacom set "Wacom Co.,Ltd. Wacom One pen display 11.6\" Stylus stylus" MapToOutput DP-0
xsetwacom set "Wacom Co.,Ltd. Wacom One pen display 11.6\" Stylus eraser" MapToOutput DP-0

echo "Wacom tablet has been mapped to mirror the primary display (DP-0)."
