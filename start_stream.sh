#!/bin/bash

# Define the resolution and frame rate
RESOLUTION="1920x1080"
FRAME_RATE="30"
DEVICE_INDEX="0"  # Updated based on the listed devices

# Stream the display using FFmpeg
ffmpeg -f avfoundation -framerate $FRAME_RATE -i "$DEVICE_INDEX" -vf scale=$RESOLUTION -c:v libvpx -f webm - | websocat ws://192.168.1.41:8765
