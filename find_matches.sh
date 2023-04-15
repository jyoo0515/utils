#!/bin/bash

# Replace the regular expression and file path with your own values
regex='(\S+\s)\w+\s*=\s*\d+'
file_path='example.proto'

# Find all matches in the file using grep and the specified regular expression
matches=$(ggrep -oP "$regex" "$file_path")

# Print each match on a separate line
echo "$matches"

# Iterate matches line by line
while IFS= read -r match; do
    # Select the second word
    echo "$match" | cut -d' ' -f2
done <<< "$matches"