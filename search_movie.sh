#!/bin/bash

if [ "x$1" == "x" ]; then
    echo "Missing Movie name command line parameter"
    exit 1
fi

MOVIE_NAME=$(urlencode $1)
OUTPUT=$(curl -s "http://www.omdbapi.com/?apikey=6fa2f976&t=$MOVIE_NAME" 2>/dev/null)
# echo $OUTPUT | python -mjson.tool

# Check for blank output
if [ "x$OUTPUT" ==  "x" ]; then
    echo "No results from API endpoint"
    exit 1
fi

FOUND=$(echo $OUTPUT | grep -o -E '"Response":"False"' | awk -F ':' '{ print $2 }')
# echo "Found : $FOUND"
if [ "$FOUND" == "\"False\"" ]; then
    echo "Movie title $1 not found"
else 
    RT=$(echo $OUTPUT | grep -o -E '"Source":"Rotten Tomatoes","Value":"(.*?)%"' | awk -F ':' '{ print $3 }')
    if [ "x$RT" == "x" ]; then
        echo "Rotton tomatoes rating not found"
    else 
        echo "Rotton tomatoes rating $RT"
    fi
fi
# echo "Done"


