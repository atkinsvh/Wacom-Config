#!/bin/bash

# Serve the HTML file using Python's built-in HTTP server
PORT=8765
python3 -m http.server $PORT
