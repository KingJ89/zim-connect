#!/bin/bash

# Function to start the backend server
start_backend() {
  echo "Starting backend server on port 3000..."
  nohup node server.js > backend.log 2>&1 &
  echo $! > backend_pid.txt
  echo "Backend server started."
}

# Function to start the frontend server
start_frontend() {
  echo "Starting frontend server on port 3001..."
  nohup npm start > frontend.log 2>&1 &
  echo $! > frontend_pid.txt
  echo "Frontend server started."
}

# Function to install and update dependencies
install_dependencies() {
  echo "Installing and updating dependencies..."
  npm install
  echo "Dependencies installed and updated."
}

# Function to push changes to GitHub with a random delay
push_to_github() {
  while true; do
    echo "Pushing updates to GitHub..."
    git add .
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    git commit -m "Auto commit at $TIMESTAMP"
    git push origin main
    SLEEP_TIME=$((RANDOM % 3 + 7)) # Random sleep between 7 and 9 minutes
    echo "Sleeping for $SLEEP_TIME minutes before the next push..."
    sleep ${SLEEP_TIME}m
  done
}

# Start backend and frontend servers
start_backend
start_frontend

# Install and update dependencies
install_dependencies

# Start pushing to GitHub
push_to_github

