#!/bin/bash

# qBittorrent movie completion script
# Usage: ./qbittorrent-movie-completed.sh <FILE_NAME> <CATEGORY>

# Load environment variables
source "$(dirname "$0")/../.env"

# Check if correct number of arguments provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <FILE_NAME> <CATEGORY>"
    exit 1
fi

FILE_NAME="$1"
CATEGORY="$2"

# Process based on category
if [ "$CATEGORY" = "movie" ]; then
    echo "Processing movie: $FILE_NAME"
    DESTINATION_FOLDER="$VOLUME_MOVIE_FOLDER"
elif [ "$CATEGORY" = "show" ]; then
    echo "Processing show: $FILE_NAME"
    DESTINATION_FOLDER="$VOLUME_SHOWS_FOLDER"
else
    echo "Category is not 'movie' or 'show', skipping: $CATEGORY"
    exit 0
fi

# CheSonarrck if source file exists
if [ -e "$VOLUME_TORRENT_FOLDER/$FILE_NAME" ]; then
    # Create destination directory if it doesn't exist
    mkdir -p "$DESTINATION_FOLDER"

    # Move the file
    mv "$VOLUME_TORRENT_FOLDER/$FILE_NAME" "$DESTINATION_FOLDER/"

    if [ $? -eq 0 ]; then
        echo "Successfully moved $FILE_NAME to $DESTINATION_FOLDER"
    else
        echo "Error moving $FILE_NAME"
        exit 1
    fi
else
    echo "File not found: $VOLUME_TORRENT_FOLDER/$FILE_NAME"
    exit 1
fi
