#!/bin/bash

# Check if a commit message argument is provided
if [ -z "$1" ]; then
  # Generate a unique commit message with date and time
  COMMIT_MESSAGE="Auto commit on $(date '+%Y-%m-%d %H:%M:%S')"
else
  # Use the provided commit message
  COMMIT_MESSAGE="$1"
fi

# Stage all changes
git add .

# Commit with the unique message
git commit -m "$COMMIT_MESSAGE"

# Push to the default branch
git push origin "$(git rev-parse --abbrev-ref HEAD)"

# Success message
echo "Changes pushed to GitHub with commit message: '$COMMIT_MESSAGE'"

