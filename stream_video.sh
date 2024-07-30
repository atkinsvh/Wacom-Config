#!/bin/bash

gst-launch-1.0 -v autovideosrc ! videoconvert ! x264enc tune=zerolatency bitrate=500 speed-preset=superfast ! video/x-h264,profile=baseline ! h264parse ! flvmux ! queue ! rtmpsink location='rtmp://localhost/live/stream'
