#!/usr/bin/env bash

files=$1

# Required for filenames with spaces
OIFS="$IFS"
IFS=$'\n'

for container in $files
do
    for file in $(tar -tzf $container | grep ".html")
    do
        echo "$container, $file, $(tar -xOzf $container $file | tr '>' '\n' | grep '<article' | wc -l)"
    done
done

IFS="$OIFS"
