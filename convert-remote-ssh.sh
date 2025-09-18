#!/bin/bash

# Get the current remote name (default: origin)
REMOTE_NAME=${1:-origin}

# Get the current HTTPS remote URL
REMOTE_URL=$(git remote get-url "$REMOTE_NAME")

# Check if the remote URL is HTTPS
if [[ "$REMOTE_URL" =~ ^https://([^/]+)/([^/]+)/(.+)\.git$ ]]; then
  HOST="${BASH_REMATCH[1]}"
  USER="${BASH_REMATCH[2]}"
  REPO="${BASH_REMATCH[3]}"
  SSH_URL="git@${HOST}:${USER}/${REPO}.git"

  # Remove the HTTPS remote
  git remote remove "$REMOTE_NAME"

  # Add the SSH remote with the same name
  git remote add "$REMOTE_NAME" "$SSH_URL"

  echo "Remote '$REMOTE_NAME' converted to SSH: $SSH_URL"
else
  echo "Remote '$REMOTE_NAME' does not use HTTPS or is not in the expected format."
  exit 1
fi