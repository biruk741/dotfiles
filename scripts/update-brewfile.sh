#!/bin/bash
# Update Brewfile with currently installed packages

cd ~/.local/share/chezmoi

echo "Updating Brewfile..."
brew bundle dump --force --describe

echo "Updated Brewfile!"
echo ""
echo "Review changes with: git diff Brewfile"
echo "Commit with: git add Brewfile && git commit -m 'Update Brewfile'"
