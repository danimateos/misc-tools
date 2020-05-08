#!/usr/bin/env bash

VIDEO_FOLDER=$1 # Must be absolute path.
VIDEO_EXTENSION=$2

# Interesting discussion in stackexchange
# https://unix.stackexchange.com/questions/28803/how-can-i-reduce-a-videos-size-with-ffmpeg

# Really cool docker image by https://github.com/bennetimo
# https://coderunner.io/shrink-videos-with-ffmpeg-and-preserve-metadata/
# By default crf is 23. Higher is lower quality and vice versa. For gopro videos in my experience it results in quality that is almost indistinguishable and 4x - 10x smaller videos.
docker run -v $VIDEO_FOLDER:/vids bennetimo/shrinkwrap --input-extension $VIDEO_EXTENSION --ffmpeg-opts preset=fast /vids
