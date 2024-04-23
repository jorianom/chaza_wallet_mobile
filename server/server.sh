#!/bin/bash

# Welcome
echo 'Server start'

# Set the port
PORT=9000

# Kill anything that is already running on that port by ash
echo 'Cleaning our port' $PORT '...'
fuser -k 9000/tcp

# Change directories to the release folder
cd build/web/

# Start the server
echo 'Starting server on port by ' $PORT '...'
python3 -m http.server $PORT

# Exit
echo 'Server stopped'