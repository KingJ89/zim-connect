#!/bin/bash

# Function to generate a relevant commit message
generate_commit_message() {
  # Check for added, modified, or deleted files
  ADDED=$(git diff --cached --name-only --diff-filter=A)
  MODIFIED=$(git diff --cached --name-only --diff-filter=M)
  DELETED=$(git diff --cached --name-only --diff-filter=D)

  COMMIT_MESSAGE=""

  # Add details about added files
  if [ ! -z "$ADDED" ]; then
    COMMIT_MESSAGE+="Added: $(echo "$ADDED" | tr '\n' ', ' | sed 's/, $//'). "
  fi

  # Add details about modified files
  if [ ! -z "$MODIFIED" ]; then
    COMMIT_MESSAGE+="Modified: $(echo "$MODIFIED" | tr '\n' ', ' | sed 's/, $//'). "
  fi

  # Add details about deleted files
  if [ ! -z "$DELETED" ]; then
    COMMIT_MESSAGE+="Deleted: $(echo "$DELETED" | tr '\n' ', ' | sed 's/, $//'). "
  fi

  # Fallback if no changes are staged
  if [ -z "$COMMIT_MESSAGE" ]; then
    COMMIT_MESSAGE="Auto commit on $(date '+%Y-%m-%d %H:%M:%S')"
  fi

  echo "$COMMIT_MESSAGE"
}

# Check if a custom commit message is provided
if [ -z "$1" ]; then
  # Generate a meaningful commit message
  COMMIT_MESSAGE=$(generate_commit_message)
else
  # Use the provided commit message
  COMMIT_MESSAGE="$1"
fi

# Stage all changes
git add .

# Commit with the generated or provided message
git commit -m "$COMMIT_MESSAGE"

# Push to the default branch
git push origin "$(git rev-parse --abbrev-ref HEAD)"

# Success message
echo "Changes pushed to GitHub with commit message: '$COMMIT_MESSAGE'"

