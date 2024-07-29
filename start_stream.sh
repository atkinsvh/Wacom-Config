#!/bin/bash

# Ensure DISPLAY is set correctly
export DISPLAY=:1

# Define display and screen dimensions
RESOLUTION=$(xdpyinfo -display :1 | grep 'dimensions:' | awk '{print $2;}')

# Start x11vnc to capture the screen
x11vnc -display :1 -loop -noxdamage -xkb -ncache 10 -ncache_cr -shared -rfbport 5900 &

# Give x11vnc some time to start
sleep 5

# Use ffmpeg to capture the screen from x11vnc and stream it via UDP to port 12345
ffmpeg -f x11grab -video_size "$RESOLUTION" -i :1 -vf format=yuv420p -vcodec libx264 -f mpegts "udp://localhost:12345"

