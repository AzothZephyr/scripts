#!/bin/bash
#
# this does find and replace but applies to instances of the value your are replacing
# being in the middle of a word.
#
# azoth zephyr <azoth@zephyr.sx>
#

# Iterate through all files in the current directory
for file in *; do
    # Check if "bybit" is present in the filename
    if [[ $file == *bybit* ]]; then
        # Generate the new filename by replacing "bybit" with "cube"
        new_file="${file//bybit/cube}"
        
        # Rename the file
        mv "$file" "$new_file"
        
        echo "Renamed $file to $new_file"
    fi
done

