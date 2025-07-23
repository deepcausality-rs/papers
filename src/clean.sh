#!/bin/bash

# Script to remove files with extensions .log .dvi .gz .aux .out from EPP subdirectories
# Usage: ./clean.sh

# Check if EPP directory exists
if [ ! -d "EPP" ]; then
    echo "Error: EPP directory not found in current location"
    echo "Current directory: $(pwd)"
    exit 1
fi

echo "Cleaning files from EPP subdirectories..."
echo "Removing files with extensions: .log .dvi .gz .aux .out"
echo

# Initialize counter for removed files
removed_count=0

# Extensions to remove
extensions=("*.log" "*.dvi" "*.gz" "*.aux" "*.out")

# Traverse EPP directory and remove files with specified extensions
for ext in "${extensions[@]}"; do
    echo "Looking for $ext files..."
    
    # Find and remove files with current extension
    while IFS= read -r -d '' file; do
        echo "Removing: $file"
        rm "$file"
        ((removed_count++))
    done < <(find EPP -type f -name "$ext" -print0 2>/dev/null)
done

echo
echo "Cleanup complete! Removed $removed_count files total."
