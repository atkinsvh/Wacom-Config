# Wacom-Config

# Screen Stream via WebSocket

This project captures the screen of a Pop!_OS computer and streams it to a web browser via WebSocket. The project consists of three main components:
1. `start_stream.sh`: A script that captures the screen using `x11vnc` and streams it via UDP using `ffmpeg`.
2. `screen_stream_server.py`: A WebSocket server that relays the UDP stream to connected WebSocket clients.
3. `index.html`: A web page that connects to the WebSocket server and displays the screen stream.

## Prerequisites

- Pop!_OS or any Linux distribution with X server
- `ffmpeg`
- `x11vnc`
- Python 3 with `websockets` library

## Setup and Installation

### Install Required Packages

```bash
sudo apt-get update
sudo apt-get install -y ffmpeg x11vnc python3-pip
pip3 install websockets
