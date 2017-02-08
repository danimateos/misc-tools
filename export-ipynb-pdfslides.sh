#!/usr/bin/env bash

# Export all IPython notebooks in a folder to slide pdfs, using decktape.
# Not guaranteed to work on filenames with spaces

DECKTAPE_HOME=$1
FOLDER=$2 # Folder in which the notebooks live

out_folder="${FOLDER}/out"
mkdir -p $out_folder
    
for notebook in $FOLDER/*.ipynb;
do
    raw_filename=$(echo $notebook | rev | cut -d '/' -f 1 | rev)
    ## Serve the notebook
    jupyter nbconvert --to slides --post serve $notebook &
    # Remember pid to kill the server later
    pid=$!

    # Give the server time to, well, serve
    sleep 5s
    
    ## Export to pdf, using decktape
    # The ${string%substring} syntax removes a substring from the end of string.

    URL="http://127.0.0.1:8000/${raw_filename%.ipynb}.slides.html"

    out_file="$out_folder/${raw_filename%.ipynb}.pdf"
    echo "Serving $raw_filename at $URL and saving to $out_file"
    
    $DECKTAPE_HOME/phantomjs $DECKTAPE_HOME/decktape.js $URL $out_file
    kill $pid

done
          
