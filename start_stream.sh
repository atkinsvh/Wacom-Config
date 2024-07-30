#!/bin/bash

# Define the resolution and frame rate
RESOLUTION="1920x1080"
FRAME_RATE="30"

# Stream the display using FFmpeg
ffmpeg -f avfoundation -framerate $FRAME_RATE -i "1" -vf scale=$RESOLUTION -f mpegts udp://192.168.1.41:12345
