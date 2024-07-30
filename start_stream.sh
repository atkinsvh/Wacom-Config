#!/bin/bash

# Define the resolution and frame rate
RESOLUTION="1920x1080"
FRAME_RATE="30"
DEVICE_INDEX="0"

# Stream the display using FFmpeg over TCP
ffmpeg -f avfoundation -framerate $FRAME_RATE -i "$DEVICE_INDEX" -vf scale=$RESOLUTION -c:v libvpx -f webm tcp://192.168.1.41:5000
