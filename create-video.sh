#!/bin/bash
PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
FRAMERATE=50

if [[ -n "$1" ]]
then
    echo "Changing working directory to '$1'"
    cd $1
fi
echo "> ffmpeg -y -r $FRAMERATE -pattern_type glob -i './images/*_full.jpg' -c:v libx264 -pix_fmt yuv420p ./video/tajik2017-routes.mp4"
ffmpeg -y -r $FRAMERATE -pattern_type glob -i './images/*_full.jpg' -c:v libx264 -pix_fmt yuv420p ./video/tajik2017-routes.mp4

echo "> ffmpeg -y -r $FRAMERATE -pattern_type glob -i './images/*_small.jpg' -c:v libx264 -pix_fmt yuv420p ./video/tajik2017-routes_small.mp4"
ffmpeg -y -r $FRAMERATE -pattern_type glob -i './images/*_small.jpg' -c:v libx264 -pix_fmt yuv420p ./video/tajik2017-routes_small.mp4