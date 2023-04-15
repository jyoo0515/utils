#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <input_file>"
    exit 1
fi

input_file=$1
# a regex pattern to match a word followed by an equals sign and a number
# e.g. "int32 id = 1"
regex_pattern='(\S+\s)\w+\s*=\s*\d+'

echo "=================================="
echo "Case converting for $input_file started"
echo "=================================="

if [ ! -f $input_file ]; then
    echo "Input file $input_file does not exist"
    exit 1
fi

# Copy file to new name
dir=$(dirname "${input_file}")
filename=$(basename "${input_file}")
extension="${filename##*.}"
filename="${filename%.*}"
new_filename="${filename}_new.${extension}"
cp $input_file "$dir/$new_filename"

matches=$(ggrep -oP "$regex_pattern" "$dir/$new_filename")

# Iterate matches line by line
while IFS= read -r match; do
    # Select the second word
    matched_word=$(echo "$match" | cut -d' ' -f2)
    if [[ $matched_word =~ [A-Z] ]]; then
        # Convert camelCase to snake_case
        snake_case=$(echo $matched_word | perl -pe 's/([a-z0-9])([A-Z])/$1_\L$2/g')
        # Replace matched word with snake_case
        sed -i "" "s/[[:<:]]$matched_word[[:>:]]/$snake_case/g" "$dir/$new_filename"
    fi
done <<< "$matches"

echo "=================================="
echo "Case converting for $input_file finished"
echo "=================================="