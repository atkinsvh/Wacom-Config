#!/bin/bash

# Ensure the HTML file is accessible
chmod +r index.html

# Serve the HTML file using Python's built-in HTTP server
PORT=8765
python3 -m http.server $PORT
echo "HTML served at http://192.168.1.41:$PORT"
