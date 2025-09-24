#!/bin/bash

SCRIPT_NAME=$(basename "$0")

# Get repo name from git remote
REPO_URL=$(git config --get remote.origin.url)
REPO_NAME=$(basename -s .git "$REPO_URL")

# Extract costcenter and app name
if [[ "$REPO_NAME" =~ ^ki-gitops-(([a-zA-Z]{2}-){0,2}[A-Z]{2})-([a-zA-Z0-9]{1,9})$ ]]; then
  COSTCENTER="${BASH_REMATCH[1]}"
  APP="${BASH_REMATCH[3]}"
else
  echo "Error: Repository name '$REPO_NAME' does not match expected pattern 'ki-gitops-<costcenter>-<myapp>'"
  echo "  - <costcenter> must be: xx, xx-xx, or xx-xx-xx (capital letters, case-sensitive)"
  echo "  - <myapp> must be: 1–9 alphanumeric characters, no dashes"
  exit 1
fi

COSTCENTER_LOWER=$(echo "$COSTCENTER" | tr '[:upper:]' '[:lower:]')

# Confirm replacements
echo "Replacing <costcenter> with $COSTCENTER_LOWER"
echo "Replacing <COSTCENTER> with $COSTCENTER"
echo "Replacing <myapp> with $APP"

# Replace placeholders in file contents, excluding this script and files in .git/
find . -type f -not -path "./.git/*" -not -name "$SCRIPT_NAME" -exec sed -i \
  -e "s|<costcenter>|$COSTCENTER_LOWER|g" \
  -e "s|<COSTCENTER>|$COSTCENTER|g" \
  -e "s|<myapp>|$APP|g" {} +

# replace the placeholder of directory charts/<myapp>/ with the app name
if [ -d "charts/<myapp>" ]; then
  echo "Replacing directory name 'charts/<myapp>' with 'charts/$APP'"
  mv "charts/<myapp>" "charts/$APP"
else
  echo "Warning: Directory 'charts/<myapp>' does not exist, skipping rename."
fi

# replace the placeholder of directory argocd/<myapp>/ with the app name
if [ -d "argocd/<myapp>" ]; then
  echo "Replacing directory name 'argocd/<myapp>' with 'argocd/$APP'"
  mv "argocd/<myapp>" "argocd/$APP"
else
  echo "Warning: Directory 'argocd/<myapp>' does not exist, skipping rename."
fi

# move README_template.md to README.md
if [ -f "README_template.md" ]; then
  mv "README_template.md" "README.md"
  echo "Renaming README_template.md to README.md"
else
  echo "Warning: README_template.md does not exist, skipping rename."
fi

echo "Done!"
