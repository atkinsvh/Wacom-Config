#!/bin/bash

# Stream the display using GStreamer
gst-launch-1.0 -v avfvideosrc device-index=0 ! video/x-raw,framerate=30/1 ! videoconvert ! vp8enc ! webmmux ! tcpserversink host=192.168.1.41 port=5000
