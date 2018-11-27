#!/bin/bash
directory='/var/www/infomat/app/webroot/video/'
files=$(find $(directory) -type f -name "*.mp4")
for f in $files; 
	do
		ffmpeg -i $f ${f%.mp4}.mp4.webm;
		rm -f $f;
done 
