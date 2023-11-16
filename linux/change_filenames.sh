#!/bin/bash
#
# i found an interesting and peculiar way to do a find and replace action using bash
# and am noting it here for when forget and inevitably need it again
#
# azoth zephyr <azoth@zephyr.sx>

# Iterate through all files in the current directory
for file in bybit*; do
    # Check if the file starts with "bybit"
    if [[ $file == bybit* ]]; then
        # creates a new variable called new_file.
        # ---
        # ${file#bybit} is a parameter expansion that removes the prefix "bybit" from the value of $file. 
        # so, if $file is "bybit_auth.py", ${file#bybit} results in "_auth.py". Then, "cube" is prefixed to it,
        # resulting in new_file being "cube_auth.py".
        new_file="cube${file#bybit}"
        
        # Rename the file
        mv "$file" "$new_file"
        
        echo "Renamed $file to $new_file"
    fi
done