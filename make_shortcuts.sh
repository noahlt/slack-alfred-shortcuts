#!/bin/bash

# Check if input file was provided
if [ $# -ne 1 ]; then
    INPUT_FILE="shortcut_definitions.txt"
else
    INPUT_FILE="$1"
fi

# Check that the input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file '$INPUT_FILE' does not exist."
    exit 1
fi

OUTPUT_DIR="$HOME/shortcuts"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Read the input file line by line
while IFS= read -r line || [ -n "$line" ]; do
    # Skip empty lines
    [ -z "$line" ] && continue

    # Split the line into keyword and URL
    keyword=$(echo "$line" | awk '{print $1}')
    web_url=$(echo "$line" | cut -d' ' -f2-)

    # Skip if either keyword or URL is missing
    if [ -z "$keyword" ] || [ -z "$web_url" ]; then
        echo "Warning: Invalid line: $line"
        continue
    fi

    # Extract team ID and channel/user ID from the web URL
    if [[ $web_url =~ client/([^/]+)/([^/]+) ]]; then
        team_id="${BASH_REMATCH[1]}"
        id="${BASH_REMATCH[2]}"

        # Determine if this is a channel or DM based on the ID prefix
        if [[ $id == D* ]]; then
            # This is a DM
            deep_link="slack://user?team=${team_id}&id=${id}"
            type="DM"
        else
            # This is a channel
            deep_link="slack://channel?team=${team_id}&id=${id}"
            type="channel"
        fi

        # Create the .webloc file using AppleScript
        webloc_file="$OUTPUT_DIR/${keyword}.webloc"

        # Use AppleScript to create a proper .webloc file
        osascript << EOF
tell application "Finder"
    set myFile to make new internet location file at POSIX file "$OUTPUT_DIR" to "$deep_link" with properties {name:"$keyword"}
end tell
EOF

        echo "Created: $webloc_file for $keyword ($type: $deep_link)"
    else
        echo "Warning: Could not parse Slack URL: $web_url"
    fi

done < "$INPUT_FILE"

echo "Done! All .webloc files have been created in $OUTPUT_DIR"
