#!/bin/bash

# Get the changes summary using git diff
changes=$(git diff --stat)

# Generate a simple commit message from the changes
commit_message="Updated files: $(echo "$changes" | awk '{print $1}' | tr '\n' ', ' | sed 's/, $//')"

# Git commands
git add .
git commit -m "$commit_message"
git push

echo "Changes have been pushed with message: '$commit_message'"
