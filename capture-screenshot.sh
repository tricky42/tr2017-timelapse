#!/bin/bash
PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
CAPTURE_DELAY=10
FONT=AndaleMono


if [[ -n "$1" ]]
then
    echo "Changing working directory to '$1'"
    cd $1
fi

echo "*********************************"
echo "* Working Directory $(PWD)"
echo "*********************************"

mkdir -p ./temp #create temp directory
mkdir -p ./images #create images directory

echo "> http://event.gps-live-tracking.com/tajik-rally-2017 1920x1200 -d=$CAPTURE_DELAY --format=jpg --hide='#ilt-border' --hide='#partner-wrap' --filename='./temp/<%= date %> <%= time %> - Tajik 2017'"
pageres http://event.gps-live-tracking.com/tajik-rally-2017 1920x1200 -d=$CAPTURE_DELAY --format=jpg --hide='#ilt-border' --hide='#partner-wrap' --filename='./temp/<%= date %> <%= time %> - Tajik 2017'

#Sample file name: './temp/2017-09-07 18-16-50 - Tajik 2017.jpg'
cd temp
for filename in *2017.jpg; do
    if [ "$filename" != "*2017.jpg" ] ; then
        filename_full=${filename/'2017.jpg'/'2017_full.jpg'}
        filename_small=${filename/'2017.jpg'/'2017_small.jpg'}

        ts_date=${filename:0:10} #get timestamp
        ts_time=${filename:11:8}
        ts_time=${ts_time/-/:} 
        ts_time=${ts_time/-/:} #fix, seems this operation is only replacing once occurence 
        
        #full image, add timestamp
        echo '> convert "$filename" -font $FONT -pointsize 16 -fill black -annotate 0x0+5+15 "$ts_date $ts_time" "../images/$filename_full"'
        convert "$filename" -font $FONT -pointsize 16 -fill black -annotate 0x0+5+15 "$ts_date $ts_time" "../images/$filename_full"
        
        #small image, crop and add timestamp
        echo '> convert "$filename" -crop 1024x768+500+180 -font $FONT -pointsize 16 -fill white -annotate 0x0+505+195 "$ts_date $ts_time" "../images/$filename_small"'
        convert "$filename" -crop 1024x768+500+180 -font $FONT -pointsize 16 -fill white -annotate 0x0+505+195 "$ts_date $ts_time" "../images/$filename_small"

        echo '> mv "$filename" "../video/$filename"'
        mv "$filename" "../images/$filename"
    else
        echo "No file(s) to process!"    
    fi
done