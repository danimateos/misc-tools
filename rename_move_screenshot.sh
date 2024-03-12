#!/bin/env bash


# Move 

INPUT_FILE=$1
ANNOTATION=$2

FILENAME=$(echo $INPUT_FILE | rev | cut -d '/' -f 1 | rev | tr ' ' '_')
NEW_FILENAME=${FILENAME::${#FILENAME}-4}"_$ANNOTATION".jpg
INTERMEDIATE="raw_images/$NEW_FILENAME"
OUT="docs/assets/images/$NEW_FILENAME"

# https://stackoverflow.com/questions/27658675/how-to-remove-last-n-characters-from-a-string-in-bash
# ${v::${#v}-4}

cp "$INPUT_FILE" $INTERMEDIATE

# From https://www.smashingmagazine.com/2015/06/efficient-image-resizing-with-imagemagick/ :
convert $INTERMEDIATE -filter Triangle -define filter:support=2 -thumbnail 1800 -unsharp 0.25x0.25+8+0.065 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB -strip $OUT


