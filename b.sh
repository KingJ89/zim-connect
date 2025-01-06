#!/bin/bash

# Script to automate the creation of ZimConnect files incrementally with Git commits

# Function to log messages with timestamps
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Function to commit and push changes to GitHub
git_commit_push() {
    git add .
    git commit -m "$1"
    git push
}

# Function to write lines incrementally to a file
write_lines_with_commit() {
    local file_path=$1
    shift
    local commit_message_prefix=$1
    shift
    local delay=$1
    shift
    local lines=($(echo "$@" | tr '\n' '\0'))
    local count=0
    local increment=1

    for line in "${lines[@]}"; do
        echo -e "$line" >> "$file_path"
        count=$((count + increment))

        if (( count % 3 == 0 )); then
            commit_message="$commit_message_prefix: Added lines $(($count - 2))-$count"
            git_commit_push "$commit_message"
            sleep $delay
            increment=$((increment + 1))
        fi
    done
}

# Main execution
git init

log_message "Setting up project directories..."
mkdir -p frontend,tests
commit_message="Initialized project directories"
git_commit_push "$commit_message"
sleep 300

log_message "Creating .env file..."
cat <<EOT > .env
PORT=3000
API_URL=http://localhost:3000/api
GOOGLE_MAPS_API_KEY=YOUR_GOOGLE_MAPS_API_KEY
DB_USER=zimconnect
DB_PASSWORD=Jmutewera27
DB_NAME=zimconnect_db
EOT
commit_message="Added environment configuration file"
git_commit_push "$commit_message"
sleep 360

log_message "Creating frontend files incrementally..."
write_lines_with_commit "frontend/index.html" "Frontend HTML" 420 "<!DOCTYPE html>
<html lang=\"en\">
<head>
    <meta charset=\"UTF-8\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
    <title>ZimConnect E-commerce Platform</title>
    <link rel=\"stylesheet\" href=\"css/styles.css\">
    <script src=\"js/scripts.js\" defer></script>"

write_lines_with_commit "frontend/css/styles.css" "Frontend CSS" 300 "body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f4f4f4;
    color: #333;
}
header {
    background-color: #00843D;
    color: white;
    padding: 1rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
}"

