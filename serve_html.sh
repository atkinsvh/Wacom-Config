#!/bin/bash
# serve_html.sh

# Ensure the HTML file is accessible
chmod +x index.html

# Serve the HTML file using Python's built-in HTTP server
PORT=8765
python3 -m http.server --bind 192.168.1.41 $PORT
echo "HTML served at http://192.168.1.41:$PORT"
