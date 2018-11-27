#!/bin/bash
directory='/var/www/infomat/app/webroot/video/';
PIDFILE=$directory"/"converting.pid

if [ -f $PIDFILE ]
then
        PID=$(cat $PIDFILE)
        ps -p $PID > /dev/null 2>&1
        if [ $? -eq 0 ]
        then
                echo "Job is already running"
                exit 1
        fi
fi

# Create PID file
echo $$ > $PIDFILE

# Check PID file exists
if [ -f $PIDFILE ]
then
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
	echo "DONE: "$t;
	rm $PIDFILE;
else
    echo 'Failed to start job'
fi