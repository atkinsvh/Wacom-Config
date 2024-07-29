#!/bin/bash

# Ensure the tablet is connected and recognized
lsusb | grep -i wacom
if [ $? -ne 0 ]; then
    echo "Wacom tablet not detected. Please check the connection."
    exit 1
fi

# Map the tablet to the potential output (HEAD-0)
xsetwacom set "Wacom Co.,Ltd. Wacom One pen display 11.6\" Stylus stylus" MapToOutput HEAD-0
xsetwacom set "Wacom Co.,Ltd. Wacom One pen display 11.6\" Stylus eraser" MapToOutput HEAD-0

# Set the tablet area to match the screen resolution
xsetwacom set "Wacom Co.,Ltd. Wacom One pen display 11.6\" Stylus stylus" Area 0 0 3440 1440
xsetwacom set "Wacom Co.,Ltd. Wacom One pen display 11.6\" Stylus eraser" Area 0 0 3440 1440

echo "Wacom tablet has been mapped to mirror the display (HEAD-0) and area set to match screen resolution."
