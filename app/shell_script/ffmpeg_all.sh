#!/bin/bash

directory='/var/www/infomat/app/webroot/video/';
cd $directory;
files=$(find $(directory) -type f -name "*.mp4");

echo "Files list: "$files; 
# Run converting
for f in $files;
	do
	echo "Converting file: "$f; 
	ffmpeg -i $f ${f%.mp4}.mp4.webm;
	echo "Removing file: "$f;
	rm -f $f;
done

t=$(date '+%d/%m/%Y %H:%M:%S');
echo "DONE: "$t