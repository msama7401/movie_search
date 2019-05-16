#!/bin/bash

APIKEY=INVALID
OUTPUT=""

readconfig() {
    local CONFIG_FILE=$1
    local PARAM_NAME=$2

    if [[ $CONFIG_FILE != "" ]]; then
        if [ -f $CONFIG_FILE ]; then
            while IFS= read -r line
            do
                if [[ $line =~ ^$PARAM_NAME ]]; then
                    APIKEY=$(echo $line | awk -F '=' '{ print $2 }')
                fi 
            done < "$CONFIG_FILE"
        else 
            echo "No such config file $CONFIG_FILE"
            exit 1
        fi
    fi
}

getapidata() {
    local URL=$1
    OUTPUT=$(curl -s $URL 2>/dev/null)    
}

moviesearch() {

    if [ "x$1" == "x" ]; then
        echo "Missing Movie name command line parameter"
        exit 1
    fi

    MOVIE_NAME=$(urlencode $1)

    readconfig secret.api omdbapikey
     
    # echo $OUTPUT | python -mjson.tool
    getapidata "http://www.omdbapi.com/?apikey=$APIKEY&t=$MOVIE_NAME"

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

}


