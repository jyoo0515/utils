#!/bin/bash

# Check if the path is provided as an argument
if [[ $# -eq 0 ]]; then
  echo "Usage: $0 path"
  exit 1
fi

# Get the path argument
path="$1"

# Find all files with ".proto" extension in the specified directory and its subdirectories
proto_files=$(find "$path" -name "*.proto")

# Loop through the list of files
for file in $proto_files; do
  # Run the case_converter (in place or new file) script on each file
  bash ./case_converter_in_place.sh "$file"
done
